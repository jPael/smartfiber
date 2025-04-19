import 'package:flutter/material.dart';
import 'package:iconic/iconic.dart';
import 'package:ionicons/ionicons.dart';
import 'package:smartfiber/pages/accuracy_page.dart';
import 'package:smartfiber/pages/activity_log_page.dart';
import 'package:smartfiber/pages/home_page.dart';
import 'package:smartfiber/pages/model_flow_page.dart';

class HomeLayoutPage extends StatefulWidget {
  const HomeLayoutPage({super.key});

  @override
  HomeLayoutPageState createState() => HomeLayoutPageState();
}

class HomeLayoutPageState extends State<HomeLayoutPage> {
  bool extendBehindAppbar = false;

  final List<String> titles = ["SmartFiber", "Accuracy", "Model Flow", "Activity Log"];

  int selectedView = 0;
  final PageController _pageController = PageController();
  List<int> navigationStack = [0];

  final List<Widget> views = [HomePage(), AccuracyPage(), ModelFlowPage(), ActivityLogPage()];

  void _onItemTapped(int index) {
    if (index == selectedView) return;

    // if (index == 2) {
    //   setState(() {
    //     extendBehindAppbar = true;
    //   });
    // } else {
    //   extendBehindAppbar = false;
    // }

    if (index == 0) {
      navigationStack = [0];
    } else {
      navigationStack.add(index);
    }

    setState(() {
      selectedView = index;
    });

    _pageController.jumpToPage(index);
  }

  void _handlePop(bool didPop) {
    if (!didPop && navigationStack.length > 1) {
      navigationStack.removeLast();
      int previousView = navigationStack.last;

      setState(() {
        selectedView = previousView;
        // extendBehindAppbar = (previousView == 2);
      });

      _pageController.jumpToPage(previousView);
    }
  }

  //  @override
  // void initState() {
  //   super.initState();
  //   floatingButtons = [
  //     null,
  //     null,
  //     // FloatingActionButton.extended(
  //     //   onPressed: () =>
  //     //       Navigator.push(context, MaterialPageRoute(builder: (context) => NewChatPage())),
  //     //   label: Text("New chat"),
  //     //   icon: Icon(Ionicons.pencil),
  //     // ),
  //     null,
  //     null
  //   ];
  // }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: navigationStack.length <= 1,
      onPopInvoked: _handlePop,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          automaticallyImplyLeading: false,
          title: Text(
            titles[selectedView],
            style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 8 * 4),
          ),
        ),
        extendBodyBehindAppBar: extendBehindAppbar,
        // floatingActionButton: floatingButtons[selectedView],
        body: PageView(
          controller: _pageController,
          physics: const NeverScrollableScrollPhysics(), // Disable swipe to change page
          children: views,
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: selectedView,
          onTap: _onItemTapped,
          selectedItemColor: Theme.of(context).colorScheme.secondary,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          selectedLabelStyle: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          unselectedLabelStyle: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          unselectedItemColor:
              HSLColor.fromColor(Theme.of(context).colorScheme.primary).withSaturation(1).toColor(),
          backgroundColor: Colors.white,
          iconSize: 8 * 4,
          items: [
            BottomNavigationBarItem(
              icon: const Icon(Ionicons.home_outline),
              activeIcon: const Icon(Ionicons.home),
              label: "Home",
              backgroundColor: Colors.white,
            ),
            BottomNavigationBarItem(
              icon: const Icon(Iconic.target),
              activeIcon: const Icon(Iconic.target_bold),
              label: "Accuracy",
              backgroundColor: Colors.white,
            ),
            BottomNavigationBarItem(
              icon: const Icon(Ionicons.git_branch_outline),
              activeIcon: const Icon(Ionicons.git_branch),
              label: "Model Flow",
              backgroundColor: Colors.white,
            ),
            BottomNavigationBarItem(
              icon: const Icon(Ionicons.analytics_outline),
              activeIcon: const Icon(Ionicons.analytics),
              label: "Activty Log",
              backgroundColor: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
