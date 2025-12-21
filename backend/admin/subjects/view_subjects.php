<?php
include '../../connect.php';

$gradeid = filterRequest("gradeid");

$count = getData("subjects" , "grade_id = '$gradeid'");

if (count($count) > 0) {
    echo json_encode([
        "status" => "success",
        "data" => $count
    ]);
} else {
    echo json_encode([
        "status" => "failure",
        "message" => "No subjects found"
    ]);
}
?>