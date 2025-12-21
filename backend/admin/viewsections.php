<?php
include '../connect.php';

$gradeid         = filterRequest("gradeid");


$count = getData("sections" , "grade_id = '$gradeid'");

if (count($count) > 0) {
    echo json_encode([
        "status" => "success",
        "data" => $count
    ]);
} else {
    echo json_encode([
        "status" => "failure",
        "message" => "No users found"
    ]);
}
?>