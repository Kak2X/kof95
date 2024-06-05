<?php
	
$IN_FILE = "tempconv.txt";
$OUT_FILE = "tempconv.asm";

// Purpose: bgm command explainer because no way I'm writing it by hand
require "lib/common.php";
	
if (!file_exists($IN_FILE))
	die("Can't find {$IN_FILE}");

$asmfile = file($IN_FILE);
$h = fopen($OUT_FILE, 'w');

$nr51 = [
	0 => "SNDOUT_CH1R",
	1 => "SNDOUT_CH2R",
	2 => "SNDOUT_CH3R",
	3 => "SNDOUT_CH4R",
	4 => "SNDOUT_CH1L",
	5 => "SNDOUT_CH2L",
	6 => "SNDOUT_CH3L",
	7 => "SNDOUT_CH4L",
];

$writebuf = []; // fwrite buffer, holds everything
$jumpmap = []; // maps labels to writebuf indexes
$jumps = []; // list of call labels

for ($chnum = $i = 0; $i < count($asmfile);) {
	$line = $asmfile[$i];
	
	// Detect lines which don't contain commands
	if (!rtrim($line)) {
		outraw($line);
		$i++;
		continue;
	}
	
	if (
		($line[0] != "L" && strpos($line, "SndData_") !== 0)
	//	|| (strpos($line, "SndData_") !== 0 && !$chnum)
	) {
		outraw($line);
	//	$chnum = 0;
		$i++;
		continue;
	}
	
	// Read the command byte for this
	$cmd = get_db($line);
	if ($cmd === false)			// No command?
		die("get_db failed at line ".$i+1);
	$cmd = hexdec($cmd);
	
	// Automatically increased when a command byte is read
	$i++;
	
	// If this line had a real label, add it first
	$label = trim(get_label($line));
	if ($line[0] != "L") {
		outraw("{$label}:\r\n");
		// Has to be a SndData_
		// detect channel number
		$chnum = (int)substr($label, -1);
	} else {
		//out("\t");
	}
	
	// Map destinations to entries in the writebuf array.
	// Count this after all other labels, before handling the command.
	$jumpmap[$label] = count($writebuf);
	
	$unused_marker = strpos($line, ";X") !== false ? " ;X" : "";
	
	// Determine the command like the game would do
	if ($cmd >= 0xE0) {
		// Command ID
		
		// $asmfile[$i] now points to the byte after the command id (the start of the command data)
		// this means the first argument is read by calling getdb($i)
		//
		// if the command data is only one byte, the $incPtr at the end is enough.
		// those with no command data set $incPtr = false;
		
		$cmdid = $cmd & 0x1F;
		$incPtr = true;
		switch ($cmdid) {
			case 0x00:
			case 0x01:
			case 0x02:
			case 0x0A:
			case 0x0B:
			case 0x17:
			case 0x18:
			case 0x19:
			case 0x1B:
			case 0x1C:
			case 0x1D:
			case 0x1E:
			case 0x1F:
				out("snderr \$".fmthexnum($cmd));
				$incPtr = false;
				break;
			case 0x03:
				out("snd_UNUSED_endchnoset");
				$incPtr = false;
				break;
			case 0x04:
				$val = getdb($i);
				$x = hexdec($val);
				
				if ($chnum == 3) {
					// for ch3
					$vol = ($x >> 5) & 0b11;
					out("sndenvch3 $vol");
				} else {
					// for ch1-2-4
					$sweep = $x & 0b111;
					$dir = (($x >> 3) & 0b1) ? "SNDENV_INC" : "SNDENV_DEC";
					$vol = ($x >> 4) & 0b1111;
					out("sndenv $vol, $dir, $sweep");
				}

				break;
			case 0x05:
				$ptrLow = getdb($i++);
				$ptrHigh = getdb($i);
				$target = "L1F{$ptrHigh}{$ptrLow}";
				$jumps[$target] = true;
				out("sndloop {$target}"); // \${$ptrHigh}{$ptrLow} ; 
				break;
			case 0x06:
				out("sndnotebase \$".getdb($i));
				break;
			case 0x07:
				$timerId = getdb($i++);
				$timerVal = hexdec(getdb($i++));
				$ptrLow = getdb($i++);
				$ptrHigh = getdb($i);
				$target = "L1F{$ptrHigh}{$ptrLow}";
				$jumps[$target] = true;
				out("sndloopcnt \${$timerId}, {$timerVal}, {$target}"); // \${$ptrHigh}{$ptrLow} ; 
				break;
			case 0x08:
				$x = hexdec(getdb($i));
				$time = ($x >> 4) & 0b111;
				$inc = ($x >> 3) & 0b1;
				$num = $x & 0b111;
				out("snd_UNUSED_nr10 $time, $inc, $num");
				break;
			case 0x09:
				$val = getdb($i);
				out("sndenach ".generate_const_label($val, $nr51));
				break;
			case 0x0C:
				$ptrLow = getdb($i++);
				$ptrHigh = getdb($i);
				$target = "L1F{$ptrHigh}{$ptrLow}";
				$jumps[$target] = true;
				out("sndcall {$target}");  // \${$ptrHigh}{$ptrLow} ; 
				break;
			case 0x0D:
				out("sndret");
				$incPtr = false;				
				break;
			case 0x0E:
				$x = hexdec(getdb($i));
				switch ($chnum) {
					case 1:
					case 2:
						$pat = ($x >> 6) & 0b11;
						$num = $x & 0b111111;
						out("sndnr{$chnum}1 $pat, $num");
						break;
					case 3:
						out("sndnr31 $x");
						break;
					case 4:
						$num = $x & 0b111111;
						out("sndnr41 $num");
						break;
					default:
						out("sndnrx1 \$".getdb($i)." ; THIS SHOUDN'T BE OUTPUT");
				}
				
				break;
			case 0x0F:
				out("sndsetskip");
				$incPtr = false;
				break;
			case 0x10:
				out("snd_UNUSED_clrskip");
				$incPtr = false;
				break;
			case 0x11:
				out("snd_UNK_setstat6");
				$incPtr = false;
				break;
			case 0x12:
				out("snd_UNUSED_clrstat6");
				$incPtr = false;
				break;
			case 0x13:
				out("sndwave \$".getdb($i));
				break;	
			case 0x14:
				out("sndendch");
				$incPtr = false;
				break;
			case 0x15:
				$val = getdb($i);
				if ($val == "FF")
					$val = "SNDLEN_INFINITE";
				out("snd_UNUSED_ch3len \$".$val);
				break;					
			case 0x16:
				$subframes = getdb($i++);
				$frames = getdb($i);
				out("sndtinc \${$frames}{$subframes}");
				break;
			case 0x1A:
				$val = getdb($i);
				if ($val == "FF")
					$val = "SNDLEN_INFINITE";
				out("sndlenpre \$".$val);
				break;					
		}
		
		if ($incPtr) {
			$i++;
		}
		continue;
	}
	
	if ($chnum == 4) {
		$freq = ($cmd >> 4) & 0b1111;
		$step = ($cmd >> 3) & 0b1;
		$ratio = ($cmd) & 0b111;
		out("sndch4 $freq, $step, $ratio");
		
		$newbyte = hexdec(getdb($i));
		if ($newbyte < 0x80) {
			$i++;
			//--
			out("sndlen ".$newbyte);
			//--
		}
	} else if ($cmd < 0x80) {
		// Target length only
		out("sndlen ".$cmd);
	} else {
		// Note id (with next byte potentially being a target length)
		out("sndnote \$".fmthexnum($cmd-0x80));
		
		$newbyte = hexdec(getdb($i));
		if ($newbyte < 0x80) {
			$i++;
			//--
			out("sndlen ".$newbyte);
			//--
		}
	}
}

// Add in labels for jump targets, from last to first
$toadd = [];
foreach ($jumps as $l => $_) {
	$toadd[] = [$jumpmap[$l], $l];
}
usort($toadd, function ($a, $b) {
	return $b[0] <=> $a[0];
});

foreach ($toadd as $v) {
	$a = array_slice($writebuf, 0, $v[0]);
	$b = array_slice($writebuf, $v[0]);
	$writebuf = array_merge($a, ["{$v[1]}:\r\n"], $b);
}


outend();


function getdb($i) {
	global $asmfile;
	return get_db($asmfile, $i);
}
function getdw($i) {
	return getdb($i+1).getdb($i);
}
function out($txt) {
	//print $txt;
	global $writebuf, $unused_marker;
	$writebuf[] = "\t".$txt.$unused_marker."\r\n"; 
}
function outraw($txt) {
	global $writebuf;
	$writebuf[] = $txt;
}
function outend() {
	global $h, $writebuf;
	foreach ($writebuf as $txt)
		fwrite($h, $txt); 
	fclose($h);
}