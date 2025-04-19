import 'dart:convert';
import 'dart:io';
import 'dart:ui';
import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:camera/camera.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http; // Add this line for HTTP requests
import 'dart:math';

class PhotoStream extends StatefulWidget {
  @override
  _PhotoStreamState createState() => _PhotoStreamState();
}

class _PhotoStreamState extends State<PhotoStream> {
  final ImagePicker _picker = ImagePicker();
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final DatabaseReference _database = FirebaseDatabase.instance.ref().child('Clients');
  final DatabaseReference _sharedDatabase = FirebaseDatabase.instance.ref().child('shared_images');
  final FirebaseAuth _auth = FirebaseAuth.instance;
  CameraController? _cameraController;
  bool _isCameraInitialized = false;
  List<String> _selectedPhotoUrls = [];
  String _shareCode = '';
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    try {
      final cameras = await availableCameras();
      final firstCamera = cameras.first;

      _cameraController = CameraController(
        firstCamera,
        ResolutionPreset.medium,
      );

      await _cameraController!.initialize();

      if (!mounted) return;

      setState(() {
        _isCameraInitialized = true;
      });
    } catch (e) {
      print('Error initializing camera: $e');
      setState(() {
        _isCameraInitialized = false;
      });
    }
  }

  Future<void> _pickImage(ImageSource source) async {
    User? user = _auth.currentUser;

    final XFile? image = await _picker.pickImage(source: source);

    if (image != null) {
      File file = File(image.path);
      try {
        // Enhance image before uploading
        final enhancedImage = await _enhanceImage(file);

        final ref = _storage.ref().child('images/${user!.uid}/${DateTime.now().toString()}.jpg');
        await ref.putFile(enhancedImage);
        final url = await ref.getDownloadURL();

        await _database.child(user.uid).child("Photos").push().set({'url': url});
      } catch (e) {
        print(e);
      }
    }
  }

  Future<File> _enhanceImage(File image) async {
    // Placeholder for Gemini API photo enhancement
    final apiUrl = 'https://api.gemini.com/v1/photo/enhance'; // Replace with actual Gemini API endpoint
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer YOUR_GEMINI_API_KEY', // Replace with your Gemini API key
      },
      body: jsonEncode({
        'image': base64Encode(image.readAsBytesSync()), // Convert image to base64
      }),
    );

    if (response.statusCode == 200) {
      final enhancedImageBytes = base64Decode(jsonDecode(response.body)['enhanced_image']);
      final enhancedImagePath = '${image.path}_enhanced.jpg';
      final enhancedImageFile = File(enhancedImagePath)..writeAsBytesSync(enhancedImageBytes);
      return enhancedImageFile;
    } else {
      print('Failed to enhance image: ${response.body}');
      return image; // Return original image if enhancement fails
    }
  }

  Future<void> _takePicture() async {
    if (!_isCameraInitialized) return;

    try {
      final XFile? image = await _cameraController?.takePicture();
      if (image != null) {
        final File file = File(image.path);
        _showPreview(file);
      }
    } catch (e) {
      print('Error taking picture: $e');
    }
  }

  Future<void> _identifyPerson(File image) async {
    // Placeholder for Gemini API photo identification
    final apiUrl = 'https://api.gemini.com/v1/photo/identify'; // Replace with actual Gemini API endpoint
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer YOUR_GEMINI_API_KEY', // Replace with your Gemini API key
      },
      body: jsonEncode({
        'image': base64Encode(image.readAsBytesSync()), // Convert image to base64
      }),
    );

    if (response.statusCode == 200) {
      final identificationResult = jsonDecode(response.body);
      print('Identification result: $identificationResult');
      // Handle identification result
    } else {
      print('Failed to identify person: ${response.body}');
    }
  }

  void _showPreview(File image) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Preview'),
          content: Image.file(image),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Discard'),
            ),
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop();
                await _uploadImage(image);
                await _identifyPerson(image);
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _uploadImage(File image) async {
    User? user = _auth.currentUser;
    if (user == null) return;

    try {
      final ref = _storage.ref().child('images/${user.uid}/${DateTime.now().toString()}.jpg');
      await ref.putFile(image);
      final url = await ref.getDownloadURL();

      await _database.child(user.uid).child("Photos").push().set({'url': url});
    } catch (e) {
      print('Error uploading image: $e');
    }
  }

  Future<void> _selectMultipleImages() async {
    final List<XFile>? images = await _picker.pickMultiImage();
    User? user = _auth.currentUser;

    if (images != null) {
      for (var image in images) {
        File file = File(image.path);
        try {
          final ref = _storage.ref().child('images/${DateTime.now().toString()}.jpg');
          await ref.putFile(file);
          final url = await ref.getDownloadURL();

          await _database.child(user!.uid).child("Photos").push().set({'url': url});
        } catch (e) {
          print(e);
        }
      }
    }
  }

  void _selectImage(String url) {
    setState(() {
      if (_selectedPhotoUrls.contains(url)) {
        _selectedPhotoUrls.remove(url);
      } else {
        _selectedPhotoUrls.add(url);
      }
    });
  }

  Future<void> _shareSelectedImages(BuildContext context, List<String> selectedPhotoUrls) async {
    if (selectedPhotoUrls.isNotEmpty) {
      String uniqueCode = (1000 + Random().nextInt(9000)).toString();
      setState(() {
        _shareCode = uniqueCode;
      });
      for (String url in selectedPhotoUrls) {
        await _sharedDatabase.child(uniqueCode).push().set({'url': url});
      }
      final shareLink = 'https://kanrecieve.vercel.app?code=$uniqueCode';
      print('Test Share Link: $shareLink'); // Debugging
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Share QR Code'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                QrImageView(
                  data: shareLink,
                  version: QrVersions.auto,
                  size: 200.0,
                  gapless: false,
                ),
                Text('Share Code: $uniqueCode'),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () async {
                  if (await canLaunch(shareLink)) {
                    await launch(shareLink);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Could not launch the link')),
                    );
                  }
                },
                child: Text('Open Link'),
              ),
              TextButton(
                onPressed: () {
                  FlutterClipboard.copy(uniqueCode).then((value) {
                    Fluttertoast.showToast(
                      msg: 'Code copied to clipboard',
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                    );
                  });
                },
                child: Text('Copy Code'),
              ),
              TextButton(
                onPressed: () {
                  Share.share('Check out these images: $shareLink',
                      subject: 'Shared Images');
                },
                child: Text('Share to WhatsApp'),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text('Close'),
              ),
            ],
          );
        },
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('No images selected to share')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black54,
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Stack(
                children: [
                  _isCameraInitialized
                      ? Positioned.fill(
                    child: ImageFiltered(
                      imageFilter: ImageFilter.blur(sigmaX: 50, sigmaY: 52),
                      child: CameraPreview(_cameraController!),
                    ),
                  )
                      : Positioned.fill(
                    child: Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[100]!,
                      child: Container(
                        color: Colors.black.withOpacity(0.2),
                      ),
                    ),
                  ),
                  // Semi-transparent overlay
                  Container(
                    color: Colors.black.withOpacity(0.2),
                  ),
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () => _pickImage(ImageSource.camera),
                      child: Container(
                        width: double.infinity,
                        height: 560,
                        child: _isCameraInitialized
                            ? Center(
                          child: Padding(
                            padding: const EdgeInsets.all(28.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(30),
                              child: Container(
                                color: Colors.black,
                                width: double.infinity,
                                height: 500,
                                child: CameraPreview(_cameraController!),
                              ),
                            ),
                          ),
                        )
                            : Center(
                          child: Icon(
                            Icons.camera_alt,
                            size: 100,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 70,
                    left: MediaQuery.of(context).size.width / 2 - 35,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          onTap: _takePicture,
                          child: Icon(
                            Icons.camera_sharp,
                            size: 50,
                            color: Colors.white,
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.photo_library, color: Colors.amberAccent,),
                          onPressed: _selectMultipleImages,
                        ),
                      ],
                    ),
                  ),

                ],
              ),


               Container(
                  height: 333,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                  ),
                  child: Column(
                    children: [
                      Expanded(
                        child: SingleChildScrollView(
                          controller: _scrollController,
                          child: StreamBuilder(
                            stream: _database.child(_auth.currentUser?.uid ?? '').child("Photos").onValue,
                            builder: (context, AsyncSnapshot<DatabaseEvent> snapshot) {
                              if (snapshot.hasData) {
                                final photos = (snapshot.data!.snapshot.value as Map?)?.values.toList() ?? [];
                                return Column(
                                  children: photos.map((photo) {
                                    final url = photo['url'];
                                    final isSelected = _selectedPhotoUrls.contains(url);

                                    return Card(
                                      margin: EdgeInsets.all(8),
                                      child: ListTile(
                                        contentPadding: EdgeInsets.all(8),
                                        leading: Image.network(
                                          url,
                                          width: 60,
                                          height: 60,
                                          fit: BoxFit.cover,
                                        ),
                                        title: Text('Image'),
                                        trailing: Icon(
                                          isSelected ? Icons.check_box : Icons.check_box_outline_blank,
                                          color: isSelected ? Colors.blue : null,
                                        ),
                                        onTap: () => _selectImage(url),
                                      ),
                                    );
                                  }).toList(),
                                );
                              } else {
                                return Center(child: CircularProgressIndicator());
                              }
                            },
                          ),
                        ),
                      ),
                      SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () => _shareSelectedImages(context, _selectedPhotoUrls),
                        child: Text('Share Selected Images'),
                      ),
                    ],
                  ),
                ),

            ],
          ),
        ),
      ),
    );
  }
}
