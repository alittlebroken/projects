<?php 

/*
* Vars used to show their use with echo and print
*/
$strName = "Paul Lockyer";
$intNum = 101;

?>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>PHP & HTML 5 Skeleton Document</title>
    </head>
    <body>
    
    <h2>Echo & Print</h2>
    <hr>
    
    <?php
    
      echo "<h3>Sub page header using echo</h3>";
      echo "Using echo ", "with multiple ", "parameters";
      echo("<br>");
      echo "Name: $strName <br>";
      echo "Number: $intNum <br>";
      echo "Math: " . $intNum + 101 . "<br>";
           
      print "<h3>Sub page header using print</h3>";
      print("using print function to output text to screen.<br>");
      print "Name: " . $strName . "<br>";
      print "Number: " . $intNum . "<br>";
      print "Math: " . 1024 + $intNum . "<br>";
    
    ?>
    
    </body>
</html>
<?php
?>
