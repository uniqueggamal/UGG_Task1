// import 'dart:io';

// import 'package:internship_task/core/constants/app_endpoints.dart';
// import 'package:internship_task/features/user/models/profile_model.dart';

// class ProfileService {
//   Future<ProfileModel> getProfile() async {
//     // Simulate database fetch delay (optional, for realistic loading state)
//     await Future.delayed(const Duration(milliseconds: 500));

//     final client = HttpClient();

//     try {
   
//       final request = client.getUrl(Uri.parse(ApiEndpoints.fullProfile));

   
   
//     } catch (e) {
    
//     }

//     return const ProfileModel(
//       name: 'Unique G. Gamal',
//       title: 'BIM student | 8th Semester',
//       imagePath: 'assets/pp.jpg',
//       description:
//           "I am an enthusiastic and motivated Information Management student "
//           "with a strong academic background in information technology, business, "
//           "and management. I have developed foundational knowledge in software "
//           "development, database management, data analysis, and information systems "
//           "through academic projects and practical coursework. I am eager to apply "
//           "my academic knowledge in a professional environment, learn from "
//           "experienced professionals, and contribute positively to team projects "
//           "while continuously developing my technical and professional skills.",
//       academicQualification:
//           "Bachelor of Information Management (BIM)\n"
//           "National College of Computer Studies (NCCS)\n"
//           "Tribhuvan University\n"
//           "8th Semester",
//       technicalSkills:
//           "Flutter, Dart, Firebase, SQL, Python, Git, GitHub, "
//           "UI Design, Responsive Design, State Management.",
//       projects:
//           "Plant Disease Detection App\n"
//           "A Flutter-based mobile application that uses a machine learning "
//           "model to identify plant diseases from leaf images.\n\n"
//           "Internship Task App\n"
//           "A responsive Flutter application developed to demonstrate UI design, "
//           "responsive layouts, navigation, and state management.",
//       achievements:
//           "Flutter and Dart related certifications\n"
//           "Software development workshops and training\n"
//           "Academic projects and practical coursework\n"
//           "Technology-related seminars and events",
//       relevantCoursework:
//           "Software Engineering, Database Management, Business Information "
//           "Systems, Cloud Computing, Business Intelligence, IT Entrepreneurship, "
//           "Digital Economy, and Information Technology Management.",
//       interests: "Flutter, UI design, and cloud computing",
//       location: "Kathmandu, Nepal",
//     );
//   }
// }
