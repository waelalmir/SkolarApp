<?php
ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);
error_reporting(E_ALL);

include "../../connect.php";

// 🧩 جلب البيانات من الطلب
$id             = filterRequest("id");        // مهم جداً لتحديد السطر المراد تعديله
$gradeid        = filterRequest("gradeid");
$sectionid      = filterRequest("sectionid");
$subjectid      = filterRequest("subjectid");
$teacherid      = filterRequest("teacherid");
$dayofweek      = filterRequest("dayofweek");
$starttime      = filterRequest("starttime");
$endtime        = filterRequest("endtime");

// 🧩 تجهيز البيانات للتعديل
$data = array(
    "grade_id"    => $gradeid,
    "section_id"  => $sectionid,
    "subject_id"  => $subjectid,
    "teacher_id"  => $teacherid,
    "day_of_week" => $dayofweek,
    "start_time"  => $starttime,
    "end_time"    => $endtime,
);

// ✅ التعديل باستخدام الـ id
$updated = updateData("timetable", $data, "id = $id");

// ✅ التحقق من النتيجة
if ($updated) {
    // لجلب البيانات بعد التعديل (اختياري)
    $stmt = $con->prepare("SELECT * FROM timetable WHERE id = ?");
    $stmt->execute([$id]);
    $data = $stmt->fetch(PDO::FETCH_ASSOC);

    printSuccess($data);

} else {
    printFailure("فشل في تعديل بيانات الحصة");
}
