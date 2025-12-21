<?php
include '../connect.php';

$pageId = filterRequest("pageid");

$count = getData("pages" , "id = '$pageId'");

if (count($count) > 0) {
    echo json_encode([
        "status" => "success",
        "data" => $count
    ]);
} else {
    echo json_encode([
        "status" => "failure",
        "message" => "No pages found"
    ]);
}
?>
