    <?php
include "../connect.php";

$noteId = $_GET['note_id'] ?? null;

if($noteId) {
    try {
        if(deleteData("page_notes", "id = ?", [$noteId])) {
            printSuccess("تم حذف الملاحظة بنجاح");
        } else {
            printFailure("فشل في حذف الملاحظة");
        }
    } catch(Exception $e) {
        printFailure($e->getMessage());
    }
} else {
    printFailure("معرف الملاحظة مطلوب");
}
?>