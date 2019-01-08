<?php 

/*
* Varaible to hold output we wish to put to the screen
*/
$output_string = "Hello world!";

/*
* Variables to hold different strings that we display and concatenate together
*/
$output_string_alpha = "Hello";
$output_string_beat = " world!";

?>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Variables</title>
    </head>
    <body>
    
      <h2>Variables</h2>
      <hr>
      <?php
      
        // Display the var contents to the screen
          echo "First var contains: " . $output_string . "<br>";
          echo "Second var contains: " . $output_string_alpha . "<br>";
          echo "Third var contains: " . $output_string_beta . "<br>";
          echo "Second & third var: " . $output_string_alpha . $output_string_beta . "<br>";
          echo "Third & second var: " . $output_string_beta . " " . $output_string_alpha . "<br>";
      ?>
    
    </body>
</html>
<?php

?>
