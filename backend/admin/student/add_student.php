<?php
include "../../connect.php";  // يحتوي كل الدوال المساعدة
checkAuthenticate();          // ✅ تحقق من المصادقة

try {

    /*===========================
       1) استقبال البيانات
    ============================*/
    $user_id        = filterRequest("user_id");
    $student_code   = filterRequest("student_code"); 
    $dob            = filterRequest("dob");
    $grade_id       = filterRequest("grade_id");
    $section_id     = filterRequest("section_id");
    $parent_id      = filterRequest("parent_id");
    $enrollment_date= filterRequest("enrollment_date");

    /*===========================
       2) التحقق من الحقول
    ============================*/
    if (empty($user_id) || empty($dob) ||  empty($grade_id) || empty($section_id)) {
        printFailure("الحقول المطلوبة: user_id, dob, gender, grade_id, section_id");
    }

 

    if (empty($enrollment_date)) {
        $enrollment_date = date("Y-m-d");
    }

    /*===========================
       3) التحقق أن المستخدم طالب
    ============================*/
    $user = getData("users", "id = ?", [$user_id]);

    if (!$user || count($user) == 0) {
        printFailure("المستخدم غير موجود");
    }

    $user = $user[0]; // لأن getData ترجّع [] من fetchAll

    if ($user['role'] !== 'student') {
        printFailure("المستخدم المحدد ليس طالبًا");
    }

    if ((int)$user['active'] != 1) {
        printFailure("حساب المستخدم غير مفعل");
    }

    /*===========================
       4) تحقق من الصف والقسم
    ============================*/
    $grade = getData("grades", "id = ?", [$grade_id]);
    if (!$grade || count($grade) == 0) {
        printFailure("الصف غير موجود");
    }

    $section = getData("sections", "id = ?", [$section_id]);
    if (!$section || count($section) == 0) {
        printFailure("القسم غير موجود");
    }

    /*===========================
       5) التحقق من ولي الأمر (اختياري)
    ============================*/
    if (!empty($parent_id)) {
        $parent = getData("users", "id = ?", [$parent_id]);
        if (!$parent || count($parent) == 0) {
            printFailure("ولي الأمر غير موجود");
        }
        if ($parent[0]['role'] !== 'parent') {
            printFailure("المستخدم المحدد كولي أمر ليس دوره parent");
        }
    } else {
        $parent_id = null;
    }

    /*===========================
       6) توليد student_code إن لم يرسل
    ============================*/
    if (empty($student_code)) {
        $student_code = "STU-" . date("y") . "-" . $user_id . "-" . substr(uniqid(), -4);
    } else {
        $exists = getData("students", "student_code = ?", [$student_code]);
        if ($exists && count($exists) > 0) {
            printFailure("student_code مستخدم مسبقًا");
        }
    }

    /*===========================
       7) إدخال الطالب في جدول students
    ============================*/
    $existingStudent = getData("students", "user_id = ?", [$user_id]);
       if ($existingStudent && count($existingStudent) > 0) {
            printFailure("المستخدم المحدد موجود بالفعل كطالب");
        }
    $data = [
        "user_id"         => $user_id,
        "student_code"    => $student_code,
        "dob"             => $dob,
        "grade_id"        => $grade_id,
        "section_id"      => $section_id,
        "parent_id"       => $parent_id,
       // "enrollment_date" => $enrollment_date
    ];

    $insert = insertData("students", $data);

    if (!$insert) {
        printFailure("فشل إضافة الطالب");
    }

    /*===========================
       8) إرجاع بيانات الطالب كاملة بعد الإضافة
    ============================*/
    $student = getData(
        "students INNER JOIN users ON users.id = students.user_id",
        "students.user_id = ?",
        [$user_id]
    );

    if ($student && count($student) > 0) {
        printSuccess($student[0]);
    } else {
        printFailure("تم الإضافة ولكن فشل جلب البيانات");
    }

} catch (Throwable $e) {
    printFailure("Exception: " . $e->getMessage());
}
