import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skolar/controller/quran/notes-controller.dart';
import 'package:skolar/core/class/handlingdataview.dart';
import 'package:skolar/core/constant/color.dart';
import 'package:skolar/core/shared/customappbar.dart';

class NotesView extends StatelessWidget {
  const NotesView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(NotesController());

    return Scaffold(
      appBar: Customappbar(title: "الملاحظات"),
      body: GetBuilder<NotesController>(
        builder: (controller) {
          return HandlingDataRequest(
            statusRequest: controller.statusRequest,
            widget: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Card(
                    color: AppColor.primaryColor,
                    child: ListTile(
                      leading: Icon(Icons.note, color: Colors.white),
                      title: Text(
                        "ملاحظاتي (${controller.notes.length})",
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      trailing: Icon(
                        controller.showNotesList
                            ? Icons.expand_less
                            : Icons.expand_more,
                        color: Colors.white,
                      ),
                      onTap: controller.toggleNotesList,
                    ),
                  ),

                  const SizedBox(height: 16),

                  if (controller.showNotesList)
                    Expanded(
                      flex: 1,
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              const Text(
                                "قائمة الملاحظات",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Expanded(
                                child: controller.notes.isEmpty
                                    ? const Center(
                                        child: Text("لا توجد ملاحظات بعد"),
                                      )
                                    : ListView.builder(
                                        itemCount: controller.notes.length,
                                        itemBuilder: (context, index) {
                                          final note = controller.notes[index];
                                          return Card(
                                            margin: const EdgeInsets.symmetric(
                                              vertical: 4,
                                            ),
                                            color: Colors.grey[100],
                                            child: ListTile(
                                              leading: CircleAvatar(
                                                backgroundColor:
                                                    AppColor.primaryColor,
                                                child: Text(
                                                  "${index + 1}",
                                                  style: const TextStyle(
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                              title: Text(
                                                note.selectedText ?? "",
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              subtitle: Text(note.note ?? ""),
                                              trailing: IconButton(
                                                icon: const Icon(
                                                  Icons.delete,
                                                  color: Colors.red,
                                                ),
                                                onPressed: () {
                                                  Get.defaultDialog(
                                                    title: "تأكيد الحذف",
                                                    middleText:
                                                        "هل أنت متأكد من حذف هذه الملاحظة؟",
                                                    textConfirm: "نعم",
                                                    textCancel: "إلغاء",
                                                    confirmTextColor:
                                                        Colors.white,
                                                    onConfirm: () {
                                                      controller.deleteNote(
                                                        note.id!,
                                                      );
                                                      Get.back();
                                                    },
                                                  );
                                                },
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                  Expanded(
                    flex: 2,
                    child: controller.currentPage == null
                        ? const Center(child: Text("لا يوجد محتوى"))
                        : Card(
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    controller.currentPage!.title ?? "",
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                  Expanded(
                                    child: SingleChildScrollView(
                                      child: GestureDetector(
                                        onTap: () {
                                          TextSelection? _selection;

                                          Get.dialog(
                                            AlertDialog(
                                              title: const Text(
                                                'حدد النص ثم اضغط إضافة ملاحظة',
                                                textAlign: TextAlign.center,
                                              ),
                                              content: SizedBox(
                                                width: double.maxFinite,
                                                height: 300,
                                                child: SingleChildScrollView(
                                                  child: SelectableText(
                                                    controller
                                                            .currentPage!
                                                            .content ??
                                                        "",
                                                    style: const TextStyle(
                                                      fontSize: 16,
                                                      height: 1.5,
                                                    ),
                                                    onSelectionChanged:
                                                        (sel, cause) {
                                                          _selection = sel;
                                                        },
                                                  ),
                                                ),
                                              ),
                                              actions: [
                                                TextButton(
                                                  onPressed: Get.back,
                                                  child: const Text(
                                                    'إلغاء',
                                                    style: TextStyle(
                                                      color: Colors.grey,
                                                    ),
                                                  ),
                                                ),
                                                ElevatedButton(
                                                  onPressed: () {
                                                    if (_selection != null &&
                                                        _selection!.isValid &&
                                                        _selection!.start !=
                                                            _selection!.end) {
                                                      final content = controller
                                                          .currentPage!
                                                          .content!;
                                                      final selectedText =
                                                          content
                                                              .substring(
                                                                _selection!
                                                                    .start,
                                                                _selection!.end,
                                                              )
                                                              .trim();

                                                      if (selectedText
                                                          .isNotEmpty) {
                                                        Get.back();

                                                        final textCtrl =
                                                            TextEditingController();

                                                        Get.dialog(
                                                          AlertDialog(
                                                            title: const Text(
                                                              'إضافة ملاحظة جديدة',
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                            ),
                                                            content: Column(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .min,
                                                              children: [
                                                                Container(
                                                                  padding:
                                                                      const EdgeInsets.all(
                                                                        12,
                                                                      ),
                                                                  decoration: BoxDecoration(
                                                                    color: Colors
                                                                        .grey[100],
                                                                    border: Border.all(
                                                                      color: Colors
                                                                          .grey[300]!,
                                                                    ),
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                          8,
                                                                        ),
                                                                  ),
                                                                  child: Column(
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      Text(
                                                                        'النص المحدد:',
                                                                        style: TextStyle(
                                                                          color:
                                                                              AppColor.primaryColor,
                                                                          fontWeight:
                                                                              FontWeight.bold,
                                                                        ),
                                                                      ),
                                                                      const SizedBox(
                                                                        height:
                                                                            8,
                                                                      ),
                                                                      Text(
                                                                        '"$selectedText"',
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                                const SizedBox(
                                                                  height: 16,
                                                                ),
                                                                TextField(
                                                                  controller:
                                                                      textCtrl,
                                                                  maxLines: 3,
                                                                  decoration: InputDecoration(
                                                                    labelText:
                                                                        'اكتب ملاحظتك هنا',
                                                                    border:
                                                                        const OutlineInputBorder(),
                                                                    focusedBorder: OutlineInputBorder(
                                                                      borderSide: BorderSide(
                                                                        color: AppColor
                                                                            .primaryColor,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            actions: [
                                                              TextButton(
                                                                onPressed:
                                                                    Get.back,
                                                                child: const Text(
                                                                  'إلغاء',
                                                                  style: TextStyle(
                                                                    color: Colors
                                                                        .grey,
                                                                  ),
                                                                ),
                                                              ),
                                                              ElevatedButton(
                                                                onPressed: () {
                                                                  final txt =
                                                                      textCtrl
                                                                          .text
                                                                          .trim();
                                                                  if (txt
                                                                      .isNotEmpty) {
                                                                    controller
                                                                        .addNote(
                                                                          selectedText,
                                                                          txt,
                                                                        );
                                                                  } else {
                                                                    Get.snackbar(
                                                                      'تنبيه',
                                                                      'يرجى كتابة الملاحظة أولاً',
                                                                    );
                                                                  }
                                                                },
                                                                style: ElevatedButton.styleFrom(
                                                                  backgroundColor:
                                                                      AppColor
                                                                          .primaryColor,
                                                                  foregroundColor:
                                                                      Colors
                                                                          .white,
                                                                ),
                                                                child: const Text(
                                                                  'حفظ الملاحظة',
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        );
                                                      }
                                                    } else {
                                                      Get.snackbar(
                                                        'تنبيه',
                                                        'يرجى تحديد نص أولاً',
                                                      );
                                                    }
                                                  },
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                        backgroundColor:
                                                            AppColor
                                                                .primaryColor,
                                                        foregroundColor:
                                                            Colors.white,
                                                      ),
                                                  child: const Text(
                                                    'إضافة ملاحظة',
                                                  ),
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                        child: Text(
                                          controller.currentPage!.content ?? "",
                                          style: const TextStyle(
                                            fontSize: 16,
                                            height: 1.5,
                                          ),
                                          textAlign: TextAlign.justify,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
