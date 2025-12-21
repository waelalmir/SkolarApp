

<?php
include '../connect.php';

$pageId = filterRequest("pageid");

$count = getData("page_notes" , "page_id = '$pageId' ORDER BY created_at DESC");

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
