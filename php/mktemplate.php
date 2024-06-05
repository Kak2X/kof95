<?php

// Purpose: Create generic repeatable structures
// ==============================

require "lib/common.php";

//foreach (CHAR_NAMES as $char_id => $x) {
//	foreach (MOVES_POOL as $move_id => $y)
//		if ($move_id >= MOVEGROUP_ATTACKSPEC_START && $move_id <= MOVEGROUP_ATTACKSPEC_END)
//			print str_pad(get_move_name_from_tbl($move_id, $char_id), 40)." EQU \$".sprintf("%02X", $move_id * 2)."\r\n";
//	print "\r\n";
//}
//die;

$JOYKEY = [
	0 => 'KEY_RIGHT',
	1 => 'KEY_LEFT',
	2 => 'KEY_UP',
	3 => 'KEY_DOWN',
	4 => 'KEY_A',
	5 => 'KEY_B',
	6 => 'KEY_SELECT',
	7 => 'KEY_START',
];

$CHARID = CHAR_NAMES;

$KEP = [
	4 => 'KEP_A_LIGHT',
	5 => 'KEP_B_LIGHT',
	6 => 'KEP_A_HEAVY',
	7 => 'KEP_B_HEAVY',
];

	
const TEMPLATE = '	; CHAR_ID_{i}
	dw L1C{1}{0} ; Source text data ptr
	dw ${3}{2} ; Destination tilemap ptr
	db ${4} ; Width
	db ${5} ; Height
	dw ${6}{7} ; Padding
	
';

/*
const TEMPLATE = '	; XXXXX -> XXXXXXXXXXXXX
	dw L00{1}{0}
	db {2:KEP}
	db {3:KEP}

';

// Stage Def
const TEMPLATE = '	; STAGE {i}
	db BANK(L{0}{2}{1}) ; BANK ${0}
	dw L{0}{2}{1}
	dw L{0}{4}{3}
	db SCRPAL_{5}
	db ${6} 
	db ${7}

';
*/


// Detect every "{<num>}" including optional parameters after the :
// 1 => number
// 2 => parameters, if any

// These are replaced with simpler placeholder replaceable by a str_replace.

$fn_exec = [];
$i = 0;
$template_fixed = preg_replace_callback('/{(\d+)(?::([\w_]+))?+}/', function($matches) use(&$fn_exec, &$i) {
	$num  = $matches[1];
	$args = $matches[2] ?? null;
	
	if ($args === null) {
		$exec = null;
	} else {
		$exec = function($x) use ($args) {
			return generate_const_label($x, $GLOBALS[$args]);
		};
	}
	
	$fn_exec[] = [$num, $exec];
	
	return '{'.$i++.'}';
}, TEMPLATE);

// Detect number of parameters in template, if not defined
if (!defined('TEMPLATE_ARG_COUNT')) {
	define('TEMPLATE_ARG_COUNT', max(array_column($fn_exec, 0)) + 1);
}

print "TEMPLATE_ARG_COUNT is ".TEMPLATE_ARG_COUNT.PHP_EOL;

list($input, $output) = inout();
$out = "";
$buf = [];
foreach (dbify($input, true) as $x) {
	// This requires the label to not fall between the template
	if ($x[0])
		$out .= "{$x[0]}:\r\n";
	
	$buf[] = $x[1];
	if (count($buf) == TEMPLATE_ARG_COUNT) {
		$bstr = $template_fixed;
		
		foreach ($fn_exec as $i => $exec) {
			$db = $buf[$exec[0]];
			$bstr = str_replace('{'.$i.'}', $exec[1] !== null ? $exec[1]($db) : $db, $bstr);
		}
		$out .= $bstr;
		$buf = [];
	}
}

file_put_contents($output, $out);

die("OK");