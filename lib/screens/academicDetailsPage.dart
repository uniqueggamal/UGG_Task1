import 'package:flutter/material.dart';
import 'package:internship_task/providers/navProvider.dart';
import 'package:internship_task/screens/academicdetails/sem8/it248.dart';
import 'package:internship_task/screens/academicdetails/sem8/it249.dart';
import 'package:internship_task/screens/academicdetails/sem8/it250.dart';
import 'package:internship_task/screens/academicdetails/sem8/it277.dart';
import 'package:provider/provider.dart';

class AcademicDetailsPage extends StatefulWidget {
  const AcademicDetailsPage({super.key});

  @override
  State<AcademicDetailsPage> createState() => _AcademicDetailsPageState();
}

class _AcademicDetailsPageState extends State<AcademicDetailsPage> {
  var subjects = {
    "IT 248": "IT Entrepreneurship and Management",
    "IT 249": "Business Intelligence",
    "IT 250": "Digital Economy",
    "IT 277": "Cloud Computing",
  };

  @override
  Widget build(BuildContext context) {
    final selectedSubject = context.watch<NavProvider>().subIndex;
    return selectedSubject == 'Subjects'
        ? buildSubjectList()
        : buildSubjectDetails(selectedSubject);
  }

  Widget buildSubjectList() {
    return ListView(
      padding: const EdgeInsets.all(12),
      children: [
        buildSubjectTile('IT 248'),
        buildSubjectTile('IT 249'),
        buildSubjectTile('IT 250'),
        buildSubjectTile('IT 277'),
      ],
    );
  }

  Widget buildSubjectTile(String subject) {
    final navProvider = context.watch<NavProvider>();

    return Card(
      child: ListTile(
        leading: const Icon(Icons.book),
        title: Text(subject),
        subtitle: const Text('Subject Details'),
        trailing: const Icon(Icons.arrow_forward_ios),
        onTap: () {
          navProvider.subjectIndex(subject);
        },
      ),
    );
  }

  Widget buildSubjectDetails(String selectedSubject) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          selectedSubject == "IT 248"
              ? It248()
              : selectedSubject == 'IT 249'
              ? It249()
              : selectedSubject == 'IT 250'
              ? It250()
              : It277(),
        ],
      ),
    );
  }
}
