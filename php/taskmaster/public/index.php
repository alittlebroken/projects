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
        case "tasks":
            include("../models/tasks.php");
            break;
        default:
            include("../models/default.php");
    }

?>
