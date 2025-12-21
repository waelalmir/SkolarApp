<?php
include '../../connect.php';



$count = getData("users", "role = ?", ["teacher"]);

if (count($count) > 0) {
    echo json_encode([
        "status" => "success",
        "data" => $count
    ]);
} else {
    echo json_encode([
        "status" => "failure",
        "message" => "No teachers found"
    ]);
}
?>