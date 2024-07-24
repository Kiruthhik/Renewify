import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class PostWritePage extends StatefulWidget {
  final Function(String, String?) onPostCreated;

  PostWritePage({required this.onPostCreated});

  @override
  _PostWritePageState createState() => _PostWritePageState();
}

class _PostWritePageState extends State<PostWritePage> {
  final TextEditingController _controller = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  XFile? _imageFile;

  Future<void> _pickImage() async {
    try {
      final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
      setState(() {
        _imageFile = pickedFile;
      });
    } catch (e) {
      // Handle image picking error
      print('Error picking image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Write a Post'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: 'Type your post here...',
              ),
              maxLines: null,
            ),
            SizedBox(height: 20),
            if (_imageFile != null)
              Image.file(
                File(_imageFile!.path),
                height: 150,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: _pickImage,
              icon: Icon(Icons.photo),
              label: Text('Pick Image'),
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5), // Adjust as needed
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (_controller.text.trim().isNotEmpty) {
                  widget.onPostCreated(
                    _controller.text,
                    _imageFile?.path, // Pass the file path
                  );
                  Navigator.pop(
                      context); // Go back to the post view page after posting
                } else {
                  // Show message to user if the post is empty
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Post cannot be empty')),
                  );
                }
              },
              child: Text('Post'),
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5), // Adjust as needed
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
