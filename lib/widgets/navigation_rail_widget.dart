import 'package:cashier_web_/widgets/logout_button.dart';
import 'package:flutter/material.dart';

class NavigationRailWidget extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onItemTapped;
  final VoidCallback onLogout;

  const NavigationRailWidget({
    required this.selectedIndex,
    required this.onItemTapped,
    required this.onLogout,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 110,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: Colors.grey.shade300,
          width: 1,
        ),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Image.asset(
              'assets/images/Logo-removebg.png',
              width: 80,
              height: 80,
            ),
          ),
          Expanded(
            child: NavigationRail(
              selectedIndex: selectedIndex,
              onDestinationSelected: onItemTapped,
              backgroundColor: Colors.transparent,
              labelType: NavigationRailLabelType.all,
              destinations: [
                _buildNavigationDestination(Icons.dashboard, 'Dashboard', 0),
                _buildNavigationDestination(
                    Icons.card_membership, 'Package', 1),
                _buildNavigationDestination(Icons.history, 'History', 2),
                _buildNavigationDestination(Icons.settings, 'Settings', 3),
                _buildNavigationDestination(Icons.card_membership, 'E-Tag', 4),
              ],
            ),
          ),
          SizedBox(height: 100),
          LogoutButton(onLogout: onLogout),
        ],
      ),
    );
  }

  NavigationRailDestination _buildNavigationDestination(
      IconData icon, String label, int index) {
    bool isSelected = selectedIndex == index;
    return NavigationRailDestination(
      icon: Container(
        width: 100,
        decoration: BoxDecoration(
          color: isSelected
              ? Color.fromARGB(255, 30, 144, 255)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(4),
        ),
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: isSelected ? Colors.white : Colors.grey.shade700,
              size: 20,
            ),
            SizedBox(height: 4),
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                label,
                style: TextStyle(
                  color: isSelected ? Colors.white : Colors.grey.shade700,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
      label: const SizedBox.shrink(),
    );
  }
}
