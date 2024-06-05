<?php
	
// Purpose: Split sound files
require "lib/common.php";

$buf = [];
$includes = "";

print "Here we go";
{
	$asmfile = file("src/bank1F.asm");
	
	$hdrType = null;
	$sndName = null;
	$fileName = null;
	foreach ($asmfile as $l) {
		$line = trim($l);
		
		if (str_starts_with($line, "SndHeader_")) {
			print "\r\n".$line;
			
			$set = explode("_", get_label($line), 3);
			if ($set[1] !== "SFX" && $set[1] !== "BGM") {
				$sndName = $set[1];
				$hdrType = null;
				$fileName = "data/sound/cmd".strtolower(preg_replace("/[A-Z]/", "_\$0", $sndName)).".asm";
			} else {
				$hdrType = $set[1];
				$sndName = $set[2];
				$fileName = str_replace("__", "_", "data/sound/".strtolower($hdrType . preg_replace("/[A-Z]/", "_\$0", $sndName)).".asm");
			}
			
			print " ($fileName, $hdrType, $sndName)";
			$includes .= "\r\nINCLUDE \"$fileName\"";
		}
		
		if ($fileName !== null) {
			if (!isset($buf[$fileName]))
				$buf[$fileName] = "";
			$buf[$fileName] .= $l;
		}
	}
}
print "\r\nParsed. Writing files...";

file_put_contents("log.txt", $includes.print_r($buf, true)); 

foreach ($buf as $filename => $data) {
	print "\r\n$filename...";
	file_put_contents($filename, $data);
}

print "\r\nDONE";