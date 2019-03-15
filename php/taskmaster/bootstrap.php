<?php

    /**
    * Use this file to setup up standard variables and perhaps those little functions that 
    * don't quite have a home yet.
    **/
    
    /**
    * Defines the apps base location
    **/
    define("APP_ROOT",dirname(__FILE__));

    /**
    * Setup the database resource here and connect to it
    **/
    include("/libraries/database.php")
   
    /**
    * Setup the logging resource
    */
    include("/libraries/logging.php");
    
    /**
    * Setup the template resource
    **/
    include("/libraries/template.php");

?>
