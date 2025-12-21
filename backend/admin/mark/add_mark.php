<?php

include "../../connect.php"; // الاتصال بقاعدة البيانات
checkAuthenticate();

// 🧩 جلب البيانات
$examid      = filterRequest("examid");
$studentid   = filterRequest("studentid");
$mark        = filterRequest("mark");

// 🧩 التحقق من الحقول المطلوبة
if (empty($examid) || empty($studentid) || empty($mark)) {
    printFailure("الرجاء إدخال جميع الحقول المطلوبة (اسم الطالب و اختيار الامتحان و العلامة )");
    exit;
}

// 🧩 فحص إذا كان الطالب لديه علامة مسبقة لهذا الامتحان
$check = getData("grades_marks", "exam_id = ? AND student_id = ?", [$examid, $studentid]);

if (!empty($check)) {

    // موجود → نعمل تحديث
    $update = updateData(
        "grades_marks",
        ["mark" => $mark],
        "exam_id = $examid AND student_id = $studentid"
    );

    if ($update) {

        // جلب أحدث البيانات من الـ VIEW
        $stmt = $con->prepare("SELECT * FROM view_grades_marks 
                               WHERE exam_id = ? AND student_id = ?
                               ORDER BY grade_mark_id DESC LIMIT 1");
        $stmt->execute([$examid, $studentid]);
        $mark_details = $stmt->fetch(PDO::FETCH_ASSOC);

        printSuccess($mark_details);
    } else {
        printFailure("فشل في تحديث العلامة");
    }

    exit;
}

// 🧩 لا يوجد سجل سابق → إدخال جديد
$data = array(
    "exam_id" => $examid,
    "student_id" => $studentid,
    "mark" => $mark,
);

$count = insertData("grades_marks", $data);

if ($count > 0) {

    // جلب أحدث سجل
    $stmt = $con->prepare("SELECT * FROM view_grades_marks ORDER BY grade_mark_id DESC LIMIT 1");
    $stmt->execute();
    $mark_details = $stmt->fetch(PDO::FETCH_ASSOC);

    printSuccess($mark_details);
} else {
    printFailure("فشل في إضافة علامة الامتحان للطالب");
}

?>
