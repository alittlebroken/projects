<?php 

// Create some different data types
$var_dt_string = "Paul Lockyer";
$var_dt_int = 1290;
$var_dt_float = 10.50;
$var_dt_bool = true;
$var_dt_array = array("Banana","Apple","Cherries");
$var_dt_null = null;

// Object data type
class car{
    function car()
    {
        $this->model = "Fiesta";
    }
}

?>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>PHP Data Types</title>
    </head>
    <body>
        <h2>PHP Data Types</h2>
        <?php
            echo "Data Types: <br>";
            echo "String: $var_dt_string <br>";
            echo var_dump($var_dt_string);
            echo "<br>";
            
            echo "Integer: " . $var_dt_int . "<br>";
            echo var_dump($var_dt_int);
            echo "<br>";
            
            echo "Float: " . $var_dt_float . "<br>";
            echo var_dump($var_dt_float);
            echo "<br>";
            
            echo "Boolean: " . $var_dt_bool . "<br>";
            echo var_dump($var_dt_bool):
            echo "<br>";
            
            echo "Array: " . $var_dt_array[0] . "," . $var_dt_array[1] . "," . $var_dt_array[2] . "<br>";
            echo var_dump($var_dt_array);
            echo "<br>";
            
            // Create the object before we can output any data it has
            $objCar = new car();
            echo "Object: " . $objCar->model . "<br>";
            echo var_dump($objCar);
            echo "<br>";
            
            echo "Null: " . $var_dt_null . "<br>";
            echo var_dump($var_dt_null);
            echo "<br>";
            
        ?>
    </body>
</html>
<?php
?>
