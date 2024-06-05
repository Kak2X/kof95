<?php

// Purpose: Determines bank number and address for an absolute ROM offset
// ==============================

require "lib/common.php";

const BANK_SIZE = 0x4000;

if ($argc != 2) die("hex address required");
//if (!is_numeric($argv[1])) die ("no");
$addr = hexdec($argv[1]);

$banknum = floor($addr / BANK_SIZE);
$bankaddr = ($addr % BANK_SIZE) + ($banknum ? BANK_SIZE : 0);

die (fmthexnum($banknum, 2).":".fmthexnum($bankaddr, 4));