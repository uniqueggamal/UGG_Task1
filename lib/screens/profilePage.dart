import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(radius: 42, child: Icon(Icons.person, size: 48)),
          SizedBox(height: 20),
          Text(
            'Ram Prassad',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Text('BIM student | 8th Semester'),
          SizedBox(height: 24),
          Card(
            child: ListTile(
              leading: Icon(Icons.lightbulb_outline),
              title: Text('Interests'),
              subtitle: Text('Flutter, UI design, and cloud computing'),
            ),
          ),
          Card(
            child: ListTile(
              leading: Icon(Icons.location_on_outlined),
              title: Text('Location'),
              subtitle: Text('Kathmandu, Nepal'),
            ),
          ),
        ],
      ),
    );
  }
}
