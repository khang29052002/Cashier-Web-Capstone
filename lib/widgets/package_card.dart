import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'generate_etag_dialog.dart';

class PackageCard extends StatefulWidget {
  final String title;
  final String shortDescription;
  final String image;
  final List<String> serviceDetails;
  final int price; // Add the price field

  const PackageCard({
    required this.title,
    required this.shortDescription,
    required this.image,
    required this.serviceDetails,
    required this.price, // Require price as a parameter
    Key? key,
  }) : super(key: key);

  @override
  State<PackageCard> createState() => _PackageCardState();
}

class _PackageCardState extends State<PackageCard> with SingleTickerProviderStateMixin {
  bool _isExpanded = false;
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
Widget build(BuildContext context) {
  
  final formattedPrice = NumberFormat.currency(locale: 'vi_VN', symbol: '₫').format(widget.price);

  return GestureDetector(
    onTap: () {
      setState(() {
        _isExpanded = !_isExpanded;
        if (_isExpanded) {
          _controller.forward();
        } else {
          _controller.reverse();
        }
      });
    },
    child: AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
        
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(4)),
                child: Image.asset(
                  widget.image,
                  height: 240,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            
              Positioned(
                bottom: 10,
                right: 16,
                child: ElevatedButton(
                  onPressed: () {
                    _showServiceDetailsDialog(context); 
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent.shade700,
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    elevation: 4, 
                  ),
                  child: const Text(
                    'Details',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            widget.title,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.blueAccent.shade700,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            widget.shortDescription,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade700,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            formattedPrice,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.red.shade600,
            ),
          ),
           const SizedBox(height: 16),
          // Generate E-Tag Button
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
              _showGenerateETagDialog(context);
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
      ),
    ),
  );
}


  void _showGenerateETagDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) => GenerateETagDialog(),
    );
  }

  // Show a dialog popup for service details
  void _showServiceDetailsDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: true, // Allows dismissing the popup by clicking outside
    builder: (BuildContext context) {
      return AlertDialog(
        title: Row(
          children: [
            Icon(
              Icons.info_outline,
              color: Colors.blueAccent.shade700,
            ),
            const SizedBox(width: 8),
            Text(
              'Chi Tiết Dịch Vụ',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent.shade700,
              ),
            ),
          ],
        ),
        content: SizedBox(
          width: MediaQuery.of(context).size.width * 0.3, 
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Add the descriptive sentence
                Text(
                  'Dịch vụ của package này sẽ bao gồm:',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey.shade800,
                  ),
                ),
                const SizedBox(height: 16), // Space before listing services
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: widget.serviceDetails.map((detail) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: Row(
                        children: [
                          Icon(
                            Icons.check_circle_outline,
                            size: 20,
                            color: Colors.blueAccent.shade700,
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              detail,
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey.shade700,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blueAccent.shade700,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text('Đóng',style: TextStyle(color: Colors.white),),
          ),
        ],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ), // Rounded edges for the dialog
      );
    },
  );
}

}