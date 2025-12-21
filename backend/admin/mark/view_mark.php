<?php
include '../../connect.php';

$studentid = filterRequest("studentid");
// $examid = filterRequest("examid");
// $mark = filterRequest("mark");

$count = getData("view_grades_marks" , "student_id = '$studentid'");

// $data = array(
//     "examid" => $examid,
//     "mark" => $mark,
//     "student_id" => $studentid,

// );

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