<?php

// Purpose: Generate strtr.php lines for object moves
// ==============================

require "lib/common.php";

const MAPS = [
	'Chargemeter' => 'ChargeMeter',
	'Hitlow' => 'HitLow',
	'_Ub' => '_UB',
	'_Db' => '_DB',
	
    'Punch_Ln' => 'Punch_LN',
    'Punch_Hn' => 'Punch_HN',
    'Punch_Lm' => 'Punch_LM',
    'Punch_Hm' => 'Punch_HM',
    'Kick_Ln'  => 'Kick_LN' ,
    'Kick_Hn'  => 'Kick_HN' ,
    'Kick_Lm'  => 'Kick_LM' ,
    'Kick_Hm'  => 'Kick_HM' ,
    'Punch_Cl' => 'Punch_CL',
    'Punch_Ch' => 'Punch_CH',
    'Kick_Cl'  => 'Kick_CL' ,
    'Kick_Ch'  => 'Kick_CH' ,
	
	'Kick_Ali' => 'Kick_ALI',
	'Punch_Ali' => 'Punch_ALI',
	'_Ahx' => '_AHX',
	
];

$out	= "";
$charid = -0x02;
$moveid = 0x00;

$repl = [];
foreach (pretty_file("src/bank05.asm") as $x) {
	
	$label = get_label($x);
	if (str_starts_with($label, "MoveAnimTbl_")) {
		$charid++; // = explode("_", $label, 2)[1];
		$moveid = 1;
	} else if (str_starts_with($x, "mMvAnDef")) {
		$args = explode(" ", $x);
		// mMvAnDef L084020, $08, $02, $00, $00, $00 ; BANK $08 ; MOVE_SHARED_WALK_B
		$target = substr($args[1], 0, -1);
		if (!isset($repl[$target])) {
			$move = get_move_name_from_tbl($moveid, $charid, true);
			$repl[$target] = strtr(ucwords(strtolower($move), "_0123456789"), MAPS); // Autocase
			
		}
		$moveid++;
	}
}

foreach ($repl as $src => $dest) {
	print "\t'{$src}' => '{$dest}',\r\n";
}
