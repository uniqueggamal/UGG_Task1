import 'package:flutter/material.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          SizedBox(height: 20),
          Container(
            padding: EdgeInsets.all(20),
            // margin: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.black,
                  blurRadius: 4,
                  offset: Offset(1, 1),
                ),
              ],
            ),
            child: Row(
              // mainAxisSize: MainAxisSize.min,
              // crossAxisAlignment: CrossAxisAlignment.,
              children: [
                Icon(Icons.person, size: 100),
                // SizedBox(width: 30),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Name: Ram Prassad'),
                    Text('Age: 22'),
                    Text('DOB: 2003/1/1'),
                    Text('Address: Paknajol Kathmandu'),
                    Text('Faculty: BIM'),
                    Text('Semester: 8th Semester'),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
