class AppLink {
  static const String server = "https://waelalmir.com/skolar/admin";
  static const String quran = "https://waelalmir.com/skolar/quran";
  static const String apiUsername = "wael";
  static const String apiPassword = "wael12345";
  static const String addUser = "$server/users/add_users.php";
  static const String viewUser = "$server/users/users.php";
  static const String viewGrade = "$server/viewgrades.php";
  static const String viewSections = "$server/viewsections.php";
  static const String viewStudent = "$server/student/view_student.php";
  static const String viewStudentbyRole =
      "$server/student/view_studentbyrole.php";
  static const String viewstudentbygrade =
      "$server/student/view_studentbygrade.php";
  static const String addStudent = "$server/student/add_student.php";
  static const String searchstudent = "$server/student/search_student.php";

  /////////////////////////subj
  static const String viewSubjects = "$server/subjects/view_subjects.php";
  static const String addSubjects = "$server/subjects/add_subjects.php";

  /// Quran API Endpoints
  static const String getPage = "$quran/get_pages.php";
  static const String getNotes = "$quran/get_notes.php";
  static const String addNote = "$quran/add_notes.php";
  static const String deleteNote = "$quran/delete_notes.php";

  /////////////////session
  static const String viewSession = "$server/session/view_session.php";
  static const String addSession = "$server/session/add_session.php";
  static const String editSession = "$server/session/edit_session.php";
  static const String deleteSession = "$server/session/delete_session.php";
  ////////////////teachers
  static const String viewTeachers = "$server/teachers/view_teachers.php";
  static const String addTeachers = "$server/teachers/add_teachers.php";
  static const String viewteachersbyrole =
      "$server/teachers/view_teachersbyrole.php";

  //////////////////////exam
  static const String viewExams = "$server/exam/view_exam.php";
  static const String addExams = "$server/exam/add_exam.php";

  //////////////////////mark
  static const String viewMark = "$server/mark/view_mark.php";
  static const String addMark = "$server/mark/add_mark.php";
  ///////////attendance
  static const String addAttendance = "$server/attendance/view_attendance.php";
  static const String viewAttendance = "$server/attendance/attendance.php";
}
