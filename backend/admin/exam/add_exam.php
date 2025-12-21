<?php
include "../../connect.php"; // الاتصال بقاعدة البيانات واستدعاء الدوال

// تحقق من المصادقة (اختياري إذا بدك تأمنها)
checkAuthenticate();

// 🧩 جلب البيانات من الطلب
$gradeid        = filterRequest("gradeid");
$subjectid        = filterRequest("subjectid");
$examdate        = filterRequest( "examdate");
$term        = filterRequest("term");// 1,2
$examtype        = filterRequest("examtype"); //quiz/mid/final



// ✅ التحقق من الحقول المطلوبة
if (empty($subjectid) || empty($gradeid) || empty($examdate) || empty($term) || empty($examtype)) {
    printFailure("الرجاء إدخال جميع الحقول المطلوبة (اسم المادة و اختيار الصف)");
    exit;
}



// 🧩 تجهيز البيانات للإدخال
$data = array(
    "subject_id" => $subjectid,
    "grade_id" => $gradeid,
    "exam_date" => $examdate,
    "term" => $term,
    "exam_type" => $examtype,

);

// ✅ إدخال البيانات
$count = insertData("exams", $data);

// ✅ التحقق من النتيجة
if ($count > 0) {
    // استرجاع بيانات المستخدم الجديد لعرضها بعد الإضافة (اختياري)
    $stmt = $con->prepare("SELECT * FROM exams");
   
    $user = $stmt->fetch(PDO::FETCH_ASSOC);

    printSuccess($exam_type); // نجاح مع إرجاع البيانات
} else {
    printFailure("فشل في إضافة الامتحان");
}
