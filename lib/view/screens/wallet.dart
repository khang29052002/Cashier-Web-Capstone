import 'package:flutter/material.dart';

class WalletPage extends StatelessWidget {
  const WalletPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.blueAccent.shade100,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Center(
        child: Text(
          'Wallet Content',
          style: TextStyle(fontSize: 18, color: Colors.white),
        ),
      ),
    );
  }
}
