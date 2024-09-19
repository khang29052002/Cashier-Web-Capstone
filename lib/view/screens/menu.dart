import 'package:flutter/material.dart';
import 'package:cashier_web_/widgets/search_bar.dart';
import 'package:cashier_web_/widgets/filter_button.dart';
import 'package:cashier_web_/widgets/package_card.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  String _searchQuery = '';
  List<String> _selectedFilters = [];

  final List<String> _categories = ['Beach', 'Island', 'Combination'];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Package',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.blueAccent.shade700,
            ),
          ),
          const SizedBox(height: 6),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomSearchBar(
                searchQuery: _searchQuery,
                onChanged: (query) {
                  setState(() {
                    _searchQuery = query;
                  });
                },
              ),
              FilterButton(
                selectedFilters: _selectedFilters,
                onSelected: (value) {
                  setState(() {
                    if (_selectedFilters.contains(value)) {
                      _selectedFilters.remove(value);
                    } else {
                      _selectedFilters.add(value);
                    }
                  });
                },
              ),
            ],
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 8.0,
            runSpacing: 4.0,
            children: _categories.map((category) {
              final isSelected = _selectedFilters.contains(category);
              return ChoiceChip(
                label: Text(
                  category,
                  style: TextStyle(
                    color: isSelected ? Colors.white : Colors.blueAccent.shade700,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                selected: isSelected,
                selectedColor: Colors.blueAccent.shade700,
                backgroundColor: Colors.grey.shade200,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                  side: BorderSide(
                    color: isSelected ? Colors.blueAccent.shade700 : Colors.grey.shade400,
                  ),
                ),
                elevation: 4,
                shadowColor: Colors.grey.withOpacity(0.3),
                onSelected: (selected) {
                  setState(() {
                    if (selected) {
                      _selectedFilters.add(category);
                    } else {
                      _selectedFilters.remove(category);
                    }
                  });
                },
              );
            }).toList(),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 16,
                mainAxisSpacing: 1,
                childAspectRatio: 0.75,
              ),
              itemCount: _filteredPackages().length,
              itemBuilder: (context, index) {
  final package = _filteredPackages()[index];
  return Wrap(
    children: [
      PackageCard(
        title: package['title']!,
        shortDescription: package['shortDescription']!,
        image: package['image']!,
        serviceDetails: package['serviceDetails']!,
        price: package['price']!, // Add this line
      ),
    ],
  );
},

            ),
          ),
        ],
      ),
    );
  }

  List<Map<String, dynamic>> _packages = [
  {
    'title': 'Combo Beach',
    'shortDescription': 'Discover beautiful beaches...',
    'image': 'assets/images/on_shore_combo.jpg',
    'serviceDetails': [
      'Beach walking tour',
      'Seafood tasting',
      'Beach sports',
    ],
    'category': 'Beach',
    'price': 200000, // Add price field
  },
  {
    'title': 'Combo Island',
    'shortDescription': 'Enjoy underwater activities...',
    'image': 'assets/images/on_water_combo.jfif',
    'serviceDetails': [
      'Diving',
      'Fishing',
      'Exploring pristine islands',
    ],
    'category': 'Island',
    'price': 350000, // Add price field
  },
  {
    'title': 'Combo Combination',
    'shortDescription': 'Combine beach and island experiences...',
    'image': 'assets/images/all_inclusive_combo.jfif',
    'serviceDetails': [
      'Boat tour',
      'Water sports',
      'Beach picnic',
    ],
    'category': 'Combination',
    'price': 500000, // Add price field
  },
];


  List<Map<String, dynamic>> _filteredPackages() {
    return _packages.where((package) {
      final matchesSearch = package['title']!.toLowerCase().contains(_searchQuery.toLowerCase());
      final matchesFilter = _selectedFilters.isEmpty || _selectedFilters.contains(package['category']);
      return matchesSearch && matchesFilter;
    }).toList();
  }
}
