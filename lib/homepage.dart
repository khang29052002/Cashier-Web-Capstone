import 'package:cashier_web_/view/screens/dashboard.dart';
import 'package:cashier_web_/view/screens/history.dart';
import 'package:cashier_web_/view/screens/menu.dart';
import 'package:cashier_web_/view/screens/setting.dart';
import 'package:cashier_web_/widgets/navigation_rail_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart'; 

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  bool _isDarkMode = false;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _handleMenuSelection(String value) {
    switch (value) {
      case 'editProfile':
        Get.toNamed('/edit_profile');
        break;
      case 'logout':
      
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _isDarkMode ? Colors.grey[900] : Colors.white,
      body: Stack(
        children: [
          Row(
            children: [
              NavigationRailWidget(
                isDarkMode: _isDarkMode,
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
            child: CircleAvatar(
              backgroundImage: AssetImage('assets/images/Logo.png'),
              radius: 34, 
              child: PopupMenuButton<String>(
                icon: Icon(Icons.more_vert),
                tooltip: '', 
                onSelected: _handleMenuSelection,
                offset: Offset(-20, 40), 
                color: Colors.white, 
                itemBuilder: (BuildContext context) {
                  return [
                    PopupMenuItem<String>(
                      value: 'editProfile',
                      child: Text(
                        'Edit Profile',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                    PopupMenuItem<String>(
                      value: 'logout',
                      child: Text(
                        'Logout',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ];
                },
              ),
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
