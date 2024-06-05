<?php

// Purpose: Create MoveAnimTbl_ structures
// ==============================

require "lib/common.php";

if (!file_exists("tempconv.txt")) {
	die("can't find tempconv.txt");
}

print "Converting data...".PHP_EOL;

$h = fopen("tempconv.asm", 'w');

$lines = file("tempconv.txt");
for ($i = 0; $i < count($lines);) {


	if (strpos($lines[$i], "MoveAnimTbl_") !== 0) {
		fwrite($h, "\r\n".trim($lines[$i]));
		++$i;
		continue;
	}

	$base_label = get_label($lines[$i]);
	$char_id = get_move_char_id($base_label);
	$b = "\r\n{$base_label}:";
	for ($j = 0; $j < count(MOVES_POOL); $j++) {
		$unused_marker = strpos($lines[$i], ";X") !== false ? " ;X" : "";
		$bank = get_db($lines[$i++]);
		$obj_low = get_db($lines[$i++]);
		$obj_high = get_db($lines[$i++]);
		$target = get_db($lines[$i++]);
		$speed = get_db($lines[$i++]);
		$damage = get_db($lines[$i++]);
		$hitanimraw = get_db($lines[$i++]);
		if (!isset(HIT_ANIMS[hexdec($hitanimraw)])) {
			print "Warning: $hitanimraw\r\n";
			$hitanim = '$'.$hitanimraw;
		} else {
			$hitanim = HIT_ANIMS[hexdec($hitanimraw)];
		}
		$flags = generate_const_label(get_db($lines[$i++]), PLFLAGS3);
		$movedesc = " ; ".get_move_name_from_tbl($j, $char_id);

		if (!$j) {
			$b .= "\r\n\tdb \${$bank}, \${$obj_low}, \${$obj_high}, \${$target}, \${$speed}, \${$damage}, {$hitanim}, {$flags}$unused_marker$movedesc";
		} else {
			$fullptr = "L{$bank}{$obj_high}{$obj_low}";
			// HACK HACK
			//if ($fullptr == "L094EAE")
			//	$fullptr = "OBJLstPtrTable_Terry_WinA";

			$b .= "\r\n\tmMvAnDef $fullptr, \${$target}, \${$speed}, \${$damage}, {$hitanim}, {$flags}$unused_marker ; BANK \${$bank}$movedesc";

		}

	}
	print "Last of set was ".get_label($lines[$i-1])."\r\n";
	fwrite($h, $b);
}
fclose($h);