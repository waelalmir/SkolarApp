<?php
include '../../connect.php';

$users = getAllData("users");

if (count($users) > 0) {
    echo json_encode([
        "status" => "success",
        "data" => $users
    ]);
} else {
    echo json_encode([
        "status" => "failure",
        "message" => "No users found"
    ]);
}
?>