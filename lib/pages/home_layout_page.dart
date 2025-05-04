import 'package:flutter/material.dart';
import 'package:iconic/iconic.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';
import 'package:smartfiber/components/button/custom_button.dart';
import 'package:smartfiber/models/laravel_id.dart';
import 'package:smartfiber/pages/accuracy/accuracy_page.dart';
import 'package:smartfiber/pages/activity_log_page.dart';
import 'package:smartfiber/pages/home_page.dart';
import 'package:smartfiber/pages/model_flow/model_flow_page.dart';
import 'package:smartfiber/pages/splash_page.dart';

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

  final List<Widget> views = [
    const HomePage(),
    const AccuracyPage(),
    const ModelFlowPage(),
    const ActivityLogPage()
  ];

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
      child: Consumer<LaravelId>(builder: (context, laravel, child) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            automaticallyImplyLeading: false,
            title: Text(
              titles[selectedView],
              style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 8 * 4,
                  color: Theme.of(context).colorScheme.primary),
            ),
            actionsPadding: const EdgeInsets.only(right: 8 * 1),
            actions: [
              CustomButton(
                type: CustomButtonType.ghost,
                onPress: () => Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (_) => const SplashPage()),
                  (route) => false,
                ),
                icon: const Icon(Icons.logout),
                label: "log out",
                horizontalPadding: 2,
                verticalPadding: 1,
              )
            ],
          ),
          extendBodyBehindAppBar: extendBehindAppbar,
          // floatingActionButton: floatingButtons[selectedView],
          body: Stack(children: [
            PageView(
              controller: _pageController,
              physics: const NeverScrollableScrollPhysics(), // Disable swipe to change page
              children: views,
            ),
            if (laravel.isLoading)
              AbsorbPointer(
                absorbing: true,
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.white.withValues(alpha: 0.6),
                  child: const Center(
                    child: SizedBox.square(
                      dimension: 8 * 4,
                      child: CircularProgressIndicator(),
                    ),
                  ),
                ),
              )
          ]),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: selectedView,
            onTap: _onItemTapped,
            selectedItemColor: Theme.of(context).colorScheme.secondary,
            showSelectedLabels: true,
            showUnselectedLabels: true,
            selectedLabelStyle: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            unselectedLabelStyle: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            unselectedItemColor: HSLColor.fromColor(Theme.of(context).colorScheme.primary)
                .withSaturation(1)
                .toColor(),
            // backgroundColor: Colors.white,
            iconSize: 8 * 4,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Ionicons.home_outline),
                activeIcon: Icon(Ionicons.home),
                label: "Home",
                backgroundColor: Colors.white,
              ),
              BottomNavigationBarItem(
                icon: Icon(Iconic.target),
                activeIcon: Icon(Iconic.target_bold),
                label: "Accuracy",
                backgroundColor: Colors.white,
              ),
              BottomNavigationBarItem(
                icon: Icon(Ionicons.git_branch_outline),
                activeIcon: Icon(Ionicons.git_branch),
                label: "Model Flow",
                backgroundColor: Colors.white,
              ),
              BottomNavigationBarItem(
                icon: Icon(Ionicons.analytics_outline),
                activeIcon: Icon(Ionicons.analytics),
                label: "Activty Log",
                backgroundColor: Colors.white,
              ),
            ],
          ),
        );
      }),
    );
  }
}
