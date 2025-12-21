<?php 

ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);
error_reporting(E_ALL);

include "../../connect.php" ; 

$search =filterRequest("search");

$data = getAllData("view_students_users" , "first_name LIKE '%$search%' OR last_name LIKE '%$search%' ");

echo json_encode([
    "status" => count($data) ? "success" : "empty",
    "results" => count($data),
    "data" => $data
]);