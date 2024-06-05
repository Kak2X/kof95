<?php

const DEFAULT_INPUT_FILE = "tempconv.txt";
const DEFAULT_OUTPUT_FILE = "tempconv.asm";

require "defines.php";

chdir("..");


//--

function inout() {
	global $argc, $argv;
	
	$input = $argv[1] ?? DEFAULT_INPUT_FILE;
	$output = $argv[2] ?? DEFAULT_OUTPUT_FILE;
	
	if (!file_exists($input)) 
		die("Can't find '{$input}'");
	
	return [$input, $output];
}

function dbify($path, $no_data_labels = false) {
	foreach (pretty_file($path) as $ln) {
		$label = get_label($ln);
		$val = get_db($ln);
		if ($no_data_labels && $ln && $ln[0] == 'L' && strlen($label) == 7) // Dumb detection, but should work for us
			$label = null;
		yield [$label, $val];
	}
}

function pretty_file($path) {
	$h = fopen($path, 'r');
	while (($line = fgets($h)) !== false)
		if ($ln = trim($line))
			yield $ln;
	fclose($h);
}

//---

function get_label($line) {
	$sep = strpos($line, ":");
	$x = substr($line, 0, $sep);
	return $x;
}

function get_db($line, $id = null) {
	if ($id !== null) {
		$line = $line[$id];
	}
	$sep = strpos($line, ":");
	if ($sep === false)
		return false;
	$x = substr($line, $sep + strlen(": db \$"), 2);
	return $x;
}

function get_dw($line, $id = null) {
	return get_db($line, $id+1).get_db($line, $id);
}

function generate_const_label($strdb, $map) {
	$val = hexdec($strdb);
	$res = "";
	foreach ($map as $k => $lbl) {
		if ($val & (1 << $k)) {
			$res .= ($res ? "|" : "").$lbl;
			//$val ^= (1 << $k); // Remove bit
		}
	}
	//if ($val)
	//	$res = ($res ? "{$res}" : "") ""
	if (!$res)
		return "\$00";
	return $res;
}

function get_move_char_id($base_label) {
	// Determine character table
	$charname = strtoupper(explode("_", $base_label, 2)[1]);
	print $charname."\r\n";
	$charid = array_search($charname, CHAR_NAMES, true);
	if ($charid === false)
		die("not found! $charname");
	
	return $charid;
}

function get_move_name_from_tbl($move_id, $char_id, $full_mode = false) {
	$is_spec = ($move_id >= MOVEGROUP_ATTACKSPEC_START && $move_id <= MOVEGROUP_ATTACKSPEC_END);
	if (!$full_mode) {
		$charname = $is_spec ? CHAR_NAMES[$char_id] : "SHARED";
		return "MOVE_".$charname."_".MOVES_POOL[$move_id];
	} else {
		$movename = $is_spec ? MOVES_CHAR[$char_id][$move_id-MOVEGROUP_ATTACKSPEC_START] : MOVES_POOL[$move_id];
		return "MOVE_".CHAR_NAMES[$char_id]."_".$movename;
	}
}

function fmthexnum($dec, $digits = 2) {
	return str_pad(strtoupper(dechex($dec)), $digits, "0", STR_PAD_LEFT);
}