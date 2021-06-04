import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mjam/Contants/Color.dart';
import 'package:mjam/Screens/Menu_Screen/Menu.dart';
import 'package:mjam/bloc/Order_Bloc/productBloc.dart';
import 'package:mjam/bloc/Order_Bloc/states.dart';
import 'package:mjam/bottom_Navigation_bar/FavoritScreen.dart';
import 'package:mjam/bottom_Navigation_bar/Profil.dart';
import 'package:mjam/bottom_Navigation_bar/search_Screen.dart';
import 'package:mjam/bottom_Navigation_bar/shopping_carts.dart';
import 'package:mjam/models_and_data/Icons_Fonts/font1.dart';

// ignore: camel_case_types
class BottomNavBarWidget extends StatefulWidget {
  BottomNavBarWidget({Key key}) : super(key: key);
  @override
  _BottomNavBarWidgetState createState() => _BottomNavBarWidgetState();
}

// ignore: camel_case_types
class _BottomNavBarWidgetState extends State<BottomNavBarWidget> {
  PageController pageController = PageController();
  int _selectedIndex = 0;
  List<Widget> _screens = [
    Menu(),
    Searching(),
    FavoritScreen(),
    ShoppingCarts(),
    Profil(),
  ];

  _onPageChanged(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  _itemTapped(int selectedIndex) {
    pageController.jumpToPage(selectedIndex);
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: PageView(
          controller: pageController,
          children: _screens,
          onPageChanged: _onPageChanged,
          physics: NeverScrollableScrollPhysics(),
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: whiteColor,
          selectedItemColor: primaryColor,
          unselectedItemColor: blackColor,
          items: [
            BottomNavigationBarItem(
              // ignore: deprecated_member_use
              title: Padding(
                padding: EdgeInsets.all(0),
              ),
              icon: Icon(
                Iconsss.room_service,
                size: 28,
              ),
            ),
            BottomNavigationBarItem(
              // ignore: deprecated_member_use
              title: Padding(
                padding: EdgeInsets.all(0),
              ),
              icon: Icon(
                Iconsss.search_1,
                size: 20,
              ),
            ),
            BottomNavigationBarItem(
              // ignore: deprecated_member_use
              title: Padding(
                padding: EdgeInsets.all(0),
              ),
              icon: Icon(
                Iconsss.heart_empty,
                size: 20,
              ),
            ),
            BottomNavigationBarItem(
              // ignore: deprecated_member_use
              title: Padding(
                padding: EdgeInsets.all(0),
              ),
              icon: Stack(
                children: <Widget>[
                  Icon(Icons.shopping_cart_outlined),
                  BlocBuilder<ProductBloc, BlocState>(
                      builder: (context, state) => state is SuccessState
                          ? Positioned(
                              right: 0,
                              child: state.orderList.isNotEmpty
                                  ? Container(
                                      padding: EdgeInsets.all(1),
                                      decoration: BoxDecoration(
                                        color: Colors.red,
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                      constraints: BoxConstraints(
                                        minWidth: 7,
                                        minHeight: 7,
                                      ),
                                    )
                                  : Container(
                                      padding: EdgeInsets.all(1),
                                      decoration: BoxDecoration(
                                        color: Colors.transparent,
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                      constraints: BoxConstraints(
                                        minWidth: 7,
                                        minHeight: 7,
                                      ),
                                    ),
                            )
                          : Text('')),
                ],
              ),
            ),
            BottomNavigationBarItem(
              // ignore: deprecated_member_use
              title: Padding(
                padding: EdgeInsets.all(0),
              ),
              icon: Icon(
                Icons.person_outline,
                size: 25,
              ),
            ),
          ],
          currentIndex: _selectedIndex,
          onTap: _itemTapped,
        ),
      ),
    );
  }
}
