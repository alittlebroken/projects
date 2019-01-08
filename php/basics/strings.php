<?php 

// Create string to manipulate during this learning experience
$var_string = "The quick brown fox jumped over the lazy programmer.";

?>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>PHP Strings</title>
    </head>
    <body>
    
        <h2>PHP Strings</h2>
        
        <?php
          
          echo "String before manipulation: " . $var_string . "<br>";
          
          echo "Length of string: " . strlen($var_string) . "<br>";
          
          echo "Words in string: " . str_word_count($var_string) . "<br>";
          
          echo "Reverse of string: " . strrev($var_string) . "<br>";
          
          echo "Position of jumped in string: " . strpos($var_string,"jumped") . "<br>";
          
          echo "String Replacement ( programmer with cow ): " . str_replace("programmer","cow",$var_string) . "<br>";
          
        ?>
    
    </body>
</html>
<?php
?>
