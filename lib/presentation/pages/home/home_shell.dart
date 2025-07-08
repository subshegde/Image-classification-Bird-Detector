import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tflite_examples/presentation/pages/home/home.dart';
import 'package:flutter_tflite_examples/presentation/pages/image_classification/bird_detector/tFLite_classifier_page.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeMainShell extends StatefulWidget {
  const HomeMainShell({super.key});

  @override
  State<HomeMainShell> createState() => _HomeMainShellState();
}

class _HomeMainShellState extends State<HomeMainShell> {
  int currentIndex = 0;

  final List<Widget> pages = const [
    HomePage(),
    TFLiteClassifierPage(),
    Center(child: Text('Profile Page')),
  ];

  Future<void> _handlePop(bool didPop) async {
    if (didPop) return;
    if (currentIndex > 0) {
      setState(() => currentIndex = 0);
    } else {
      final shouldExit = await showModalBottomSheet<bool>(
        isDismissible: false,
        enableDrag: false,
        elevation: 2,
        context: context,
        builder: (context) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: 190,
                color: Colors.white,
                child: Column(
                  children: [
                    ListTile(
                      title: Text(
                        'Are you sure you want to exit?',
                        style: GoogleFonts.poppins(
                          color: Colors.teal,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    GestureDetector(
                      onTap: () => Navigator.pop(context, false),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.teal,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        height: 40,
                        child: Center(
                          child: Text(
                            'NO',
                            style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    GestureDetector(
                      onTap: () => Navigator.pop(context, true),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.teal, width: 2),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        height: 40,
                        child: Center(
                          child: Text(
                            'YES',
                            style: GoogleFonts.poppins(
                              color: Colors.teal,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      );

      if (shouldExit == true) {
        SystemNavigator.pop();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: _handlePop,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(child: pages[currentIndex]),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: (index) => setState(() => currentIndex = index),
          selectedItemColor: Colors.teal.shade700,
          unselectedItemColor: Colors.grey,
          selectedLabelStyle: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
          unselectedLabelStyle: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
          items: const [
            BottomNavigationBarItem(
              icon: SizedBox.shrink(),
              activeIcon: SizedBox.shrink(),
              label: 'Home 🏠',
            ),
            BottomNavigationBarItem(
              icon: SizedBox.shrink(),
              activeIcon: SizedBox.shrink(),
              label: 'Bird 🐦',
            ),
            BottomNavigationBarItem(
              icon: SizedBox.shrink(),
              activeIcon: SizedBox.shrink(),
              label: 'Profile 👤',
            ),
          ],
        ),
      ),
    );
  }
}
