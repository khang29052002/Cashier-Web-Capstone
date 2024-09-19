import 'package:cashier_web_/view/screens/dashboard.dart';
import 'package:cashier_web_/view/screens/history.dart';
import 'package:cashier_web_/view/screens/menu.dart';
import 'package:cashier_web_/view/screens/setting.dart';
import 'package:cashier_web_/widgets/navigation_rail_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart'; 
import 'dart:html' as html; 
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;


  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
void _showPopupMenu(TapDownDetails details) {
    final RenderBox renderBox = context.findRenderObject() as RenderBox;
    final Offset offset = renderBox.globalToLocal(details.globalPosition);

    showMenu(
      context: context,
      position: RelativeRect.fromLTRB(
        offset.dx - 60, // Move menu to the left
        offset.dy + 30, // Move menu down
        renderBox.size.width - offset.dx,
        renderBox.size.height - offset.dy,
      ),
      items: [
        PopupMenuItem<String>(
          value: 'Profile',
          child: ListTile(
            leading: Icon(Icons.person, color: Colors.black),
            title: Text('Profile',
                style: TextStyle(color: Colors.black, fontSize: 12)),
          ),
        ),
        PopupMenuItem<String>(
          value: 'logout',
          child: ListTile(
            leading: Icon(Icons.logout, color: Colors.red),
            title: Text('Logout',
                style: TextStyle(color: Colors.black, fontSize: 12)),
          ),
        ),
      ],
      color: Colors.white, // Menu background color
      elevation: 8.0, // Menu shadow
    ).then((value) {
      if (value != null) {
        _handleMenuSelection(value);
      }
    });
  }
  Future<void> _logout() async {
    try {
      // Clear local storage
      html.window.localStorage.clear();
      Get.offNamed('/welcome');
    } catch (e) {
      print('Logout failed: $e');
    }
  }
    void _handleMenuSelection(String value) {
  switch (value) {
    case 'Profile':
      setState(() {
        _selectedIndex = 3; 
      });
      break;
    case 'logout':
      _logout();
      // Get.offNamed('/welcome');
      break;
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:  Colors.white,
      body: Stack(
        children: [
          Row(
            children: [
              NavigationRailWidget(
               
                selectedIndex: _selectedIndex,
                onItemTapped: _onItemTapped,
                onLogout: () {
               
                },
              ),
              VerticalDivider(
                thickness: 0.5,
                width: 0.5,
                color: Colors.grey.shade300,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 60.0),
                  child: _buildContent(),
                ),
              ),
            ],
          ),
         Positioned(
            top: 16,
            right: 16,
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end, // Align text to the right
                  children: [
                    Text(
                      'Khang', // Replace with actual user name
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Cashier Web', // User role
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
                SizedBox(width: 8), // Spacing between text and avatar
                GestureDetector(
                  onTapDown: _showPopupMenu,
                  child: CircleAvatar(
                    backgroundImage: AssetImage('assets/images/Logo.png'),
                    radius: 34,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContent() {
    switch (_selectedIndex) {
      case 0:
        return const DashboardPage();
      case 1:
        return const MenuPage();
      case 2:
        return const HistoryPage();
      case 3:
        return const SettingsPage();
      default:
        return const DashboardPage();
    }
  }
}