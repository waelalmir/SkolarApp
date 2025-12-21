import 'package:get/get.dart';
import 'package:skolar/core/class/statusrequest.dart';
import 'package:skolar/core/functions/handlingdatacontroller.dart';
import 'package:skolar/data/datasource/remote/quran/quran_data.dart';
import 'package:skolar/data/model/quran/note_model.dart';
import 'package:skolar/data/model/quran/page_model.dart';

class NotesController extends GetxController {
  NotesData notesData = Get.put(NotesData(Get.find()));
  StatusRequest statusRequest = StatusRequest.none;

  List<NoteModel> notes = [];
  PageModel? currentPage;
  int currentPageId = 1;

  // للملاحظات المحددة
  String? selectedText;
  bool showNotesList = false;

  // جلب بيانات الصفحة
  // جلب بيانات الصفحة
  getPage(int pageId) async {
    // 1. تعيين حالة التحميل
    statusRequest = StatusRequest.loading;
    update();

    // 2. إرسال طلب جلب بيانات الصفحة
    var response = await notesData.getPageData(pageId);
    print("=============================== controller Response $response ");

    // 3. معالجة حالة الطلب
    statusRequest = handlingData(response);

    // 4. التحقق من النجاح
    if (StatusRequest.success == statusRequest) {
      // 💡 التعديل هنا ليصبح مشابهاً لـ getSubjects:
      if (response['status'] == "success") {
        // 5. توقع أن تكون 'data' قائمة (List)
        List listdata = response['data'];

        // 6. التحقق من وجود بيانات وأخذ العنصر الأول
        if (listdata.isNotEmpty) {
          // بما أننا نتوقع صفحة واحدة، نأخذ العنصر الأول من القائمة ونحوّله لـ PageModel
          currentPage = PageModel.fromJson(listdata[0]);
          currentPageId = pageId;

          // جلب الملاحظات المرتبطة بالصفحة
          await getNotes(pageId);
        } else {
          // إذا كانت القائمة فارغة
          statusRequest = StatusRequest.failure;
        }
      } else {
        // إذا كان response['status'] ليس "success" بعد نجاح الاتصال
        statusRequest = StatusRequest.failure;
      }
    }

    // التعامل مع فشل الاتصال (في حالة الـ else النهائية)
    if (StatusRequest.failure == statusRequest) {
      Get.snackbar("عذراً", "تعذر تحميل الصفحة");
    }

    update();
  }

  // جلب الملاحظات
  getNotes(int pageId) async {
    statusRequest = StatusRequest.loading;
    update();

    var response = await notesData.getNotesData(pageId);
    print("=============================== Notes Response $response ");

    statusRequest = handlingData(response);
    if (StatusRequest.success == statusRequest) {
      if (response != null && response['data'] != null) {
        notes.clear();
        List dataresponse = response['data'];
        notes.addAll(dataresponse.map((e) => NoteModel.fromJson(e)));
      }
    } else {
      statusRequest = StatusRequest.failure;
    }
    update();
  }

  // إضافة ملاحظة
  addNote(String selectedText, String noteText) async {
    statusRequest = StatusRequest.loading;
    update();

    var response = await notesData.addNoteData(
      currentPageId,
      selectedText,
      noteText,
    );
    print("=============================== Add Note Response $response ");

    statusRequest = handlingData(response);
    if (StatusRequest.success == statusRequest) {
      if (response != null && response['status'] == 'success') {
        await getNotes(currentPageId); // إعادة تحميل الملاحظات
        Get.back(); // إغلاق الدايالوج
        Get.snackbar("نجاح", "تم إضافة الملاحظة بنجاح");
      }
    } else {
      statusRequest = StatusRequest.failure;
      Get.snackbar("عذراً", "تعذر إضافة الملاحظة");
    }
    update();
  }

  // حذف ملاحظة
  deleteNote(int noteId) async {
    statusRequest = StatusRequest.loading;
    update();

    var response = await notesData.deleteNoteData(noteId);
    print("=============================== Delete Note Response $response ");

    statusRequest = handlingData(response);
    if (StatusRequest.success == statusRequest) {
      if (response != null && response['status'] == 'success') {
        notes.removeWhere((note) => note.id == noteId);
        Get.snackbar("نجاح", "تم حذف الملاحظة بنجاح");
      }
    } else {
      statusRequest = StatusRequest.failure;
      Get.snackbar("عذراً", "تعذر حذف الملاحظة");
    }
    update();
  }

  // حفظ النص المحدد وعرض خيارات الملاحظة
  setSelectedText(String text) {
    selectedText = text;
    update();
  }

  // تبديل عرض قائمة الملاحظات
  toggleNotesList() {
    showNotesList = !showNotesList;
    update();
  }

  @override
  void onInit() {
    getPage(currentPageId);
    super.onInit();
  }
}
