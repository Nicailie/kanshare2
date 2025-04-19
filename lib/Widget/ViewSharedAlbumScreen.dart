import 'package:flutter/material.dart';

class ViewSharedAlbumScreen extends StatefulWidget {
  const ViewSharedAlbumScreen({super.key});

  @override
  State<ViewSharedAlbumScreen> createState() => _ViewSharedAlbumScreenState();
}

class _ViewSharedAlbumScreenState extends State<ViewSharedAlbumScreen> {
  final TextEditingController _codeController = TextEditingController();

  void _loadAlbumFromCode() {
    final code = _codeController.text.trim();
    if (code.isNotEmpty) {
      // TODO: Use code to load album from Firebase
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Feature coming soon! Code: $code')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("View Shared Album"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              controller: _codeController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Enter Album Code',
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _loadAlbumFromCode,
              child: Text("Load Album"),
            ),
            SizedBox(height: 40),
            Center(
              child: Text(
                "Once loaded, the shared photos will appear here.",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
