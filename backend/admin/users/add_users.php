<?php
include "../../connect.php"; // الاتصال بقاعدة البيانات واستدعاء الدوال

// تحقق من المصادقة (اختياري إذا بدك تأمنها)
checkAuthenticate();

// 🧩 جلب البيانات من الطلب
$role         = filterRequest("role");
$email        = filterRequest("email");
$phone        = filterRequest("phone");
$first_name   = filterRequest("first_name");
$last_name    = filterRequest("last_name");
$password     = filterRequest("password"); // كلمة المرور الأصلية

// ✅ التحقق من الحقول المطلوبة
if (empty($role) || empty($email) || empty($password)) {
    printFailure("الرجاء إدخال جميع الحقول المطلوبة (الدور، البريد، كلمة المرور)");
    exit;
}

// 🧠 تشفير كلمة المرور
$password_hash = password_hash($password, PASSWORD_DEFAULT);

// 🧩 تجهيز البيانات للإدخال
$data = array(
    "role" => $role,
    "email" => $email,
    "phone" => $phone,
    "password_hash" => $password_hash,
    "first_name" => $first_name,
    "last_name" => $last_name,
    "active" => 1
);

// ✅ إدخال البيانات
$count = insertData("users", $data, false);

// ✅ التحقق من النتيجة
if ($count > 0) {
    // استرجاع بيانات المستخدم الجديد لعرضها بعد الإضافة (اختياري)
    $stmt = $con->prepare("SELECT * FROM users WHERE email = ?");
    $stmt->execute([$email]);
    $user = $stmt->fetch(PDO::FETCH_ASSOC);

    printSuccess($user); // نجاح مع إرجاع البيانات
} else {
    printFailure("فشل في إضافة المستخدم. تحقق من البريد الإلكتروني أو البيانات.");
}
