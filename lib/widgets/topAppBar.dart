import 'package:flutter/material.dart';
import 'package:internship_task/providers/navProvider.dart';
import 'package:provider/provider.dart';

class TopAppBar extends StatelessWidget implements PreferredSizeWidget {
  const TopAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final navProvider = context.watch<NavProvider>();
    final title = navProvider.currentIndex == 0
        ? "HomePage"
        : navProvider.currentIndex == 1
        ? navProvider.subIndex
        : navProvider.currentIndex == 2
        ? "Profile"
        : '';

    return AppBar(
      title: Text(title),
      automaticallyImplyLeading: false,
      leading: navProvider.backState
          ? IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: navProvider.defaultSubjectIndex,
            )
          : null,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
