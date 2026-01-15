import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spotify_clone/constantes/font.dart';
import 'package:flutter_spotify_clone/core/app/app_theme.dart';
import 'package:flutter_spotify_clone/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:flutter_spotify_clone/features/auth/presentation/pages/auth_gate.dart';
import 'package:flutter_spotify_clone/features/auth/presentation/pages/login_screen.dart';
import 'package:flutter_spotify_clone/core/di/injection.dart';
import 'package:flutter_spotify_clone/core/navigation/navigator_util.dart';
import 'screens/home_screen.dart';
import 'screens/search_screen.dart';
import 'screens/library_screen.dart';
import 'screens/premium_screen.dart';
import 'screens/profile_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider(create: (_) => getIt<AuthBloc>())],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: AppTheme.darkTheme(),
        navigatorKey: NavigatorUtil.navigatorKey,
        routes: {
          '/login': (_) => const LoginScreen(),
          '/home': (_) => const MainShell(),
        },
        home: const AuthGate(),
      ),
    );
  }
}

class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    if (_selectedIndex == index) {
      _navigatorKeys[index].currentState?.popUntil((route) => route.isFirst);
      return;
    }
    setState(() => _selectedIndex = index);
  }

  final _navigatorKeys = List.generate(5, (_) => GlobalKey<NavigatorState>());

  final _tabRootPages = const [
    HomeScreen(),
    SearchScreen(),
    LibraryScreen(),
    PremiumScreen(),
    ProfileScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final currentNavigator = _navigatorKeys[_selectedIndex].currentState;
        if (currentNavigator != null && currentNavigator.canPop()) {
          currentNavigator.pop();
          return false;
        }
        return true;
      },
      child: Scaffold(
        appBar: _customAppBar(_selectedIndex),
        body: IndexedStack(
          index: _selectedIndex,
          children: List.generate(
            _tabRootPages.length,
            (index) => _TabNavigator(
              navigatorKey: _navigatorKeys[index],
              rootPage: _tabRootPages[index],
            ),
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.black,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.grey.shade400,
          selectedIconTheme: const IconThemeData(color: Colors.white),
          unselectedIconTheme: IconThemeData(color: Colors.grey.shade400),
          selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w500),
          unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w500),
          showSelectedLabels: true,
          showUnselectedLabels: true,
          type: BottomNavigationBarType.fixed,
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              activeIcon: Icon(Icons.home_filled),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              activeIcon: Icon(Icons.search, size: 24),
              label: 'Search',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.library_music),
              activeIcon: Icon(Icons.library_music_rounded),
              label: 'Your Library',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.workspace_premium),
              label: 'Premium',
            ),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          ],
        ),
      ),
    );
  }

  _customAppBar(int tabIndex) {
    return AppBar(
      title: _getTitleWidget(tabIndex),
      backgroundColor: Colors.black,
      foregroundColor: Colors.white,
      centerTitle: true,
      titleSpacing: 0,
      leading: Padding(
        padding: const EdgeInsets.all(8.0),
        child: _leadingIcon('C'),
      ),
      leadingWidth: 50,
      elevation: 0,
      iconTheme: const IconThemeData(color: Colors.white),
    );
  }

  Widget _getTitleWidget(int tabIndex) {
    switch (tabIndex) {
      case 0:
        return DefaultTitleWidget(onFilterChanged: (filter) {});
      case 1:
        return _title('Search');
      case 2:
        return _title('Your Library');
      case 3:
        return _title('Premium');
      case 4:
        return _title('Profile');
      default:
        return DefaultTitleWidget(onFilterChanged: (filter) {});
    }
  }

  Row _title(String title) {
    return Row(
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  _leadingIcon(String s) {
    return Container(
      width: 40, // กำหนดความกว้าง
      height: 40, // กำหนดความสูง
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.green.shade600,
      ),
      child: Center(
        child: Text(
          s.substring(0, 1).toUpperCase(),
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

class _TabNavigator extends StatelessWidget {
  const _TabNavigator({required this.navigatorKey, required this.rootPage});

  final GlobalKey<NavigatorState> navigatorKey;
  final Widget rootPage;

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      onGenerateRoute: (settings) {
        return MaterialPageRoute(builder: (_) => rootPage);
      },
    );
  }
}

class DefaultTitleWidget extends StatefulWidget {
  final Function(dynamic filter) onFilterChanged;
  const DefaultTitleWidget({super.key, required this.onFilterChanged});

  @override
  State<DefaultTitleWidget> createState() => _DefaultTitleWidgetState();
}

class _DefaultTitleWidgetState extends State<DefaultTitleWidget> {
  int selectedFilter = 1;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        FilterItem(
          onSelected: (filter) {},
          selected: selectedFilter == 0,
          text: 'All',
          index: 0,
        ),
        FilterItem(
          onSelected: (filter) {},
          selected: selectedFilter == 1,
          text: 'Music',
          index: 1,
        ),
        FilterItem(
          onSelected: (filter) {},
          selected: selectedFilter == 2,
          text: 'Podcast',
          index: 2,
        ),
        FilterItem(
          onSelected: (filter) {},
          selected: selectedFilter == 3,
          text: 'Wrapper',
          index: 3,
          spacial: true,
        ),
      ],
    );
  }
}

class FilterItem extends StatefulWidget {
  final String text;
  final Function(dynamic filter) onSelected;
  final bool selected;
  final int index;
  final bool spacial;
  const FilterItem({
    super.key,
    required this.text,
    required this.onSelected,
    required this.selected,
    required this.index,
    this.spacial = false,
  });

  @override
  State<FilterItem> createState() => _FilterItemState();
}

class _FilterItemState extends State<FilterItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 4, left: 4),
      decoration: BoxDecoration(
        color: widget.selected ? Colors.grey.shade800 : null,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 5),
            decoration: BoxDecoration(
              color: widget.selected ? Colors.green : Colors.grey.shade800,
              borderRadius: BorderRadius.circular(20),
              border:
                  widget.spacial
                      ? Border.all(color: Colors.white, width: 1)
                      : null,
            ),
            child: Row(
              children: [
                Text(
                  widget.text,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: ConstantsFont.defaultFontSize,
                    fontWeight:
                        widget.spacial ? FontWeight.w700 : FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          if (widget.selected) _moreMenu(index: widget.index),
        ],
      ),
    );
  }

  _moreMenu({required index}) {
    return Row(
      children: [
        InkWell(
          onTap: () {},
          child: Container(
            padding: EdgeInsets.only(right: 10, left: 6),
            decoration: BoxDecoration(),
            child: Text(
              'Following',
              style: TextStyle(
                color: Colors.white,
                fontSize: ConstantsFont.defaultFontSize,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
