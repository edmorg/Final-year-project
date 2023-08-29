part of 'screens.dart';

class NavigationBase extends StatefulWidget {
  const NavigationBase({super.key});

  @override
  State<NavigationBase> createState() => _NavigationBaseState();
}

class _NavigationBaseState extends State<NavigationBase> {
  /// define the list of pages to show in the navigator
  final List<Widget> pageDestinations = <Widget>[
    const HomeScreen(),
    const SearchScreen(),
    const ChatScreen(),
    const ProfileView(),
  ];

  /// Initialize the current page index to 0
  int currentPageIndex = 0;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        destinations: const [
          NavigationDestination(
            icon: Icon(Iconsax.home),
            selectedIcon: Icon(Iconsax.home_15),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Iconsax.search_favorite),
            label: 'Search',
          ),
          NavigationDestination(
            icon: Icon(Iconsax.messages),
            label: 'Chats',
          ),
          NavigationDestination(
            icon: Icon(Iconsax.user),
            selectedIcon: Icon(Iconsax.profile_circle5),
            label: 'Profile',
          ),
        ],
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        selectedIndex: currentPageIndex,
      ),
      body: IndexedStack(index: currentPageIndex, children: pageDestinations),
    );
  }
}
