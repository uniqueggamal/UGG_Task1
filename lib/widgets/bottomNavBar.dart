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

    final activeColor = Colors.purple;
    final inactiveColor = Colors.grey;

    final activeIconSize = 40.0;
    final inactiveIconSize = 30.0;

    final activeStyleText = TextStyle(color: activeColor, fontSize: 12);

    final inactiveStyleText = TextStyle(color: inactiveColor, fontSize: 11);

    return BottomAppBar(
      height: 100,
      color: Colors.white10,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            children: [
              IconButton(
                padding: EdgeInsets.zero,
                onPressed: () {
                  navProvider.changeIndex(0);
                },
                icon: Icon(
                  Icons.home,
                  color: navProvider.currentIndex == 0
                      ? activeColor
                      : inactiveColor,
                  size: navProvider.currentIndex == 0
                      ? activeIconSize
                      : inactiveIconSize,
                ),
              ),
              Text(
                "Home",
                style: navProvider.currentIndex == 0
                    ? activeStyleText
                    : inactiveStyleText,
              ),
            ],
          ),
          Column(
            children: [
              IconButton(
                onPressed: () {
                  navProvider.changeIndex(1);
                },
                icon: Icon(
                  Icons.book,
                  color: navProvider.currentIndex == 1
                      ? activeColor
                      : inactiveColor,
                  size: navProvider.currentIndex == 1
                      ? activeIconSize
                      : inactiveIconSize,
                ),
              ),
              Text(
                "Subjects",
                style: navProvider.currentIndex == 1
                    ? activeStyleText
                    : inactiveStyleText,
              ),
            ],
          ),
          Column(
            children: [
              IconButton(
                onPressed: () {
                  navProvider.changeIndex(2);
                },
                icon: Icon(
                  Icons.person,
                  color: navProvider.currentIndex == 2
                      ? activeColor
                      : inactiveColor,
                  size: navProvider.currentIndex == 2
                      ? activeIconSize
                      : inactiveIconSize,
                ),
              ),
              Text(
                "Profile",
                style: navProvider.currentIndex == 2
                    ? activeStyleText
                    : inactiveStyleText,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
