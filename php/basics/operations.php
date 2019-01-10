<?php 

/*
* Variable to hold different values to help show operators
*/

$int_num_one = 1;
$int_num_two = 2;
$int_num_five = 5;
$int_num_ten = 10;

?>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>PHP Operations</title>
    </head>
    <body>
        <h2>PHP Operations</h2>
        <?php
    
            echo "Math Operations<br>";
            echo "<hr>";
            echo "$int_num_one + $int_num_two = " . $int_num_one + $int_num_two . "<br>";
            echo "$int_num_ten - $int_num_five = " . $int_num_ten - $int_num_five . "<br>";
            echo "$int_num_10 / $int_num_one = " . $int_num_ten / $int_num_one . "<br>";
            echo "$int_num_10 * $int_num_five = " . $int_num_10 * $int_num_five . "<br>";
            echo "$int_num_10 % $int_num_five = " . $int_num_10 % $int_num_five . "<br>";
            echo "$int_num_10 ** $int_num_five = " . $int_num_10 ** $int_num_five . "<br>";
        ?>
    </body>
</html>
<?php
?>
