<?php
include '../../connect.php';

$count = getAllData("view_teachers_users");

if (count($count) > 0) {
    echo json_encode([
        "status" => "success",
        "data" => $count
    ]);
} else {
    echo json_encode([
        "status" => "failure",
        "message" => "No grade found"
    ]);
}
?>