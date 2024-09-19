import 'package:flutter/material.dart';

class FilterButton extends StatelessWidget {
  final List<String> selectedFilters;
  final ValueChanged<String> onSelected;

  const FilterButton({
    Key? key,
    required this.selectedFilters,
    required this.onSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      onSelected: onSelected,
      itemBuilder: (context) {
        return [
          _buildPopupMenuItem(context, 'Beach'),
          _buildPopupMenuItem(context, 'Island'),
          _buildPopupMenuItem(context, 'Combination'),
        ];
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Icon(
          Icons.filter_list,
          size: 28,
          color: Colors.blueAccent.shade700,
        ),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      offset: Offset(0, 40),
      color: Colors.white, 
    );
  }

  PopupMenuItem<String> _buildPopupMenuItem(BuildContext context, String filter) {
    return PopupMenuItem<String>(
      child: Container(
        child: StatefulBuilder(
          builder: (context, setState) {
            return CheckboxListTile(
              contentPadding: EdgeInsets.zero,
              dense: true,
              activeColor: Colors.white, 
              checkColor: Colors.black, 
              title: Text(
                filter,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
              value: selectedFilters.contains(filter),
              onChanged: (bool? value) {
                setState(() {
                  if (value == true) {
                    onSelected(filter);
                  } else {
                    onSelected(filter);
                  }
                });
              },
            );
          },
        ),
      ),
    );
  }
}