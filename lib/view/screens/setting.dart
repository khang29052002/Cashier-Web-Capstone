import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'profile_tab.dart';
import 'report_tab.dart';
import 'change_password_tab.dart'; 

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3, 
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 16.0, left: 16.0),
              child: const Text(
                'Settings',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Center(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.4,
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                decoration: BoxDecoration(
                  color: Colors.grey.shade50,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 4,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: const TabBar(
                  labelStyle: TextStyle(fontSize: 12),
                  tabs: [
                    Tab(text: 'Profile'),
                    Tab(text: 'Report'),
                    Tab(text: 'Change Password'), 
                  ],
                ),
              ),
            ),
            Expanded(
              child: TabBarView(
                children: [
                  ProfileTab(),
                  ReportTab(),
                  ChangePasswordTab(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
