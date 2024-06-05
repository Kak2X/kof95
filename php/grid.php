<?php


const BLOCK_W = 8;
const BLOCK_H = 8;
const GRID_W = 4;
const GRID_H = 4;


if ($argc < 3)
	die("Usage: grid.php <image> <output>");

if (!file_exists($argv[1])) 
	die("Can't find {$argv[1]}");

list($width, $height) = getimagesize($argv[1]);
$src 	= imagecreatefrompng($argv[1]) or die;
$dest	= imagecreatetruecolor($width + (GRID_W * ($width / BLOCK_W)), $height + (GRID_H * ($height / BLOCK_H)));
$c		= imagecolorallocate($dest, 0, 0, 0);
 
for ($ys = $yd = 0; $ys < $height; $ys += BLOCK_H, $yd += BLOCK_H + GRID_H) {
	for ($xs = $xd = 0; $xs < $width; $xs += BLOCK_W, $xd += BLOCK_W + GRID_W) {
		imagecopy($dest, $src, $xd, $yd, $xs, $ys, BLOCK_W, BLOCK_H);
	}
}

imagepng($dest, $argv[2]);
