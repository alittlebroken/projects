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

/*
* Variables to hold numbers
*/
$output_num_alpha = 5;
$output_num_beta = 10;

?>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Variables</title>
    </head>
    <body>
    
      <h2>Variables - String & Strinf Concatination</h2>
      <hr>
      <?php
      
        // Display the var contents to the screen
          echo "First var contains: " . $output_string . "<br>";
          echo "Second var contains: " . $output_string_alpha . "<br>";
          echo "Third var contains: " . $output_string_beta . "<br>";
          echo "Second & third var: " . $output_string_alpha . $output_string_beta . "<br>";
          echo "Third & second var: " . $output_string_beta . " " . $output_string_alpha . "<br>";
          echo "All together: $output_string, $output_string_alpha, $output_string_beta<br>";
      ?>
    
        <h2>Variables - Numbers</h2>
        <hr>
        <?php
        
        // Display the numbers to start with
        echo "First Number: " . $output_num_alpha . "<br>";
        echo "Second Number: " . $output_num_beta . "<br>";
        echo "<br>";
        
        // Now perform some math on the variables
        echo "Numbers added together: " . $output_num_alpha + $output_num_beta . "<br>";
        echo "Numbers multiplied together: " . $output_num_alpha * $output_num_beta . "<br>";
        echo "Numbers divided together: " $output_num_alpha / $output_num_beta . "<br>";
            
        ?>
        
    </body>
</html>
<?php

?>
