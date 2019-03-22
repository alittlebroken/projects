<?php

    /**
    * Load the application bootstrap file, before anything else
    **/
    include("../bootstrap.php");

    /**
    * Now include an app based on what has been selected, otherwise just load the front page
    **/
    switch($_GET["app"])
    {
        case "taskMaster":
            $application_name = "taskMaster";
            $application_action = $_GET["action"];
            break;
        default:
            $application_name = "default";
            $application_action = "Index";
    }

    /**
    * Now include the app clas file and create an instace of it
    **/
    include(APP_ROOT.DS."models".DS."$application_name_Model.class.php");
    $classname = $applicationName."Model";
    $application = new $classname($db_connection);
    
?>
