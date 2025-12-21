import 'package:get/get.dart';
import 'package:skolar/view/screen/attendance/attendance_student.dart';
import 'package:skolar/view/screen/attendance/view_attendance.dart';
import 'package:skolar/view/screen/exam/add_exam.dart';
import 'package:skolar/view/screen/exam/view_exam.dart';
import 'package:skolar/view/screen/grades/viewGrades.dart';
import 'package:skolar/view/screen/home.dart';
import 'package:skolar/view/screen/marks/addmark.dart';
import 'package:skolar/view/screen/marks/viewmark.dart';
import 'package:skolar/view/screen/sections/sections.dart';
import 'package:skolar/view/screen/sections/sectionsdetails.dart';
import 'package:skolar/view/screen/session/addsession.dart';
import 'package:skolar/view/screen/session/viewsession.dart';
import 'package:skolar/view/screen/student/addstudents.dart';
import 'package:skolar/view/screen/student/viewstudents.dart';
import 'package:skolar/view/screen/studentdetails/studentdetails.dart';
import 'package:skolar/view/screen/subjects/addsubjects.dart';
import 'package:skolar/view/screen/subjects/viewsubjects.dart';
import 'package:skolar/view/screen/teachers/add_teachers.dart';
import 'package:skolar/view/screen/teachers/view_teacher.dart';
import 'package:skolar/view/screen/users/addusers.dart';
import 'package:skolar/view/screen/users/users.dart';

import 'core/constant/routes.dart';
import 'core/middleware/middleware.dart';

// تم تحويلها من Map إلى List<GetPage>
List<GetPage<dynamic>> routes = [
  // Auth
  GetPage(
    name: "/",
    page: () => const HomePage(),
    middlewares: [MyMiddleWare()],
  ),

  GetPage(name: AppRoutes.homePage, page: () => const HomePage()),
  GetPage(name: AppRoutes.addUser, page: () => const Addusers()),
  GetPage(name: AppRoutes.users, page: () => const Users()),
  GetPage(name: AppRoutes.viewgrades, page: () => const ViewGrades()),
  GetPage(name: AppRoutes.sectionsdetails, page: () => const Sectionsdetails()),
  GetPage(name: AppRoutes.sections, page: () => const Sections()),
  GetPage(name: AppRoutes.students, page: () => const Viewstudents()),
  GetPage(name: AppRoutes.studentdetails, page: () => const Studentdetails()),
  GetPage(name: AppRoutes.addstudents, page: () => const Addstudents()),
  GetPage(name: AppRoutes.subjects, page: () => const Viewsubjects()),
  GetPage(name: AppRoutes.addsubjects, page: () => const Addsubjects()),
  GetPage(name: AppRoutes.viewsession, page: () => const Viewsession()),
  GetPage(name: AppRoutes.addsession, page: () => const Addsession()),
  GetPage(name: AppRoutes.viewteachers, page: () => const ViewTeachers()),
  GetPage(name: AppRoutes.addteachers, page: () => const AddTeachers()),
  GetPage(name: AppRoutes.viewexam, page: () => const ViewExam()),
  GetPage(name: AppRoutes.addexam, page: () => const AddExam()),
  GetPage(name: AppRoutes.viewmark, page: () => const ViewMark()),
  GetPage(name: AppRoutes.addmark, page: () => const AddMark()),
  GetPage(name: AppRoutes.viewattendance, page: () => const ViewAttendance()),
  GetPage(
    name: AppRoutes.attendanceStudent,
    page: () => const AttendanceStudent(),
  ),
];
