import 'package:flutter/material.dart';

class GenerateETagDialog extends StatelessWidget {
  const GenerateETagDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String selectedMarketZone = '';
    String selectedAmount = '';
    String quantity = '';

    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.qr_code_2, color: Colors.blueAccent.shade700, size: 28),
          const SizedBox(width: 8),
          const Text(
            'Generate E-Tag',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
        ],
      ),
      contentPadding: const EdgeInsets.fromLTRB(24, 20, 24, 24),
      content: SizedBox(
        width: MediaQuery.of(context).size.width * 0.3,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildDropdownField(
                labelText: 'Market Zone',
                icon: Icons.location_on,
                items: ['Zone A', 'Zone B', 'Zone C'],
                onChanged: (value) {
                  selectedMarketZone = value ?? '';
                },
              ),
              const SizedBox(height: 16),
              _buildDropdownField(
                labelText: 'Tiền',
                icon: Icons.attach_money,
                items: ['100,000', '200,000', '300,000'],
                onChanged: (value) {
                  selectedAmount = value ?? '';
                },
              ),
              const SizedBox(height: 16),
              _buildTextField(
                labelText: 'Số Lượng',
                icon: Icons.numbers,
                onChanged: (value) {
                  quantity = value;
                },
                keyboardType: TextInputType.number,
              ),
            ],
          ),
        ),
      ),
      actionsPadding: const EdgeInsets.only(bottom: 10, right: 10),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          style: TextButton.styleFrom(
            foregroundColor: Colors.black,
            textStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          child: const Text('Cancel'),
        ),
       Container(
  decoration: BoxDecoration(
    gradient: LinearGradient(
      colors: [
        Color.fromARGB(255, 30, 144, 255),
        Color.fromARGB(255, 16, 78, 139),
      ],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
    borderRadius: BorderRadius.circular(8), 
  ),
  child: ElevatedButton(
    onPressed: () {
    
    },
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.transparent, 
      shadowColor: Colors.transparent, 
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 22),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8), 
      ),
    ),
    child: const Text(
      'Generate E-Tag',
      style: TextStyle(fontSize: 16, color: Colors.white),
    ),
  ),
),

      ],
    );
  }

  Widget _buildDropdownField({
    required String labelText,
    required IconData icon,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: Colors.blueAccent.shade700),
        labelText: labelText,
        labelStyle: const TextStyle(
          color: Colors.black54,
          fontWeight: FontWeight.w500,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: Colors.blueAccent.shade700),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: Colors.blueAccent.shade700),
        ),
      ),
      items: items.map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value, style: const TextStyle(color: Colors.black87)),
        );
      }).toList(),
      onChanged: onChanged,
    );
  }

  Widget _buildTextField({
    required String labelText,
    required IconData icon,
    required ValueChanged<String> onChanged,
    TextInputType? keyboardType,
  }) {
    return TextFormField(
      onChanged: onChanged,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: Colors.blueAccent.shade700),
        labelText: labelText,
        labelStyle: const TextStyle(
          color: Colors.black54,
          fontWeight: FontWeight.w500,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: Colors.blueAccent.shade700),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: Colors.blueAccent.shade700),
        ),
      ),
    );
  }
}
