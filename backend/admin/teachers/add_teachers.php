<?php
include "../../connect.php";  // يحتوي كل الدوال المساعدة
checkAuthenticate();          // ✅ تحقق من المصادقة

try {

    /*===========================
       1) استقبال البيانات
    ============================*/
    $user_id        = filterRequest("userid");
    $grade_id       = filterRequest("gradeid");
    $subject_id       = filterRequest("subjectid");
    

    /*===========================
       2) التحقق من الحقول
    ============================*/
    if (empty($user_id) || empty($subject_id) ||  empty($grade_id) ) {
        printFailure("الحقول المطلوبة: user_id, dob, gender, grade_id, section_id");
    }

 

  

    /*===========================
       3) التحقق أن المستخدم طالب
    ============================*/
    $user = getData("users", "id = ?", [$user_id]);

    if (!$user || count($user) == 0) {
        printFailure("المستخدم غير موجود");
    }

    $user = $user[0]; // لأن getData ترجّع [] من fetchAll

    if ($user['role'] !== 'teacher') {
        printFailure("المستخدم المحدد ليس استاذا");
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

    // $section = getData("sections", "id = ?", [$section_id]);
    // if (!$section || count($section) == 0) {
    //     printFailure("القسم غير موجود");
    // }

    /*===========================
       5) التحقق من ولي الأمر (اختياري)
    ============================*/
    // if (!empty($parent_id)) {
    //     $parent = getData("users", "id = ?", [$parent_id]);
    //     if (!$parent || count($parent) == 0) {
    //         printFailure("ولي الأمر غير موجود");
    //     }
    //     if ($parent[0]['role'] !== 'parent') {
    //         printFailure("المستخدم المحدد كولي أمر ليس دوره parent");
    //     }
    // } else {
    //     $parent_id = null;
    // }

    /*===========================
       6) توليد student_code إن لم يرسل
    ============================*/
    // if (empty($student_code)) {
    //     $student_code = "STU-" . date("y") . "-" . $user_id . "-" . substr(uniqid(), -4);
    // } else {
    //     $exists = getData("students", "student_code = ?", [$student_code]);
    //     if ($exists && count($exists) > 0) {
    //         printFailure("student_code مستخدم مسبقًا");
    //     }
    // }

    /*===========================
       7) إدخال الطالب في جدول students
    ============================*/
    $existingStudent = getData("teachers", "user_id = ?", [$user_id]);
       if ($existingStudent && count($existingStudent) > 0) {
            printFailure("المستخدم المحدد موجود بالفعل كاستاذ");
        }
    $data = [
        "user_id"         => $user_id,
        "grade_id"        => $grade_id,
        "subject_id"        => $subject_id,
        ];

    $insert = insertData("teachers", $data);

    if (!$insert) {
        printFailure("فشل إضافة الأستاذ");
    }

    /*===========================
       8) إرجاع بيانات الطالب كاملة بعد الإضافة
    ============================*/
    $teachers = getData(
        "teachers INNER JOIN users ON users.id = teachers.user_id",
        "teachers.user_id = ?",
        [$user_id]
    );

    if ($teachers && count($teachers) > 0) {
        printSuccess($teachers[0]);
    } else {
        printFailure("تم الإضافة ولكن فشل جلب البيانات");
    }

} catch (Throwable $e) {
    printFailure("Exception: " . $e->getMessage());
}
