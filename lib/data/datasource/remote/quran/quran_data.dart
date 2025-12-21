import 'package:skolar/core/class/crud.dart';
import 'package:skolar/linkapi.dart';

class NotesData {
  Crud crud;
  NotesData(this.crud);

  getPageData(int pageId) async {
    var response = await crud.postData(AppLink.getPage, {
      "pageid": pageId.toString(),
    });
    return response.fold((l) => l, (r) => r);
  }

  getNotesData(int pageId) async {
    var response = await crud.postData(AppLink.getNotes, {
      "pageid": pageId.toString(),
    });
    return response.fold((l) => l, (r) => r);
  }

  addNoteData(int pageId, String selectedText, String note) async {
    var response = await crud.postData(AppLink.addNote, {
      "pageid": pageId.toString(),
      "selectedtext": selectedText,
      "note": note,
    });
    return response.fold((l) => l, (r) => r);
  }

  deleteNoteData(int noteId) async {
    var response = await crud.postData(AppLink.deleteNote, {
      "note_id": noteId.toString(),
    });
    return response.fold((l) => l, (r) => r);
  }
}
