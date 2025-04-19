import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../Widget/ShareImageWidget.dart';

class UploadImage extends StatefulWidget {
  const UploadImage({super.key});

  @override
  State<UploadImage> createState() => _UploadImageState();
}

class _UploadImageState extends State<UploadImage> {
  final picker = ImagePicker();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final DatabaseReference _dbRef = FirebaseDatabase.instance.ref();
  List<String> _recentlyOpenedUrls = [];
  List<String> _previouslySharedUrls = [];
  List<File> _images = [];
  String? _currentUid;

  @override
  void initState() {
    super.initState();
    _getCurrentUserUid();
    _fetchImages();
  }

  void _getCurrentUserUid() {
    User? user = _auth.currentUser;
    if (user != null) {
      setState(() {
        _currentUid = user.uid;
      });
    } else {
      print('No user is currently signed in.');
    }
  }

  Future<void> _fetchImages() async {
    final User? user = _auth.currentUser;
    if (user == null) return;

    final DatabaseReference userRef = _dbRef.child('Clients/${user.uid}');

    // Fetch Recently Opened Images
    final DataSnapshot recentSnapshot = await userRef.child('recentlyOpened').get();
    final Map<dynamic, dynamic>? recentData = recentSnapshot.value as Map<dynamic, dynamic>?;

    // Fetch Previously Shared Images
    final DataSnapshot previousSnapshot = await userRef.child('previouslyShared').get();
    final Map<dynamic, dynamic>? previousData = previousSnapshot.value as Map<dynamic, dynamic>?;

    setState(() {
      _recentlyOpenedUrls = recentData?.values.cast<String>().toList() ?? [];
      _previouslySharedUrls = previousData?.values.cast<String>().toList() ?? [];
    });
  }

  Future<void> pickImages() async {
    List<XFile>? pickedFiles = await picker.pickMultiImage();
    if (pickedFiles != null) {
      setState(() {
        _images = pickedFiles.map((file) => File(file.path)).toList();
      });
      uploadFiles();
    }
  }

  Future<void> uploadFiles() async {
    for (var image in _images) {
      await uploadFile(image);
    }
  }

  Future<void> uploadFile(File image) async {
    User? user = _auth.currentUser;
    if (user == null) return;

    String fileName = 'uploads/${_currentUid.toString()}/${DateTime.now().millisecondsSinceEpoch}.png';
    try {
      Reference ref = FirebaseStorage.instance.ref().child(fileName);
      UploadTask uploadTask = ref.putFile(image);

      TaskSnapshot taskSnapshot = await uploadTask;
      String downloadURL = await taskSnapshot.ref.getDownloadURL();

      setState(() {
        _recentlyOpenedUrls.add(downloadURL);
      });

      _dbRef.child('Clients/${user.uid}/recentlyOpened').push().set({
        'url': downloadURL,
      });
    } catch (e) {
      print('Error: $e');
    }
  }

  void _shareImage(String imageUrl) async {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ShareImageWidget(imageUrl: imageUrl)),
    );
  }

  Future<void> _handleQRCodeScan(String imageUrl) async {
    final User? user = _auth.currentUser;
    if (user == null) return;

    final DatabaseReference userRef = _dbRef.child('Clients/${user.uid}');

    // Move the image from recently opened to previously shared
    final DataSnapshot recentSnapshot = await userRef.child('recentlyOpened').get();
    final Map<String, dynamic>? recentData = recentSnapshot.value as Map<String, dynamic>?;

    if (recentData != null) {
      for (String key in recentData.keys) {
        if (recentData[key] == imageUrl) {
          // Remove from recently opened
          await userRef.child('recentlyOpened/$key').remove();

          // Add to previously shared
          await userRef.child('previouslyShared').push().set({'url': imageUrl});

          setState(() {
            _recentlyOpenedUrls.remove(imageUrl);
            _previouslySharedUrls.add(imageUrl);
          });

          break;
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'KanShare',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          TextButton(
            onPressed: () {
              showDialog<void>(
                context: context,
                barrierDismissible: false,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Sign Out'),
                    backgroundColor: Colors.white,
                    content: SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
                          Text('Are you certain you want to Sign Out?'),
                        ],
                      ),
                    ),
                    actions: <Widget>[
                      TextButton(
                        child: Text(
                          'Yes',
                          style: TextStyle(color: Colors.black),
                        ),
                        onPressed: () {
                          FirebaseAuth.instance.signOut();
                          Navigator.pushNamedAndRemoveUntil(
                              context, "/Sign", (route) => false);
                        },
                      ),
                      TextButton(
                        child: Text(
                          'Cancel',
                          style: TextStyle(color: Colors.red),
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
                },
              );
            },
            child: Icon(
              Icons.logout,
              color: Color(0xFF0047AB),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          height: 500,
          child: Column(
            children: [
              _recentlyOpenedUrls.isEmpty
                  ? Center(child: CircularProgressIndicator())
                  : Column(
                      children: [
                        Text(
                          "Recently Uploaded",
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        Container(
                          height: 150,
                          margin: EdgeInsets.all(8.0),
                          padding: EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black26,
                                blurRadius: 4.0,
                                offset: Offset(2, 2),
                              ),
                            ],
                          ),
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: _recentlyOpenedUrls.map((url) {
                              return GestureDetector(
                                onTap: () => _shareImage(url),
                                child: Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Image.network(url),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ],
                    ),
              // SizedBox(height: 23,),
              // _previouslySharedUrls.isEmpty
              //     ? Container()
              //     : Column(
              //         children: [
              //           Text(
              //             "Previously Shared",
              //             style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              //           ),
              //           Container(
              //             height: 150,
              //             margin: EdgeInsets.all(8.0),
              //             padding: EdgeInsets.all(8.0),
              //             decoration: BoxDecoration(
              //               color: Colors.white,
              //               borderRadius: BorderRadius.circular(8.0),
              //               boxShadow: [
              //                 BoxShadow(
              //                   color: Colors.black26,
              //                   blurRadius: 4.0,
              //                   offset: Offset(2, 2),
              //                 ),
              //               ],
              //             ),
              //             child: ListView(
              //               scrollDirection: Axis.horizontal,
              //               children: _previouslySharedUrls.map((url) {
              //                 return GestureDetector(
              //                   onTap: () => _shareImage(url),
              //                   child: Padding(
              //                     padding: const EdgeInsets.all(4.0),
              //                     child: Image.network(url),
              //                   ),
              //                 );
              //               }).toList(),
              //             ),
              //           ),
              //         ],
              //       ),
              SizedBox(
                height: 50,
              ),
              ElevatedButton(
                onPressed: pickImages,
                child: Text("Pick Images"),
              ),
              _images.isNotEmpty
                  ? Expanded(
                      child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 4.0,
                          mainAxisSpacing: 4.0,
                        ),
                        itemCount: _images.length,
                        itemBuilder: (BuildContext context, int index) {
                          File image = _images[index];
                          return Image.file(
                            image,
                            width: 300,
                            height: 300,
                            fit: BoxFit.cover,
                          );
                        },
                      ),
                    )
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }
}
