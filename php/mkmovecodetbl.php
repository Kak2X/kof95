<?php

// Purpose: Create MoveCodePtrTbl_ structures
// ==============================

require "lib/common.php";

if (!file_exists("tempconv.txt")) {
	die("can't find tempconv.txt");
}

print "Converting data...".PHP_EOL;

$h = fopen("tempconv.asm", 'w');
$lines = file("tempconv.txt");


$b = "";
$id = $char_id = 0; // Running move ID
for ($i = 0; $i < count($lines); $id++) {

	if (strpos($lines[$i], "MoveCodePtrTbl_") === 0) {
		$base_label = get_label($lines[$i]);
		$char_id = get_move_char_id($base_label);
		$id = 0;
		$b .= "\r\n{$base_label}:";
	}
	
	if ($id == count(MOVES_POOL)) {
		print "Ended at: ".get_label($lines[$i]);
		break;
	}
		

	$movename = get_move_name_from_tbl($id, $char_id);
	$unused_marker = strpos($lines[$i], ";X") !== false ? " ;X" : "";
	$obj_low = get_db($lines[$i++]);
	$obj_high = get_db($lines[$i++]);
	$bank = get_db($lines[$i++]);
	$i++;
	$fullptr = "L{$bank}{$obj_high}{$obj_low}";
	$b .= "\r\n\tmMvCodeDef $fullptr$unused_marker ; BANK \${$bank} ; $movename";
	
	//print "Last of set was ".get_label($lines[$i-1])."\r\n";

}
fwrite($h, $b);
fclose($h);