<?php

   /**
   *    name:         database.php
   *    description:  Provides a connection to a database for the apps models
   *    auth:         Paul Lockyer
   *    created:      6th March 2019
   *    version:      0.1
   **/
   
   /**
   *     properties to allow a connection to the database, fairly self explanatory
   *    on what each property holds
   **/
   $db_name = "taskmaster";
   $db_host = "localhost";
   $db_uid  = "tskmstusr";
   $db_pass = "Gr34t56IhGffT";
   
   /**
   *    Connect to the database with the above parameters and don't forget to do this within
   *    a try catch block to catch any nasty exception we might encounter
   **/
   try{
      $db_connection = new PDO("mysql:host=$db_host;dbname=$db_name",$db_uid,$db_pass); 
   }catch(PDOException $e){
      echo "An error was encountered whilst trying to connect to the database.<br>";
      echo e$->getMessage();
   }

?>
