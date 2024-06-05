<?php

// Purpose: Generate strtr.php lines for object moves
// ==============================

require "lib/common.php";

$repl = [];
$curlabel = "";
foreach (["src/bank07.asm"] as $path) // 8.asm", "src/bank09.asm", "src/bank0A
foreach (pretty_file($path) as $x) {
	$label = get_label($x);
	if (str_starts_with($label, "OBJLstHdrB_") || str_starts_with($label, "OBJLstHdrA_")) {
		$curlabel = explode("_", $label, 2)[1];
	} else if (str_starts_with($x, "dpr")) {
		$args = explode(" ", $x);
		// dpr L196960 ; iOBJLstHdrA_GFXPtr + iOBJLstHdrA_GFXBank
		$target = $args[1]; 
		if (!isset($repl[$target])) {
			$repl[$target] = "GFX_Char_".$curlabel;
		}
	}
}

$dupls = [];

foreach ($repl as $src => $dest) {
	if (isset($dupl[$dest])) die("FAILED: $dest");
	$dupl[$dest] = true;
	print "\t'{$src}' => '{$dest}',\r\n";
}
