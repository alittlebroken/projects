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
      
      }
   
  ?>
