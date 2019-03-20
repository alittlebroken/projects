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
   * Define the directory seperatore to use for all paths
   *//
   define("DS","/");

    /**
    * Setup the database resource here and connect to it
    **/
    include(APP_ROOT.DS."libraries".DS."database.php")
   
    /**
    * Setup the logging resource
    */
    include(APP_ROOT.DS."libraries".DS."logging.php");
    
    /**
    * Setup the template resource
    **/
    include(APP_ROOT.DS."libraries".DS."template.php");

?>
