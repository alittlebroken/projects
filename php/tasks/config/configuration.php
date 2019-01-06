<?php

/**
* Database configuration
*
*/
define("DB_SERVER","localhost");
define("DB_NAME","projects");
define("DB_UID","projectdev");
define("DB_UID_PWD","jshsdjkfhsfhsjk");
define("DB_CHARSET","utf8mb4");
define("DB_OPTIONS",array(
  PDO::ATTR_ERRMODE => PDO::ERRMODE_EXEPTION,
  PDO::FETCH_DEFAULT_MODE => PDO::FETCH_ASSOC);
?>
