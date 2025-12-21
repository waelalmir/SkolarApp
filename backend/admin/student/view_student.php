<?php
include '../../connect.php';

$sectionid         = filterRequest("sectionid");


$count = getData("view_students_users" , "section_id = '$sectionid'");

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