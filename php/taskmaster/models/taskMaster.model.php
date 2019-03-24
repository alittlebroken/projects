<?php
    /**
    *    name:        taskMaster.model.php
    *    Description: Model that handles the logic for the application to
    *                 work with the tasks module.
    *    author:      Paul Lockyer
    *    created:     7th March 2019
    *    version:     0.1
    **/
    
   /**
   *     class taskModel
   *     
   *     All properties and methods used to work with the tasks module
   *
   **/
   class taskModel{
   
        /**
        *  holds the internal reference to the database connection
        **/
        protected $db;
    
    
       /** 
       * Standard class constructor, takes in the database reference.
       **/
       public function __construct($db)
       {
           $this->db = $db;
       }
      
       /**
       * Fuction that returns all the rows from the task table
       **/
       public function getTasks()
       {
           
           
       }
   
   }

?>
