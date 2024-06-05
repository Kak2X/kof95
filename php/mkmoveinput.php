<?php

// Purpose: Create MoveInput_* structure
// ==============================

require "lib/common.php";

const JOYKEY = [
	0 => 'KEY_RIGHT',
	1 => 'KEY_LEFT',
	2 => 'KEY_UP',
	3 => 'KEY_DOWN',
	4 => 'KEY_A',
	5 => 'KEY_B',
	6 => 'KEY_SELECT',
	7 => 'KEY_START',
];

const KEP = [
	4 => 'KEP_A_LIGHT',
	5 => 'KEP_B_LIGHT',
	6 => 'KEP_A_HEAVY',
	7 => 'KEP_B_HEAVY',
];

list($input, $output) = inout();
$target	= 0;
$b		= [];
$out	= "";
foreach (dbify($input) as $x) {
	
	if (!$target) {
		$out .= "

{$x[0]}:
	db \${$x[1]}         ; Number of inputs";
		$target = hexdec($x[1]) * 4;
		$b = [];
	} else {
		$b[] = $x[1];
	}
	
	if (count($b) == $target) {
		for ($i = 0, $g = $target / 4; $i < $target; $i += 4, $g--) {
			$out .= "
.i{$g}:
	db ".generate_const_label($b[$i+0], JOYKEY)."    ; Key
	db ".generate_const_label($b[$i+1], JOYKEY)."    ; Include
	db \$".($b[$i+2])."         ; Min len
	db \$".($b[$i+3])."         ; Max len";
		}
		$target = 0;
	}
}

file_put_contents($output, $out);

die("OK");