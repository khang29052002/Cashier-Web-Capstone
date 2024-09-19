import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class GenerateETagDialog extends StatefulWidget {
  const GenerateETagDialog({Key? key}) : super(key: key);

  @override
  _GenerateETagDialogState createState() => _GenerateETagDialogState();
}

class _GenerateETagDialogState extends State<GenerateETagDialog> {
  String selectedMarketZone = '';
  String selectedAmount = '';
  String quantity = '';
  String selectedPaymentMethod = 'vnPay';

  @override
  Widget build(BuildContext context) {
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
                  setState(() {
                    selectedMarketZone = value ?? '';
                  });
                },
              ),
              const SizedBox(height: 16),
              _buildDropdownField(
                labelText: 'Tiền',
                icon: Icons.attach_money,
                items: ['100,000', '200,000', '300,000'],
                onChanged: (value) {
                  setState(() {
                    selectedAmount = value ?? '';
                  });
                },
              ),
              const SizedBox(height: 16),
              _buildTextField(
                labelText: 'Số Lượng',
                icon: Icons.numbers,
                onChanged: (value) {
                  setState(() {
                    quantity = value;
                  });
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
              Navigator.of(context).pop();
              _showPaymentMethodDialog(context);
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

  void _showPaymentMethodDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            title: const Text(
              'Chọn Phương Thức Thanh Toán',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            content: SizedBox(
              width: MediaQuery.of(context).size.width * 0.2,
              height: MediaQuery.of(context).size.height * 0.2, 
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildRadioOption(
                    icon: Icons.payment,
                    label: 'vnPay',
                    value: 'vnPay',
                    groupValue: selectedPaymentMethod,
                    onChanged: (value) {
                      setState(() {
                        selectedPaymentMethod = value ?? '';
                      });
                    },
                  ),
                  // _buildRadioOption(
                  //   icon: Icons.credit_card,
                  //   label: 'Credit Card',
                  //   value: 'Credit Card',
                  //   groupValue: selectedPaymentMethod,
                  //   onChanged: (value) {
                  //     setState(() {
                  //       selectedPaymentMethod = value ?? '';
                  //     });
                  //   },
                  // ),
                  _buildRadioOption(
                    icon: Icons.money,
                    label: 'Cash',
                    value: 'Cash',
                    groupValue: selectedPaymentMethod,
                    onChanged: (value) {
                      setState(() {
                        selectedPaymentMethod = value ?? '';
                      });
                    },
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Hủy', style: TextStyle(color: Colors.red)),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 30, 144, 255),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                  _showQRCodeDialog(context, selectedPaymentMethod);
                },
                child: const Text('Xác nhận', style: TextStyle(color: Colors.white)),
              ),
            ],
          );
        },
      );
    },
  );
}

 void _showQRCodeDialog(BuildContext context, String paymentMethod) {
  String qrData = '01234567890'; 
  String qrTitle = 'Scan to Pay';
  String qrSubtitle = 'QUÉT MÃ QR';
  if (paymentMethod == 'vnPay') {
    qrData = 'https://pay.vn/vnpay_checkout'; 
  // } else if (paymentMethod == 'Credit Card') {
  //   qrTitle = 'Credit Card Payment';
  //   qrSubtitle = 'Please enter your credit card details on the payment page.';
  //   qrData = ''; 
  } else if (paymentMethod == 'Cash') {
    qrTitle = 'Payment Instruction';
    qrSubtitle = 'Please proceed to the cashier to complete the payment.';
    qrData = ''; 
  }

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        title: Text(
          qrTitle,
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        content: SizedBox(
          width: MediaQuery.of(context).size.width * 0.3,
          height: MediaQuery.of(context).size.height * 0.5,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (paymentMethod != 'Cash') ...[
                // VNPay Logo or another image related to payment
                Image.asset(
                  'assets/images/VN_Pay.png',
                  width: 100,
                  height: 100,
                ),
                const SizedBox(height: 20),
                // if (paymentMethod != 'Credit Card') ...[
                //   QrImageView(
                //     data: qrData,
                //     version: QrVersions.auto,
                //     size: 200.0,
                //   ),
                // ]
              ] else ...[
                const Icon(Icons.money_off, size: 100, color: Colors.red),
              ],
              const SizedBox(height: 20),
              Text(
                qrSubtitle,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.black87, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Close'),
          ),
        ],
      );
    },
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
      items: items.map((item) {
        return DropdownMenuItem(
          value: item,
          child: Text(item),
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
    return TextField(
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
      onChanged: onChanged,
      keyboardType: keyboardType,
    );
  }

 Widget _buildRadioOption({
  required IconData icon,
  required String label,
  required String value,
  required String groupValue,
  required ValueChanged<String?> onChanged,
}) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 8), 
    child: Row(
      children: [
        Radio<String>(
          onChanged: onChanged,
          value: value,
          groupValue: groupValue,
          activeColor: Colors.blueAccent.shade700, 
        ),
        SizedBox(width: 12), 
        Icon(
          icon,
          color: Colors.blueAccent.shade700,
          size: 24, 
        ),
        SizedBox(width: 12), 
        Expanded(
          child: Text(
            label,
            style: TextStyle(
              fontSize: 16,
              color: Colors.black87,
              fontWeight: FontWeight.w500, 
            ),
          ),
        ),
      ],
    ),
  );
}



}
