<?php

/**
*   simple PDO database connection script
*   Paul Lockyer 2019 ( plockyer@googlemail.com )
*/

$db_hostname = "localhost";
$db_name = "basics";
$db_login = "admin";
$db_login_pass = "admin";

/**
* The connection string to pass to the PDO object
*/
$connection_string = "mysql:host=$db_hostname,dbname=$db_name;port=3306;charset=utf8mb4";

$db_options = [
  PDO::ATTR_ERRMODE           =>  PDO::ERRMODE_EXCEPTION,
  PDO::ATTR_EMULATE_PREPARES  =>  PDO::false,
  PDO::ATTR_FETCH_MODE        =>  PDO::FETCH_ASSOC
];

$db_connection = null;

try{
  $db_connection = new PDO($connection_string,$db_login,$db_login_pass,$db_options);  
}
catch(PDOException $e){
  echo "<hr>";
  echo "<h1>Database Error</h1>";
  echo "There was a problem accessing the database. Please see the extra information below:<br><br>";
  echo $e->getMessage() . "<br><br>" . $e->getCode();
  echo "<hr>";
}

?>

<?php

    $db_connection = null;

?>
