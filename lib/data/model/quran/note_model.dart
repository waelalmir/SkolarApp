class NoteModel {
  int? id;
  int? pageId;
  String? selectedText;
  String? note;
  String? createdAt;

  NoteModel({
    this.id,
    this.pageId,
    this.selectedText,
    this.note,
    this.createdAt,
  });

  NoteModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    pageId = json['page_id'];
    selectedText = json['selected_text'];
    note = json['note'];
    createdAt = json['created_at'];
  }
}
