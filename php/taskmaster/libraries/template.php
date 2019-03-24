<?php
   /**
   *    name:         template.php
   *    description:  Provides a template system for the application
   *    auth:         Paul Lockyer
   *    created:      24th March 2019
   *    version:      0.1
   **/
   
   
  
      class template{
      
          /**
          * An array of tags for the page
          **/
          private $_tags = array();
      
          /**
          * Stores the app name and action to take
          **/
          private $_appName;
          private $_appAction;
           
          /**
          * Constructor for the class to allow us to set some default values if we wish
          */
          public function __construct($app_name = "Default",$app_action = "Index")
          {
          
               /** 
               * Assign passed in vars to be used later
               **/
               $this->_appName = $app_name;
               $this->_appAction = $app_action;
          
          }
          
          /**
          * Allows us to add a tag for the page
          **/
          public function addPageElement($key,$value)
          {
              $this->_tags[$key] = $value;
          }
         
          /**
          * Gets the header file
          **/
          private function getHeader()
          {
           
             /**
             * Look for the header file in the apps view folder, the amin view folder
             * or just load the default
             **/
             if(file_exists(APP_ROOT.DS."views".DS.$this->_appName.DS.$this->_appName.".header.php"))
             {
                 include(APP_ROOT.DS."views".DS.$this->_appName.DS.$this->_appName.".header.php");
             }
             elseif(file_exists(APP_ROOT.DS."views".DS.$this->appName."header.php"))
             {
                 include(APP_ROOT.DS."views".DS.$this->appName."header.php");
             }
             else
             {
                 include(APP_ROOT.DS."views".DS."default.header.php");  
             }
             
          }
         
         /**
         * gets the footer file
         **/
         private function getFooter()
         {
          
            /** 
            * look for the foor file for the specified file
            **/
            if(file_exists(APP_ROOT.DS."views".DS.$this->appName.DS.$this->appName.".footer.php"))
            {
               include(APP_ROOT.DS."views".DS.$this->appName.DS.$this->appName.".footer.php");
            }
            elseif(file_exists(APP_ROOT.DS."views".DS.$this->appName."footer.php"))
            {
               include(APP_ROOT.DS."views".DS.$this->appName."footer.php");
            }
            else
            {
               include(APP_ROOT.DS."views".DS."default.footer.php");
            }
            
         }
         
         /**
         * Display the page
         **/
         public function display()
         {
          
            /**
            * Extract the page tags
            **/
            extract($this->_tags);
            
            /**
            * Now load the main application action page
            **/
            if(file_exists(APP_ROOT.DS."views".DS.$this->appName.DS.$this->appAction.".view.php"))
            {
               $this->getHeader();
               include(APP_ROOT.DS."views".DS.$this->appName.DS.$this->appAction.".view.php");
               $this->getFooter();
            }
            elseif(APP_ROOT.DS."views".DS.$this->appName."_".$this->appAction.".view.php")
            {
               $this->getHeader();
               include(APP_ROOT.DS."views".DS.$this->appName."_".$this->appAction.".view.php");
               $this->getFooter();
            }
            else
            {
               $this->getHeader();
               include(APP_ROOT.DS."views".DS."default.view.php";
               $this->getFooter();
            }
            
         }
         
         
      }
   
  ?>
