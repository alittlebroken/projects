<?php
    /**
    *    name:        skeleton.model.php
    *    Description: Skeleton model to create new oens from to save time
    *    author:      Paul Lockyer
    *    created:     24th March 2019
    *    version:     0.1
    **/
    
   /**
   *     class skeletonModel
   *     
   *     All properties and methods used to work with the model
   *
   **/
   class skeletonModel{
   
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
      
   }
?>
