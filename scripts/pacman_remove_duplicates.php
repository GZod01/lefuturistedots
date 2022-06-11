<?php
/*
Sometime when you want to upgrade you pacman packages 
you may run into issues like "file humhum already exists" 
In theses situation the most simple way to resolve the issue is to just delete the files in questions

This script will read input.txt and parse the warning that are output by pacman and then delete the files.

You may need to run the script as root
*/


$lines = explode("\n", file_get_contents(__DIR__ . '/input.txt'));

$re = '/\/[\/a-zA-Z.0-9\-_@]+/m';

foreach ($lines as $line){
	$matches = NULL;
	preg_match_all($re, $line, $matches, PREG_SET_ORDER, 0);
	if (!empty($matches)){

		echo ".";
		$path = isset($matches[0][0]) ? $matches[0][0] : $matches[0];
		var_dump($path);
		if (file_exists($path)) {
			unlink($path);
		}
		if (file_exists($path)) {
			echo "\n ISSUE \n";
		}
	}
}

echo "\n\nDone";

