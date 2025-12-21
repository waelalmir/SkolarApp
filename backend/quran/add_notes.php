<?php
include "../connect.php"; // يحتوي كل الدوال المساعدة


$pageId = filterRequest("pageid");
$selectedText = filterRequest("selectedtext");
$note = filterRequest("note");

// 💡 التأكد من تنظيف المتغيرات (ممارسة جيدة)
$pageId = trim($pageId);
$selectedText = trim($selectedText);
$note = trim($note);


$data = array(
    // 💡 مهم: استخدم نفس اسم العمود في قاعدة البيانات
    "page_id" => $pageId,
    "selected_text" => $selectedText,
    "note" => $note
);
// نفترض أن insertData تُرجع عدد الصفوف المتأثرة
$count = insertData("page_notes", $data, false); 


if ($count > 0) {
    
    // ✅ تصحيح: يجب إزالة استعلام SELECT المعقد وغير الضروري
    // لأنه يكفي إرجاع رسالة نجاح بعد عملية الإضافة.
    
    // ✅ تصحيح: استخدام الدالة المساعدة بشكل صحيح
    // نفترض أن printSuccess تقوم بطباعة استجابة JSON للنجاح
    echo json_encode([
        "status" => "success",
        "message" => "Note added successfully"
    ]);

} else {
    // ✅ تصحيح: استخدام الدالة المساعدة بشكل صحيح
    echo json_encode([
        "status" => "failure",
        "message" => "Failed to add note. Check database connection or constraints."
    ]);
}

// ⚠️ ملاحظة: إذا كان ملف connect.php يحتوي على دالة printSuccess / printFailure، استبدل الـ echo json_encode بها.
?>