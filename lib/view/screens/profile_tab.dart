import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:html' as html;
import 'dart:io' as io;
import 'package:flutter_dropzone/flutter_dropzone.dart';

class ProfileTab extends StatefulWidget {
  const ProfileTab({super.key});

  @override
  _ProfileTabState createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  io.File? _image;
  html.File? _webImage;
  DateTime? _selectedDate;
  late DropzoneViewController _controller;

  Future<void> _pickImage() async {
    if (kIsWeb) {
      final picker = html.FileUploadInputElement();
      picker.accept = 'image/*';
      picker.click();
      picker.onChange.listen((e) {
        final files = picker.files;
        if (files!.isEmpty) return;

        final reader = html.FileReader();
        reader.readAsDataUrl(files[0]);
        reader.onLoadEnd.listen((e) {
          setState(() {
            _webImage = files[0];
          });
        });
      });
    } else {
      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(source: ImageSource.gallery);

      if (image != null) {
        setState(() {
          _image = io.File(image.path);
        });
      }
    }
  }

  Future<void> _onDrop(dynamic event) async {
    if (event is html.FileList) {
      final file = event[0];
      final reader = html.FileReader();
      reader.readAsDataUrl(file);
      reader.onLoadEnd.listen((e) {
        setState(() {
          _webImage = file;
        });
      });
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  Widget _buildDropzoneContent() {
    return GestureDetector(
      onTap: _pickImage, 
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey,
            width: 0.5,
          ),
          borderRadius: BorderRadius.circular(8),
          color: Colors.white,
        ),
        child: _image == null && _webImage == null
            ? const Text(
                'Click to upload \nSVG, PNG, JPG, or GIF\n(max, 800 X 800px)',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey),
              )
            : _webImage != null
                ? Image.network(html.Url.createObjectUrl(_webImage!),
                    fit: BoxFit.cover)
                : Image.file(_image!, fit: BoxFit.cover),
      ),
    );
  }

  Widget buildTextField(String labelText, String placeholder, IconData iconData,
      {int maxLines = 1, VoidCallback? onTap}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          labelText,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          maxLines: maxLines,
          decoration: InputDecoration(
            hintText: placeholder,
            prefixIcon: Icon(iconData),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
              borderSide: const BorderSide(color: Colors.grey), 
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
              borderSide: const BorderSide(color: Colors.grey), 
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
              borderSide: const BorderSide(color: Colors.grey, width: 2), 
            ),
            filled: true,
            fillColor: Colors.white,
          ),
          readOnly: onTap != null,
          onTap: onTap,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.only(top: 40.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Your Photo Section
            Expanded(
              flex: 1,
              child: Container(
                height: 400, // Fixed height
                padding: const EdgeInsets.all(16.0),
                margin: const EdgeInsets.only(left: 16.0), // Add margin to create space from Navigation Rail
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      spreadRadius: 2,
                      blurRadius: 8,
                      offset: const Offset(0, 4), // Shadow position
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Your Photo',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          radius: 40,
                          backgroundImage: _image != null
                              ? FileImage(_image!) // Image from file
                              : (_webImage != null
                                  ? NetworkImage(html.Url.createObjectUrl(
                                      _webImage!)) // Image from web file
                                  : AssetImage('assets/images/Logo.png')
                                      as ImageProvider), 
                        ),
                        const SizedBox(width: 16),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextButton(
                              onPressed: _pickImage,
                              child: const Text(
                                'Edit your photo',
                                style: TextStyle(
                                    fontSize: 14, color: Colors.black),
                              ),
                            ),
                            Row(
                              children: [
                                TextButton(
                                  onPressed: () {},
                                  child: const Text(
                                    'Update',
                                    style: TextStyle(
                                        fontSize: 12, color: Colors.black),
                                  ),
                                ),
                                const SizedBox(width: 2),
                                TextButton(
                                  onPressed: () {
                                    setState(() {
                                      _image = null;
                                      _webImage = null;
                                    });
                                  },
                                  child: const Text(
                                    'Delete',
                                    style: TextStyle(
                                        fontSize: 12, color: Colors.black),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 32),
                    Container(
                      width: double.infinity,
                      height: 150,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                          color: Colors.blueAccent,
                        ),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Center(
                        child: _buildDropzoneContent(),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () {},
                          child: const Text('Cancel',
                              style: TextStyle(color: Colors.red)),
                        ),
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromARGB(255, 30, 144, 255),
                          ),
                          child: const Text('Save',
                              style: TextStyle(color: Colors.white)),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 12),
            // Personal Information Section
            Expanded(
              flex: 2,
              child: Container(
                height: 400, // Fixed height
                padding: const EdgeInsets.all(16.0),
                  margin: const EdgeInsets.only(right: 16.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(4),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      spreadRadius: 2,
                      blurRadius: 8,
                      offset: const Offset(0, 2), // Shadow position
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Personal Information',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: buildTextField('Full Name', '', Icons.person),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child:
                              buildTextField('Phone Number', '', Icons.phone),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    buildTextField('Address', '', Icons.location_on),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: buildTextField('Email', '', Icons.email),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: buildTextField(
                              'Date of Birth', '', Icons.calendar_today,
                              onTap: () => _selectDate(context)),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () {},
                          child: const Text('Cancel',
                              style: TextStyle(color: Colors.red)),
                        ),
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromARGB(255, 30, 144, 255),
                          ),
                          child: const Text('Save',
                              style: TextStyle(color: Colors.white)),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
