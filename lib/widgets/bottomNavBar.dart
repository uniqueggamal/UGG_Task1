import 'package:flutter/material.dart';
import 'package:internship_task/providers/navProvider.dart';
import 'package:provider/provider.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  @override
  Widget build(BuildContext context) {
    final navProvider = context.watch<NavProvider>();

    return BottomAppBar(
      color: Colors.white10,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            onPressed: () {
              navProvider.changeIndex(0);
            },
            icon: Icon(
              Icons.home,
              color: navProvider.currentIndex == 0
                  ? Colors.purple
                  : Colors.grey,
              size: navProvider.currentIndex == 0 ? 40 : 30,
            ),
          ),
          IconButton(
            onPressed: () {
              navProvider.changeIndex(1);
            },
            icon: Icon(
              Icons.book,
              color: navProvider.currentIndex == 1
                  ? Colors.purple
                  : Colors.grey,
              size: navProvider.currentIndex == 1 ? 40 : 30,
            ),
          ),
          IconButton(
            onPressed: () {
              navProvider.changeIndex(2);
            },
            icon: Icon(
              Icons.person,
              color: navProvider.currentIndex == 2
                  ? Colors.purple
                  : Colors.grey,
              size: navProvider.currentIndex == 2 ? 40 : 30,
            ),
          ),
        ],
      ),
    );
  }
}
