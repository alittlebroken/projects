<?php 

/*
* Create some constants
*/
define("CONST_OUT_FUNC","Paul Lockyer");
define("CONST_IN_FUNC","Yvette Parnell");

/*
* crete a test function to output one of the defines
*/
function output_defined_constant()
{
    echo "Defined constanst from within a function" . CONST_IN_FUNC . "<br>";
}

?>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>PHP Constants</title>
    </head>
    <body>
    
        <h2>PHP Constants</h2>
    
        <?php
            echo "Defined Constant: " . CONST_OUT_FUNC . "<br>";

            // Display the constant from within a function
            output_defined_constant(); 

        ?>

    </body>
</html>
<?php
?>
