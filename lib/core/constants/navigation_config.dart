class NavigationConfig {
  final String title;
  final bool showTopBar;
  final bool showBottomBar;

  const NavigationConfig({
    required this.title,
    this.showTopBar = true,
    this.showBottomBar = true,
  });
}

const navigationConfig = {
  "H0": NavigationConfig(title: 'Home', showTopBar: true, showBottomBar: true),

  "A0": NavigationConfig(
    title: 'Academic',
    showTopBar: true,
    showBottomBar: true,
  ),

  "A1": NavigationConfig(
    title: 'Academic',
    showTopBar: true,
    showBottomBar: true,
  ),
  "A2": NavigationConfig(
    title: 'Academic',
    showTopBar: true,
    showBottomBar: true,
  ),
  "A3": NavigationConfig(
    title: 'Academic',
    showTopBar: true,
    showBottomBar: true,
  ),

  "P0": NavigationConfig(
    title: 'Profile',
    showTopBar: true,
    showBottomBar: true,
  ),

  "P1": NavigationConfig(
    title: 'Edit Profile',
    showTopBar: true,
    showBottomBar: false,
  ),
};
