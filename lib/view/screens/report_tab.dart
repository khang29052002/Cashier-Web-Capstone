import 'package:flutter/material.dart';

class ReportTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white, // Nền trắng cho toàn bộ tab
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            'Report Issue',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black87, // Màu chữ tiêu đề
            ),
          ),
          const SizedBox(height: 16),
          Container(
            constraints: BoxConstraints(
                maxWidth: 1000), // Đặt giới hạn chiều rộng cho tiêu đề
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Title', // Label for the dropdown
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                DropdownButtonFormField<String>(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                  items: <String>['Bug', 'Feature Request', 'Other']
                      .map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                   
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Container(
            constraints: BoxConstraints(
                maxWidth: 1000), 
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Description', 
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                TextField(
                  maxLines: 6,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter the decription', 
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),
         ElevatedButton(
  onPressed: () {
    
  },
  child: const Text('Submit'),
  style: ElevatedButton.styleFrom(
    foregroundColor: Colors.white,
    backgroundColor: Colors.blue,
    padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
    textStyle: const TextStyle(fontSize: 18),
    minimumSize: const Size(150, 50),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(4), 
    ),
  ),
)

        ],
      ),
    );
  }
}