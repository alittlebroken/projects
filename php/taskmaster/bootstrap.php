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
   * Assing and create the class autoloader 
   **/
   spl_autoload_register('app_loader');

   function app_loader($classname)
   {
    
       /** 
       * Search through the local folders and check if the 
       * class named required exists. Check the models
       * folder first then views and finally the
       * libraries folder
       *
       * class name is the name of the app I.E TaskMaster
       **/
       if(file_exists(APP_ROOT.DS."models".DS.$classname.DS.$classname.".model.php"))
       {
           include(APP_ROOT.DS."models".DS.$classname.DS.$classname.".model.php");
       }
       elseif(file_exists(APP_ROOT.DS."models".DS.$classname.".model.php"))
       {
           include(APP_ROOT.DS."models".DS.$classname.".model.php");
       }
       elseif(file_exists(APP_ROOT.DS."views".DS.$classname.DS.$classname.".view.php"))
       {
           include(APP_ROOT.DS."views".DS.$classname.DS.$classname.".view.php");
       }
       elseif(file_exists(APP_ROOT.DS."views".DS.$classname.".view.php"))
       {
           include(APP_ROOT.DS."views".DS.$classname.".view.php");
       }
       else(file_exists(APP_ROOT.DS."libraries".DS.$classname.".php"))
       {
           include(APP_ROOT.DS."libraries".DS.$classname.".php");
       }
       
   }

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
