import 'package:cashier_web_/model/api/auth/auth_service.dart';
import 'package:flutter/material.dart';

class ChangePasswordTab extends StatefulWidget {
  const ChangePasswordTab({Key? key}) : super(key: key);

  @override
  _ChangePasswordTabState createState() => _ChangePasswordTabState();
}

class _ChangePasswordTabState extends State<ChangePasswordTab> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController oldPasswordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();

  final AuthService _authService = AuthService();

  bool isLoading = false;

  Future<void> changePassword() async {
    final String email = emailController.text;
    final String oldPassword = oldPasswordController.text;
    final String newPassword = newPasswordController.text;

    if (email.isEmpty || oldPassword.isEmpty || newPassword.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill in all fields')),
      );
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      final response = await _authService.changePassword(
        email,
        oldPassword,
        newPassword,
      );

      if (response.containsKey('error')) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(response['error'])),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Password changed successfully!')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An error occurred: $e')),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white, 
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            'Change Password',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black87, 
            ),
          ),
          const SizedBox(height: 24),
          Container(
            constraints: BoxConstraints(maxWidth: 600),
            child: TextField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
                prefixIcon: const Icon(Icons.email),
              ),
            ),
          ),
          const SizedBox(height: 24),
          Container(
            constraints: BoxConstraints(maxWidth: 600),
            child: TextField(
              controller: oldPasswordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Old Password',
                border: OutlineInputBorder(),
                prefixIcon: const Icon(Icons.lock),
              ),
            ),
          ),
          const SizedBox(height: 24),
          Container(
            constraints: BoxConstraints(maxWidth: 600),
            child: TextField(
              controller: newPasswordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'New Password',
                border: OutlineInputBorder(),
                prefixIcon: const Icon(Icons.lock_outline),
              ),
            ),
          ),
          const SizedBox(height: 32),
          isLoading
              ? const Center(child: CircularProgressIndicator())
              : SizedBox(
                  width: 200,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: changePassword,
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.blue,
                      padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 16),
                      textStyle: const TextStyle(fontSize: 18),
                      minimumSize: const Size(150, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4), 
                      ),
                    ),
                    child: const Text('Change Password'),
                  ),
                ),
        ],
      ),
    );
  }
}
