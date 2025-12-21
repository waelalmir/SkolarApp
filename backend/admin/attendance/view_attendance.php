<?php
include "../../connect.php"; 
checkAuthenticate();

// 🧩 جلب البيانات من الطلب
$studentid = filterRequest("studentid");
$date      = filterRequest("date");
$status    = filterRequest("status");

// 🧩 تحقق من الحقول المطلوبة
if (empty($studentid) || empty($date) || empty($status)) {
    printFailure("الرجاء إدخال جميع الحقول المطلوبة");
    exit;
}

// 🧩 1. فحص إذا كان يوجد سجل حضور سابق لنفس الطالب ونفس التاريخ
$stmt = $con->prepare("SELECT * FROM attendance WHERE student_id = ? AND date = ?");
$stmt->execute([$studentid, $date]);

$exists = $stmt->rowCount();

// 🟦 البيانات الجاهزة للحفظ (Insert أو Update)
$data = array(
    "student_id" => $studentid,
    "date"       => $date,
    "status"     => $status,
);

// 🧩 2. إذا السجل موجود → Update
if ($exists > 0) {

    // *** استخدم updateData ***
    $updated = updateData("attendance", $data, "student_id = '$studentid' AND date = '$date'");

    if ($updated) {
        printSuccess("Updated");
    } else {
        printFailure("لم يتم تحديث الحضور");
    }

} else {
    // 🧩 3. إذا غير موجود → Insert
    $inserted = insertData("attendance", $data);

    if ($inserted > 0) {
        printSuccess("Inserted");
    } else {
        printFailure("فشل في إضافة الحضور");
    }
}
