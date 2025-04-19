import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:share_plus/share_plus.dart';

class ShareImageWidget extends StatelessWidget {
  final String imageUrl;
  final GlobalKey key = GlobalKey();

  ShareImageWidget({required this.imageUrl});

  Future<void> _shareImage() async {
    try {
      final RenderRepaintBoundary boundary = key.currentContext!.findRenderObject() as RenderRepaintBoundary;
      final ui.Image image = await boundary.toImage();
      final ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
      final Uint8List pngBytes = byteData!.buffer.asUint8List();

      final Directory tempDir = await getTemporaryDirectory();
      final String filePath = '${tempDir.path}/qr.png';
      final File file = File(filePath);
      await file.writeAsBytes(pngBytes);
      final XFile xFile = XFile(filePath);
      await Share.shareXFiles([xFile], text: 'Check out this image: $imageUrl');
    } catch (e) {
      print('Error sharing image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar( title: Text(""),
      ),
      body:Container(
        width: 200, // Set the desired width
        height: 300, // Set the desired height
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              QrImageView(
                data: imageUrl,
                version: QrVersions.auto,
                size: 200.0,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _shareImage,
                child: Text('Share'),
              ),
            ],
          ),
        ),
      )

    );
  }
}
