import 'dart:html' as html;
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cashier_web_/model/api/auth/auth_service.dart'; 
import 'package:shared_preferences/shared_preferences.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final AuthService _authService = AuthService(); 
  final TextEditingController _loginEmailController = TextEditingController();
  final TextEditingController _loginPasswordController = TextEditingController();
  final TextEditingController _forgotPasswordEmailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    _loginEmailController.dispose();
    _loginPasswordController.dispose();
    _forgotPasswordEmailController.dispose();
    super.dispose();
  }

  void switchToForgotPasswordTab() {
    _tabController.animateTo(1);
  }

  Future<void> _login() async {
  try {
    final email = _loginEmailController.text;
    final password = _loginPasswordController.text;

    if (email.isEmpty || !email.contains('@')) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please enter a valid email address'),
          backgroundColor: Colors.redAccent,
        ),
      );
      return;
    }

    final result = await _authService.login(email, password);

    final userId = result['userId'];
    final accessToken = result['accessToken'];
    final refreshToken = result['refreshToken'];

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('userId', userId ?? 'defaultUserId');
    await prefs.setString('accessToken', accessToken ?? 'defaultAccessToken');
    await prefs.setString('refreshToken', refreshToken ?? 'defaultRefreshToken');

    final storedUserId = prefs.getString('userId');
    final storedAccessToken = prefs.getString('accessToken');
    final storedRefreshToken = prefs.getString('refreshToken');

    print('Stored UserId: $storedUserId');
    print('Stored AccessToken: $storedAccessToken');
    print('Stored RefreshToken: $storedRefreshToken');

    print('Login successful');
    print('Navigating to home screen');
    
    // Điều hướng đến trang chính sử dụng Navigator
    Navigator.pushReplacementNamed(context, '/home');

  } on DioError catch (e) {
    final errorMessage = e.response?.data['messageResponse'] ?? 'Unknown error';
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Login failed: $errorMessage'),
        backgroundColor: Colors.redAccent,
      ),
    );
  } catch (e) {
    print('Login failed: $e');
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('An unexpected error occurred: $e'),
        backgroundColor: Colors.redAccent,
      ),
    );
  }
}



  Future<void> checkAllStoredData() async {
    final userId = html.window.localStorage['userId'];
    final accessToken = html.window.localStorage['accessToken'];
    final refreshToken = html.window.localStorage['refreshToken'];

    if (userId != null && accessToken != null && refreshToken != null) {
      print('Stored UserId: $userId');
      print('Stored AccessToken: $accessToken');
      print('Stored RefreshToken: $refreshToken');
    } else {
      print('No data found.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.5, 
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  'assets/images/Logo.png',
                  width: 140.0,
                  height: 140.0,
                ),
                SizedBox(height: 8.0),
                Text(
                  'Welcome to Vega City',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 28.0,
                    fontWeight: FontWeight.w900,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 30.0),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(4.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 5,
                          blurRadius: 10,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        // TabBar
                        TabBar(
                          controller: _tabController,
                          indicator: BoxDecoration(
                            borderRadius: BorderRadius.circular(4.0),
                            gradient: LinearGradient(
                              colors: [Colors.blueAccent, Colors.lightBlueAccent],
                            ),
                          ),
                          labelColor: Colors.white,
                          unselectedLabelColor: Colors.black,
                          labelStyle: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                          unselectedLabelStyle: TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.normal,
                          ),
                          tabs: [
                            Tab(
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: 10.0, horizontal: 16.0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4.0),
                                  color: _tabController.index == 0
                                      ? Colors.blueAccent.withOpacity(0.1)
                                      : Colors.transparent,
                                ),
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Text('Login'),
                                ),
                              ),
                            ),
                            Tab(
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: 10.0, horizontal: 16.0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4.0),
                                  color: _tabController.index == 1
                                      ? Colors.blueAccent.withOpacity(0.1)
                                      : Colors.transparent,
                                ),
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Text('Forgot Password'),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 15.0),
                        Expanded(
                          child: TabBarView(
                            controller: _tabController,
                            children: [
                              _buildLoginForm(),
                              _buildForgotPasswordForm(),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLoginForm() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 340,
            child: TextField(
              controller: _loginEmailController,
              decoration: InputDecoration(
                labelText: 'Email',
                labelStyle: TextStyle(color: Colors.black45),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue),
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
          ),
          SizedBox(height: 20.0),
          Container(
            width: 340,
            child: TextField(
              controller: _loginPasswordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
                labelStyle: TextStyle(color: Colors.black45),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue),
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
          ),
          SizedBox(height: 30.0),
          ElevatedButton(
            onPressed: () {
              _login();
            },
            child: Text('Login', style: TextStyle(fontSize: 16.0)),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
              padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 40.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4.0),
              ),
            ),
          ),
          SizedBox(height: 20.0),
          if (_tabController.index == 0)
            Align(
              alignment: Alignment.center,
              child: TextButton(
                onPressed: () {
                  switchToForgotPasswordTab();
                },
                child: Text(
                  'Forgot Password?',
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildForgotPasswordForm() {
    return Padding(
      padding: const EdgeInsets.only(top: 80.0, bottom: 20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            width: 340,
            child: TextField(
              controller: _forgotPasswordEmailController,
              decoration: InputDecoration(
                labelText: 'Email',
                labelStyle: TextStyle(color: Colors.black45),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue),
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
          ),
          SizedBox(height: 30.0),
          ElevatedButton(
            onPressed: () {
              // Add logic for forgot password functionality
            },
            child: Text('Reset Password', style: TextStyle(fontSize: 16.0)),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
              padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 40.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4.0),
              ),
            ),
          ),
        ],
      ),
    );
  }
}