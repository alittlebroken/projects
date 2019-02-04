<?php 
?>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>PHP While Loop</title>
    </head>
    <body>
        <h1>PHP While Loop</h1>
        <?php
          
          /*
          *   Using a while loop, iterate through some numbers
          */
          while($x < 10)
          {
              echo "The number is: " . $x . "<br>";
              $x++;
          }
          
        ?>
        <br>
        <h1> PHP DO While Loop </h1>
        <?php
        
            do {
                echo "The number in the do while loop is: " . $x . "<b4>";
                $x++;
            } while ($x < 10);
        
        ?>
    </body>
</html>
<?php
?>
