// import 'dart:io';
// import 'dart:ui';

// import 'package:camera/camera.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:firebase_database/firebase_database.dart';
// import 'package:flutter_image_compress/flutter_image_compress.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:kanshare/Widget/photostream.dart';

// import '../Widget/ShareImageWidget.dart';

// class HomeScreen extends StatefulWidget {
//   @override
//   _HomeScreenState createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final DatabaseReference _dbRef = FirebaseDatabase.instance.ref();
//   List<String> _recentlyOpenedUrls = [];
//   List<String> _previouslySharedUrls = [];
//   int _selectedIndex = 0; // To keep track of selected page
//   List<String> _photoUrls = [];
//   TextEditingController _codeController = TextEditingController();
//   bool _isLoading = false;

//   void _loadImagesFromCode() async {
//     setState(() {
//       _isLoading = true;
//       _photoUrls = [];
//     });

//     final String code = _codeController.text.trim();
//     if (code.isNotEmpty) {
//       final DatabaseReference ref = FirebaseDatabase.instance.ref().child(
//           'shared_images').child(code);
//       final DataSnapshot snapshot = await ref.get();

//       if (snapshot.exists) {
//         final photos = snapshot.value as Map<dynamic, dynamic>;
//         final urls = photos.values.map((photo) => photo['url'] as String)
//             .toList();
//         setState(() {
//           _photoUrls = urls;
//         });
//       } else {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('No images found for the provided code')),
//         );
//       }
//     }

//     setState(() {
//       _isLoading = false;
//     });
//   }

//   @override
//   void initState() {
//     super.initState();
//     _fetchImages();
//     _initializeCamera();  }

//   Future<void> _fetchImages() async {
//     final User? user = _auth.currentUser;
//     if (user == null) return;

//     final DatabaseReference userRef = _dbRef.child('Clients/${user.uid}');

//     // Fetch Recently Opened Images
//     final DataSnapshot recentSnapshot = await userRef.child('recentlyOpened')
//         .get();
//     final recentData = recentSnapshot.value;

//     // Fetch Previously Shared Images
//     final DataSnapshot previousSnapshot = await userRef.child(
//         'previouslyShared').get();
//     final previousData = previousSnapshot.value;

//     // Debugging: Print the actual data structure
//     print('Recently Opened Data: $recentData');
//     print('Previously Shared Data: $previousData');

//     // Type casting after inspecting the data structure
//     final List<String> recentlyOpenedUrls = [];
//     if (recentData is Map) {
//       recentData.forEach((key, value) {
//         if (value is String) {
//           recentlyOpenedUrls.add(value);
//         }
//       });
//     }

//     final List<String> previouslySharedUrls = [];
//     if (previousData is Map) {
//       previousData.forEach((key, value) {
//         if (value is String) {
//           previouslySharedUrls.add(value);
//         }
//       });
//     }

//     setState(() {
//       _recentlyOpenedUrls = recentlyOpenedUrls;
//       _previouslySharedUrls = previouslySharedUrls;
//     });
//   }

//   void _shareImage(String imageUrl) async {
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//           builder: (context) => ShareImageWidget(imageUrl: imageUrl)),
//     );
//   }

//   final ImagePicker _picker = ImagePicker();
//   final DatabaseReference _database = FirebaseDatabase.instance.ref();
//   final FirebaseStorage _storage = FirebaseStorage.instance;

//   Future<void> _pickAndUploadImage() async {
//     final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

//     if (image != null) {
//       File file = File(image.path);
//       try {
//         final ref = _storage.ref().child(
//             'images/${DateTime.now().toString()}.jpg');
//         await ref.putFile(file);
//         final url = await ref.getDownloadURL();

//         _database.child('photos').push().set({'url': url});
//       } catch (e) {
//         print(e);
//       }
//     }
//   }
//   late CameraController _cameraController;
//   bool _isCameraInitialized = false;


//   Future<void> _initializeCamera() async {
//     final cameras = await availableCameras();
//     final camera = cameras.first;
//     _cameraController = CameraController(camera, ResolutionPreset.high);
//     await _cameraController.initialize();
//     if (mounted) {
//       setState(() {
//         _isCameraInitialized = true;
//       });
//     }
//   }

//   @override
//   void dispose() {
//     _cameraController.dispose();
//     super.dispose();
//   }

//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // appBar: AppBar(
//       //   flexibleSpace: _isCameraInitialized
//       //       ? Stack(
//       //     children: [
//       //       // Camera preview with blur effect
//       //       Positioned.fill(
//       //         child: ImageFiltered(
//       //           imageFilter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
//       //           child: CameraPreview(_cameraController),
//       //         ),
//       //       ),
//       //       // Semi-transparent overlay
//       //
//       //     ],
//       //   )
//       //       : Container(color: Colors.black.withOpacity(0.2)),
//       //   title: Text(
//       //     'KanShare',
//       //     style: TextStyle(fontWeight: FontWeight.bold),
//       //   ),
//       //   actions: [
//       //     TextButton(
//       //       onPressed: () {
//       //         showDialog<void>(
//       //           context: context,
//       //           barrierDismissible: false,
//       //           builder: (BuildContext context) {
//       //             return AlertDialog(
//       //               title: Text('Sign Out'),
//       //               backgroundColor: Colors.white,
//       //               content: SingleChildScrollView(
//       //                 child: Column(
//       //                   children: <Widget>[
//       //                     Text('Are you certain you want to Sign Out?'),
//       //                   ],
//       //                 ),
//       //               ),
//       //               actions: <Widget>[
//       //                 TextButton(
//       //                   child: Text(
//       //                     'Yes',
//       //                     style: TextStyle(color: Colors.black),
//       //                   ),
//       //                   onPressed: () {
//       //                     FirebaseAuth.instance.signOut();
//       //                     Navigator.pushNamedAndRemoveUntil(
//       //                         context, "/Sign", (route) => false);
//       //                   },
//       //                 ),
//       //                 TextButton(
//       //                   child: Text(
//       //                     'Cancel',
//       //                     style: TextStyle(color: Colors.red),
//       //                   ),
//       //                   onPressed: () {
//       //                     Navigator.of(context).pop();
//       //                   },
//       //                 ),
//       //               ],
//       //             );
//       //           },
//       //         );
//       //       },
//       //       child: Icon(
//       //         Icons.logout,
//       //         color: Color(0xFF0047AB),
//       //       ),
//       //     )
//       //   ],
//       // ),
//       body: _selectedIndex == 0 ? PhotoStream() : _buildSendImagePage(),
//       bottomNavigationBar: BottomNavigationBar(
//         items: const <BottomNavigationBarItem>[
//           BottomNavigationBarItem(
//             icon: Icon(Icons.upload_file),
//             label: 'Share',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.upload_file),
//             label: 'Receive',
//           ),
//         ],
//         currentIndex: _selectedIndex,
//         selectedItemColor: Colors.blue,
//         onTap: _onItemTapped,
//       ),
//     );
//   }

//   Widget _buildSendImagePage() {
//     return Column(
//       children: [
//         Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: TextField(
//             controller: _codeController,
//             decoration: InputDecoration(
//               border: OutlineInputBorder(),
//               labelText: 'Enter Share Code',
//             ),
//           ),
//         ),
//         ElevatedButton(
//           onPressed: _loadImagesFromCode,
//           child: Text('Load Images'),
//         ),
//         Expanded(
//           child: _isLoading
//               ? Center(
//             child: CircularProgressIndicator(),
//           )
//               : _photoUrls.isEmpty
//               ? Center(
//             child: Text('No photos loaded.'),
//           )
//               : GridView.builder(
//             gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//               crossAxisCount: 2,
//             ),
//             itemCount: _photoUrls.length,
//             itemBuilder: (context, index) {
//               final url = _photoUrls[index];
//               return Card(
//                 margin: EdgeInsets.all(8),
//                 child: Image.network(
//                   url,
//                   fit: BoxFit.cover,
//                   loadingBuilder: (context, child, loadingProgress) {
//                     if (loadingProgress == null) return child;
//                     return Center(
//                       child: CircularProgressIndicator(
//                         value: loadingProgress.expectedTotalBytes != null
//                             ? loadingProgress.cumulativeBytesLoaded /
//                             (loadingProgress.expectedTotalBytes ?? 1)
//                             : null,
//                       ),
//                     );
//                   },
//                   errorBuilder: (context, error, stackTrace) {
//                     return Center(child: Text('Failed to load image'));
//                   },
//                 ),
//               );
//             },
//           ),
//         ),
//       ],
//     );
//   }
// }

import 'package:flutter/material.dart'; 
import '../Widget/CreateAlbumScreen.dart'; 
import '../Widget/ViewSharedAlbumScreen.dart';
import '../Widget/HomeDashboard.dart'; 

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>{
  int _selectedIndex = 0; 

  final List <Widget> _pages = [
    HomeDashboard(),
    CreateAlbumScreen(),
    ViewSharedAlbumScreen(),
  ];
    void _onTabTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onTabTapped,
        selectedItemColor: Colors.blue,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_photo_alternate),
            label: 'Create Album',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.qr_code),
            label: 'View Album',
          ),
        ],
      ),
    );
  }
}