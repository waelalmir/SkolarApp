
<?php
include "../../connect.php"; // الاتصال بقاعدة البيانات واستدعاء الدوال

// تحقق من المصادقة (اختياري إذا بدك تأمنها)
checkAuthenticate();

// 🧩 جلب البيانات من الطلب
$gradeid        = filterRequest("gradeid");
$sectionid        = filterRequest("sectionid");
$subjectid        = filterRequest("subjectid");
$teacherid        = filterRequest("teacherid");
$dayofweek        = filterRequest("dayofweek");
$starttime        = filterRequest("starttime");
$endtime        = filterRequest("endtime");


// ✅ التحقق من الحقول المطلوبة
if (empty($sectionid) || empty($gradeid) ) {
    printFailure("الرجاء إدخال جميع الحقول المطلوبة (اسم المادة و اختيار الصف)");
    exit;
}



// 🧩 تجهيز البيانات للإدخال
$data = array(
    "grade_id" => $gradeid,
    "section_id" => $sectionid,
    "subject_id" => $subjectid,
    "teacher_id" => $teacherid,
    "day_of_week" => $dayofweek,
    "start_time" => $starttime,
    "end_time" => $endtime,

);

// ✅ إدخال البيانات
$count = insertData("timetable", $data, false);

// ✅ التحقق من النتيجة
if ($count > 0) {
    // استرجاع بيانات المستخدم الجديد لعرضها بعد الإضافة (اختياري)
   $stmt = $con->prepare("SELECT * FROM timetable");
$stmt->execute();
$data = $stmt->fetchAll(PDO::FETCH_ASSOC);

printSuccess($data);

} else {
    printFailure("فشل في إضافة الحصة ");
}
