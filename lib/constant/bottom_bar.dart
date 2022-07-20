
import 'package:flutter/material.dart';
import 'package:stackx/features/profile/profile_screen.dart';
import 'package:stackx/features/query/query.dart';

import '../features/home/home_screen.dart';
import 'global_variable.dart';

class BottomBar extends StatefulWidget {
  static const String routeName = '/actual-home';
  const BottomBar({Key? key}) : super(key: key);

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int _page = 0;
  double bottomBarWidth = 42;
  double bottomBarBorderWidth = 5;

  void updatePage(int page) {
    setState(() {
      _page = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    // final _cartProvider = Provider.of<CartProvider>(context);
    // _cartProvider.getCartTotal();
    // _cartProvider.getShopName();

    List<Widget> pages = [
      HomeScreen(),
      Query(),
      ProfileScreen(),
    ];
    return Scaffold(
      body: pages[_page],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _page,
        selectedItemColor: GlobalVariables.selectedNavBarColor,
        unselectedItemColor: GlobalVariables.unselectedNavBarColor,
        backgroundColor: const Color(0xFF3D3D3D),
        iconSize: 28,
        onTap: updatePage,
        items: [
          // Home Page
          BottomNavigationBarItem(
            backgroundColor: const Color(0xFF3D3D3D),
            icon: Container(
              width: bottomBarWidth,
              // decoration: BoxDecoration(
              //     border: Border(
              //         // top: BorderSide(
              //         //     color: _page == 0
              //         //         ? GlobalVariables.selectedNavBarColor
              //         //         : GlobalVariables.backgroundColor,
              //         //     width: bottomBarBorderWidth)
              //         )),
              child: const Icon(Icons.home_outlined),
            ),
            label: 'Home',
          ),
                BottomNavigationBarItem(
            backgroundColor: const Color(0xFF3D3D3D),
            icon: Container(
              width: bottomBarWidth,
              // decoration: BoxDecoration(
              //     border: Border(
              //         // top: BorderSide(
              //         //     color: _page == 0
              //         //         ? GlobalVariables.selectedNavBarColor
              //         //         : GlobalVariables.backgroundColor,
              //         //     width: bottomBarBorderWidth)
              //         )),
              child: const Icon(Icons.email_outlined),
            ),
            label: 'Query',
          ),

          //Account

          //Account Screen
          BottomNavigationBarItem(
              backgroundColor: const Color(0xFF3D3D3D),
              icon: Container(
                width: bottomBarWidth,
                // decoration: BoxDecoration(
                //     border: Border(
                //         top: BorderSide(
                //             color: _page == 3
                //                 ? GlobalVariables.selectedNavBarColor
                //                 : GlobalVariables.backgroundColor,
                //             width: bottomBarBorderWidth))),
                child: const Icon(Icons.person_outline),
              ),
              label: 'Account'),
        ],
      ),
    );
  }
}
