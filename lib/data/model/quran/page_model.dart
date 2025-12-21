class PageModel {
  int? id;
  String? title;
  String? content;

  PageModel({this.id, this.title, this.content});

  PageModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    content = json['content'];
  }
}
