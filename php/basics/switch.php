<?php 

/*
    switch.php
    Demostrates the use of switches in PHP
    Paul Lockyer (plockyer@googlemail.com)
    January 21st 2019
*/

/*

    Variable to perform switch test on

*/
$favourite_colour = "blue";

?>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>PHP Switch</title>
    </head>
    <body>
        <h2>PHP Switches</h2>
        <?php
        
        /*
            Test the users favourite colour and using the switch statement display it to the screen
            
        */
        switch ($favourite_colour) {
            case "blue":
                echo "Your favourite colour is " . $favourite_colour . "<br>";
                break;
            case "red":
                echo "Your favourite colour is " . $favourite_colour . "<br>";
                break;
            case "yellow":
                echo "Your favourite colour is " . $favourite_colour . "<br>";
                break;
            case "black":
                echo "Your favourite colour is " . $favourite_colour . "<br>";
                break;
            case "green":
                echo "Your favourite colour is " . $favourite_colour . "<br>";
                break;
            case "purple":
                echo "Your favourite colour is " . $favourite_colour . "<br>";
                break;
            default:
                echo "Hmm it seems your favourite colour does not exist yet.<br>";
        }
        
        
        ?>    
    </body>
</html>
<?php
?>
