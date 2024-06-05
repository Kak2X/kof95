<?php

// Purpose: Create OBJLstPtrTable_ structures
// ==============================


require "lib/common.php";

const FMT_95 = 0;
const FMT_96 = 1;

const MAPPINGS_FORMAT = FMT_95;
const AUTONAME = true;

if (!file_exists("tempconv.txt")) {
	die("can't find tempconv.txt");
}
//const DELIM = "L";
//const DELIMN = 0;

print "Converting data...".PHP_EOL;

$tmpfile = "";

$lines = file("tempconv.txt");

if (count($lines) > 0)
	$banknum = substr($lines[1], 1, 2);

$objlst_a = [];
$objlst_b = [];
$objdata = [];
$objdata_flags = [];

$obj_names = [];
$data_ptrs = [];



for ($i = 0; $i < count($lines);) {

	$base_label = get_label($lines[$i]);
	if (in_array($base_label, $objdata)) {
		print "O hit: $base_label\r\n";
		$b = objdata_parse($base_label, $lines, $i, $objdata_flags[$data_ptr]);
	} else if (in_array($base_label, $objlst_a)) {		
		print "A hit: $base_label\r\n";
		$unused_marker = strpos($lines[$i], ";X") !== false ? " ;X" : "";
		

		if (isset($obj_names[$base_label]))
			$base_label = $obj_names[$base_label];
		$label = "OBJLstHdrA_".$base_label;
		
		$flags_numeric = get_db($lines[$i++]);
		$usexy = MAPPINGS_FORMAT == FMT_95 || (hexdec($flags_numeric) & OLF_USETILEFLAGS);
		$flags = generate_const_label($flags_numeric, OBJLST_FLAGS);
		$byte1 = get_db($lines[$i++]);
		$byte2 = get_db($lines[$i++]);
		$gfx_low = get_db($lines[$i++]);
		$gfx_high = get_db($lines[$i++]);
		$gfx_bank = get_db($lines[$i++]);
		$data_low = get_db($lines[$i++]);
		$data_high = get_db($lines[$i++]);
		if (MAPPINGS_FORMAT > FMT_95)
			$xoff = get_db($lines[$i++]);
		$yoff = get_db($lines[$i++]);
		
		if ($gfx_bank == "FF" && $gfx_high == "FF" && $gfx_low == "FF")
			$gfx_ptr = "db \$FF,\$FF,\$FF";
		else if ($gfx_bank == "00" && $gfx_high == "00" && $gfx_low == "00")
			$gfx_ptr = "db \$00,\$00,\$00";
		else
			$gfx_ptr = "dpr L{$gfx_bank}{$gfx_high}{$gfx_low}";
		
		$data_ptr = "L{$banknum}{$data_high}{$data_low}";
		if (get_label($lines[$i]) == $data_ptr) {
			$data_ptrs[$data_ptr] = $label;
			$data_ptr = ".bin";
			$objinfo = objdata_parse($data_ptr, $lines, $i, mkflags($usexy));
		} else {
			$objinfo = "";
			$objdata[] = $data_ptr;
			$objdata_flags[$data_ptr] = mkflags($usexy);
			// Backbuffer only
			if (isset($data_ptrs[$data_ptr])) {
				print "-> Far Buffer: $data_ptr\r\n";
				$data_ptr = $data_ptrs[$data_ptr].".bin";
			}	
		}
		
		$hitbox_id = $byte2 == "00" ? "\$00" : "COLIBOX_{$byte2}";
		
		$b = "{$label}:{$unused_marker}
	db {$flags} ; iOBJLstHdrA_Flags
	db COLIBOX_{$byte1} ; iOBJLstHdrA_ColiBoxId
	db {$hitbox_id} ; iOBJLstHdrA_HitboxId
	{$gfx_ptr} ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw {$data_ptr} ; iOBJLstHdrA_DataPtr".
	(MAPPINGS_FORMAT > FMT_95 ? "
	db \${$xoff} ; iOBJLstHdrA_XOffset" : "")."
	db \${$yoff} ; iOBJLstHdrA_YOffset";
		if ($objinfo)
			$b .= "
{$objinfo}";	
	} else if (in_array($base_label, $objlst_b)) {
		print "B hit: $base_label\r\n";
		$unused_marker = strpos($lines[$i], ";X") !== false ? " ;X" : "";
		
		if (isset($obj_names[$base_label]))
			$base_label = $obj_names[$base_label];
		$label = "OBJLstHdrB_".$base_label;
		
		$flags_numeric = get_db($lines[$i++]);
		$usexy = MAPPINGS_FORMAT == FMT_95 || (hexdec($flags_numeric) & OLF_USETILEFLAGS);
		$flags = generate_const_label($flags_numeric, OBJLST_FLAGS);
		$gfx_low = get_db($lines[$i++]);
		$gfx_high = get_db($lines[$i++]);
		$gfx_bank = get_db($lines[$i++]);
		$data_low = get_db($lines[$i++]);
		$data_high = get_db($lines[$i++]);
		if (MAPPINGS_FORMAT > FMT_95)
			$xoff = get_db($lines[$i++]);
		$yoff = get_db($lines[$i++]);
		
		if ($gfx_bank == "FF" && $gfx_high == "FF" && $gfx_low == "FF")
			$gfx_ptr = "db \$FF,\$FF,\$FF";
		else if ($gfx_bank == "00" && $gfx_high == "00" && $gfx_low == "00")
			$gfx_ptr = "db \$00,\$00,\$00";
		else
			$gfx_ptr = "dpr L{$gfx_bank}{$gfx_high}{$gfx_low}";
		
		$data_ptr = "L{$banknum}{$data_high}{$data_low}";
		
		if (get_label($lines[$i]) == $data_ptr) {
			$data_ptrs[$data_ptr] = $label;
			$data_ptr = ".bin";
			$objinfo = objdata_parse($data_ptr, $lines, $i, mkflags($usexy));
		} else {
			$objinfo = "";
			$objdata[] = $data_ptr;
			$objdata_flags[$data_ptr] = mkflags($usexy);
			// Backbuffer only
			if (isset($data_ptrs[$data_ptr])) {
				print "-> Far Buffer: $data_ptr\r\n";
				$data_ptr = $data_ptrs[$data_ptr].".bin";
			}
		}
		
		$b = "{$label}:{$unused_marker}
	db {$flags} ; iOBJLstHdrA_Flags
	{$gfx_ptr} ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
	dw {$data_ptr} ; iOBJLstHdrA_DataPtr".
	(MAPPINGS_FORMAT > FMT_95 ? "
	db \${$xoff} ; iOBJLstHdrA_XOffset" : "")."
	db \${$yoff} ; iOBJLstHdrA_YOffset";
		if ($objinfo)
			$b .= "
{$objinfo}";

	} else if (strpos($lines[$i], "OBJLstPtrTable_") === 0) {
		$label = ""; //$base_label;
		
		//$obj_name = substr($label, 15);
		
		//$chcount = get_db($lines[$i]);
		
		$b = ""; //"{$label}:";
		$j = 0;
		while ($i < count($lines)) {
			
			
			// Some OBJLstPtrTables don't have end separators and fall-through.
			// Account for those by constantly checking if we're over a new OBJLstPtrTable_ label.
			if (strpos($lines[$i], "OBJLstPtrTable_") === 0) {
				$newlabel = get_label($lines[$i]);
				if ($newlabel != $label) {
					$label = $newlabel;
					$obj_name = substr($label, 15);
					$b .= "\r\n{$label}:";
				}
			}


			$header_a_low = get_db($lines[$i++]);
			$header_a_high = get_db($lines[$i++]);
			
			if ($header_a_high == "FF") {
				// End of the OBJLst
				$b .= "
	dw OBJLSTPTR_NONE";
				break;
			}
			
			// Only here, since it doesn't count for the end separator
			$unused_marker = strpos($lines[$i-2], ";X") !== false ? " ;X" : "";
			
			$header_b_low = get_db($lines[$i++]);
			$header_b_high = get_db($lines[$i++]);
			
			$header_a_basename = "L{$banknum}{$header_a_high}{$header_a_low}";
			if (AUTONAME) {
				$newname = $obj_names[$header_a_basename] ?? $obj_name.$j.($header_b_high == "FF" ? "" : "_A");
				$obj_names[$header_a_basename] = $newname;
				$objlst_a[] = $header_a_basename;
				$header_a_basename = $newname;
			} else {
				$objlst_a[] = $header_a_basename;
			}			
			$header_a_merged = "OBJLstHdrA_".$header_a_basename;
			
			
			
			if ($header_b_high == "FF") {
				$header_b_merged = "OBJLSTPTR_NONE";
			} else {
				$header_b_basename = "L{$banknum}{$header_b_high}{$header_b_low}";
				if (AUTONAME) {
					$newname = $obj_names[$header_b_basename] ?? $obj_name.$j."_B";
					$obj_names[$header_b_basename] = $newname;
					$objlst_b[] = $header_b_basename;
					$header_b_basename = $newname;
				} else {
					$objlst_b[] = $header_b_basename;
				}
				$header_b_merged = "OBJLstHdrB_".$header_b_basename;
			}
			
			$b .= "
	dw {$header_a_merged}, {$header_b_merged}{$unused_marker}";
			$j++;
		}
	} else {
		$tmpfile .= $lines[$i];	
		$i++;
		continue;
	}
	
		$b .= "
		
";
		
		$tmpfile .= $b;	
	
	
}

print "Final pass...";
foreach ($data_ptrs as $k => $v) {
	$tmpfile = str_replace("\tdw $k", "\tdw $v.bin", $tmpfile);
}

file_put_contents("tempconv.asm", $tmpfile);


function mkflags($usexy) {
	return ['usexy' => $usexy];
}

function objdata_parse($data_ptr, $lines, &$i, $flags) {
	$unused_marker = strpos($lines[$i], ";X") !== false ? " ;X" : "";
	$objcount = get_db($lines[$i++]);
			
	$objinfo = "{$data_ptr}:{$unused_marker}
	db \${$objcount} ; OBJ Count
	;    Y   X  ID".($flags['usexy'] ? "+FLAG" : "");
			
	for ($j = 0, $max = hexdec($objcount); $j < $max; $j++) {
		$y = get_db($lines[$i++]);
		$x = get_db($lines[$i++]);
		$f = get_db($lines[$i++]);
		
		// If xy flags are used, get them from the upper bits
		if ($flags['usexy']) {
			$fnum = hexdec($f);
			$zflags = dechex($fnum & 0xC0);
			$tileid = fmthexnum($fnum & 0x3F);
			
			$strflags = generate_const_label($zflags, OBJLST_ROMFLAGS);
			$f = $tileid.($strflags != '$00' ? "|".$strflags : "");
		}
		
		$objinfo .= "
	db \${$y},\${$x},\${$f} ; \$".fmthexnum($j);
	}
	
	return $objinfo;
}