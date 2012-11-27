<?php
	$uname =  $_GET["username"];
	$pwd =  $_GET["password"];
	$xml = new DOMDocument();	
	
	$xml->load("users.xml");
	$newuser = $xml->createElement("user");
	$users = $xml->getElementsByTagName("users")->item(0);
	$users->appendChild($newuser);
	$newuser->setAttribute("username",$uname);
	$newuser->setAttribute("password",$pwd);
	$xml->save("users.xml");
	
	echo "OK";
?>