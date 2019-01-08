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

/*
* Variable to test scope - this var is a global var and can be accessed oanywhere in the script that is outside of functions
*/
$output_global_var = "Paul Lockyer";

/* 
* This function tests global and local scope
*/
function test_var_scope()
{
 
    // Print out the global var, produces an error as we can't access it
    echo "Global Var: $output_global_var";
    
    // Create a local scope var
    $output_local_var = "Simon Lockyer";
    
    echo "Local var (Inside function): $output_local_var";
    
}

/*
* This function references the global var correctly
*/
function test_var_scope_fixed()
{
    // Refrence the global var
    global $output_global_var;
    
    // Print out the global var, this time works as we have put a globla reference to it
    echo "Global Var: $output_global_var";
    
    // Create a local scope var
    $output_local_var = "Sue Lockyer";
    
    echo "Local var (Inside function): $output_local_var";
}

// Another way a function can access the global var without the global keyword
function test_var_scope_new()
{
 
    echo "Global var access via GLOBAL: " . $GLOBALS["output_global_var"] . "<br>";
    
    // Create aniother locally scoped var
    $output_local_var = "Glen Lockyer";
    
    echo "Local var inside function: $output_local_var <br>";
    
}

?>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Variables</title>
    </head>
    <body>
    
      <h2>Variables - String & String Concatination</h2>
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
        
        <h2> Variables  - Scope </h2>
        <hr>
        <?php
        
            echo "Global scope var: " . $output_global_var . "<br>";
        
            // Attempt to print out the global var inside the function, should error at this point
            echo "Global and Local inside function (FAIL): " . test_var_scope() . "<br>";
        
           // Attempt to print the local var inside ther function
           echo "Local var inside function (FAIL): " . $output_local_var ."<br>";
        
           // Now attempt to print out the global var from within the new function
           echo "Global and local inside function (Fixed): test_var_scope_fixed() <br>";
        
           // Now output the global var another way
           echo "Access global var in fucntion via GLOBAL: test_var_scope_new() <br>";
        
        ?>
        
    </body>
</html>
<?php

?>
