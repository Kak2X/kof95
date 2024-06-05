<?php

	if ($argc != 3)
		die("Usage: php wla2rgbds.php <input> <output folder>");
	
	$argInput = $argv[1];
	$argOutput = $argv[2];
	$argSrc = $argOutput."/src";
	
	if (!file_exists($argInput))
		die("Input file doesn't exist.");
	if (!is_dir($argOutput))
		mkdir($argOutput) or die("Failed to create the output directory.");
	if (!is_dir($argSrc))
		mkdir($argSrc) or die("Failed to create the src directory.");


	$h = fopen($argInput, 'r') or die;
	$o = null; // fopen($argOutput, 'w') or die;
	
	$mainScript = "";
	
	$curBank = "XX";
	const REPLMAP = [
		'RST ' => 'RST $',
		'JP (HL)' => 'JP HL',
		',' => ' ',
		'(' => '[',
		')' => ']',
		'; $' => ' $', // Only marks relative jumps
	];
	const SYMBOLS = [
		'$2000' => 'MBC1RomBank',
		'$FF00' => 'rJOYP'    ,
		'$FF01' => 'rSB'      ,   
		'$FF02' => 'rSC'      ,  
		'$FF04' => 'rDIV'     , 
		'$FF05' => 'rTIMA'    ,
		'$FF06' => 'rTMA'     ,
		'$FF07' => 'rTAC'     ,
		'$FF0F' => 'rIF'      ,
		'$FF10' => 'rNR10'    ,
		'$FF11' => 'rNR11'    ,
		'$FF12' => 'rNR12'    ,
		'$FF13' => 'rNR13'    ,
		'$FF14' => 'rNR14'    ,
		'$FF16' => 'rNR21'    ,
		'$FF17' => 'rNR22'    ,
		'$FF18' => 'rNR23'    ,
		'$FF19' => 'rNR24'    ,
		'$FF1A' => 'rNR30'    ,
		'$FF1B' => 'rNR31'    ,
		'$FF1C' => 'rNR32'    ,
		'$FF1D' => 'rNR33'    ,
		'$FF1E' => 'rNR34'    ,
		'$FF20' => 'rNR41'    ,
		'$FF21' => 'rNR42'    ,
		'$FF22' => 'rNR43'    ,
		'$FF23' => 'rNR44'    ,
		'$FF24' => 'rNR50'    ,
		'$FF25' => 'rNR51'    ,
		'$FF26' => 'rNR52'    ,
		'$FF30' => 'rWave'    ,
		'$FF31' => 'rWave_1'  ,
		'$FF32' => 'rWave_2'  ,
		'$FF33' => 'rWave_3'  ,
		'$FF34' => 'rWave_4'  ,
		'$FF35' => 'rWave_5'  ,
		'$FF36' => 'rWave_6'  ,
		'$FF37' => 'rWave_7'  ,
		'$FF38' => 'rWave_8'  ,
		'$FF39' => 'rWave_9'  ,
		'$FF3A' => 'rWave_a'  ,
		'$FF3B' => 'rWave_b'  ,
		'$FF3C' => 'rWave_c'  ,
		'$FF3D' => 'rWave_d'  ,
		'$FF3E' => 'rWave_e'  ,
		'$FF3F' => 'rWave_f'  ,
		'$FF40' => 'rLCDC'    ,
		'$FF41' => 'rSTAT'    ,
		'$FF42' => 'rSCY'     ,
		'$FF43' => 'rSCX'     ,
		'$FF44' => 'rLY'      ,
		'$FF45' => 'rLYC'     ,
		'$FF46' => 'rDMA'     ,
		'$FF47' => 'rBGP'     ,
		'$FF48' => 'rOBP0'    ,
		'$FF49' => 'rOBP1'    ,
		'$FF4A' => 'rWY'      ,
		'$FF4B' => 'rWX'      ,
		'$FF4D' => 'rKEY1'    ,
		'$FF4F' => 'rVBK'     ,
		'$FF51' => 'rHDMA1'   ,
		'$FF52' => 'rHDMA2'   ,
		'$FF53' => 'rHDMA3'   ,
		'$FF54' => 'rHDMA4'   ,
		'$FF55' => 'rHDMA5'   ,
		'$FF56' => 'rRP'      ,
		'$FF68' => 'rBGPI'    ,
		'$FF69' => 'rBGPD'    ,
		'$FF6A' => 'rOBPI'    ,
		'$FF6B' => 'rOBPD'    ,
		'$FF6C' => 'rUNKNOWN1',
		'$FF70' => 'rSVBK'    ,
		'$FF72' => 'rUNKNOWN2',
		'$FF73' => 'rUNKNOWN3',
		'$FF74' => 'rUNKNOWN4',
		'$FF75' => 'rUNKNOWN5',
		'$FF76' => 'rUNKNOWN6',
		'$FF77' => 'rUNKNOWN7',
		'$FFFF' => 'rIE'      ,
	];
	
	foreach (getLines($h) as $line) {
		if (strpos($line, ':') !== false) {
			// Label / data
			fwrite($o, str_replace('.db', 'db', $line).PHP_EOL);
		} else if (str_starts_with($line, '.bank')) {
			$curBank = sprintf("%02X", explode(' ', $line)[1]);
			if ($o)
				fclose($o);
			$o = fopen("{$argSrc}/bank{$curBank}.asm", 'w');
			
			$mainScript .= "
; 
; BANK \${$curBank} - ???
; 
SECTION \"bank{$curBank}\", ROM".($curBank === "00" ? "0" : "X, BANK[\${$curBank}]")."
INCLUDE \"src/bank{$curBank}.asm\"
";
		} else {
			$cmd = explode(' ', strtolower(strtr($line, REPLMAP)));
			// Uppercase hex vals only
			foreach (cmdNumIdx($cmd) as $i)
				$cmd[$i] = strtoupper($cmd[$i]);
			
			switch ($cmd[0]) {
				case 'ld':
					for ($i = 1; $i < count($cmd); ++$i) {
						if ($cmd[$i] == "[hl+]") {
							$cmd[0] = "ldi";
							$cmd[$i] = "[hl]";
							break;
						}
						if ($cmd[$i] == "[hl-]") {
							$cmd[0] = "ldd";
							$cmd[$i] = "[hl]";
							break;
						}
					}
					break;
				case 'ldh':
					// Use long form for numbers (only numbers allowed in ldh are addrs)
					foreach (cmdNumIdx($cmd) as $i)
						$cmd[$i] = str_replace('$', '$FF', $cmd[$i]);
					break;
				case 'jr':
					$offset = substr($cmd[count($cmd)-1], 1); // Absolute target (relative to bank) is put here by CDL prefixed by $
					unset($cmd[count($cmd)-1]);
					// Generate label
					foreach (cmdNumIdx($cmd) as $i) {
						$cmd[$i] = findTarget($curBank, $offset); 
						break;
					}
					break;
				case 'jp':
				case 'call':
					// Generate label
					foreach (cmdNumIdx($cmd) as $i) {
						$cmd[$i] = findTarget($curBank, str_replace('$', '', $cmd[$i]));
						break;						
					}
					break;
				case 'rst':
					// Delete last 'h'
					$cmd[1] = substr($cmd[1], 0, -1);
					break;
				case 'srl':
					// Extra number unwanted
					if (count($cmd) > 2)
						unset($cmd[1]);
					break;
			}
			
			$res = strtr("\t".str_pad($cmd[0], 5, " ").implode(', ', array_slice($cmd, 1)), SYMBOLS);
			fwrite($o, $res.PHP_EOL);	
		}
	}
	
	fclose($h);
	if ($o)
		fclose($o);
	
	file_put_contents("{$argOutput}/main.asm", $mainScript);
	
	
function getLines($h) {
	// Wait until we reach the first .bank instruction
	while (($line = fgets($h)) !== false) {
		$line = trim($line);
		if (str_starts_with($line, '.bank')) {
			yield $line;
			break;
		}
	}
	
	// Main event
	while (($line = fgets($h)) !== false) {
		$line = trim($line);
		if ($line)
			yield $line;
	}
}

// Indexes in $cmd that have hex values
function cmdNumIdx($cmd) {
	for ($i = 1; $i < count($cmd); ++$i) {
		if (strpos($cmd[$i], '$') !== false) {
			yield $i;
		}
	}
}

// Finds a label
function findTarget($bank, $offset) {
	$num = hexdec($offset);
	if ($num < 0x4000) // ROM0
		return "L00{$offset}";
	else if ($num < 0x8000) // ROMX
		return "L{$bank}{$offset}";
	else
		return "\${$offset}";
}