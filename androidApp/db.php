<?php
$servername = "localhost"; 
$username = "bigektuw_admin2";  
$password = "l?;i(Bl!uj}z";  
$dbname = "bigektuw_kbtradelinks_software";
// Create connection
// Create connection
$conn = new mysqli($servername, $username, $password, $dbname);

// Check connection
if ($conn->connect_error) {
  die("Connection failed: " . $conn->connect_error);
}
//  echo "Connected successfully";