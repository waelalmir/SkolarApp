<?php

include "../../connect.php" ;

$id = filterRequest("id") ; 



$count = deleteData("timetable" , "id = '$id' ") ; 

if ($count > 0) {
    // 💡 عند نجاح التحديث، نطبع استجابة النجاح
    echo json_encode(array("status" => "success"));
} else {
    // 💡 في حال لم يتم تحديث أي صف (قد تكون البيانات لم تتغير أو الـ ID خاطئ)
    echo json_encode(array("status" => "failure", "message" => "No rows updated."));}