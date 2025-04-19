import 'package:flutter/material.dart';

class HomeDashboard extends StatelessWidget {
  const HomeDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("KanShare Dashboard"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.photo_library, size: 80, color: Colors.blue),
            SizedBox(height: 20),
            Text(
              'Welcome to KanShare!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'View your recent activity here.',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            SizedBox(height: 40),
            ElevatedButton.icon(
              onPressed: () {
                // future: Navigate to album creation quickly
              },
              icon: Icon(Icons.add_photo_alternate),
              label: Text("Create New Album"),
            ),
          ],
        ),
      ),
    );
  }
}


// import 'package:flutter/material.dart';

// class HomeDashboard extends StatelessWidget {
//   const HomeDashboard({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color.fromARGB(255, 57, 54, 71), // Light yellow vibe
//       body: SafeArea(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             const SizedBox(height: 40),

//             //Logo
//             Center(
//               child: Image.asset('assets/animations/logo.png', height: 80,),
//             ),

//             const SizedBox(height: 20),

//             Text("KanShare", style: TextStyle(fontFamily: 'Montserrat', fontSize: 26, fontWeight: FontWeight.bold, color: Colors.white,),),

//             // Center(
//             //   child: Text(
//             //     "KanShare",
//             //     style: TextStyle(
//             //       fontFamily: 'Montserrat',
//             //       fontSize: 26,
//             //       fontWeight: FontWeight.bold,
//             //       color: Colors.black87,
//             //     ),
//             //   ),
//             // ),

//             const SizedBox(height: 40),

//             // Feature image
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 32),
//               child: ClipRRect(
//                 borderRadius: BorderRadius.circular(20),
//                 child: Image.asset(
//                   'assets/animations/selfie.png', // Add a local image in assets
//                   fit: BoxFit.cover,
//                   height: 100,
//                 ),
//               ),
//             ),

//             const SizedBox(height: 30),

//             // Welcome Text
//             Text(
//               "Start your new\nPhoto Journey",
//               textAlign: TextAlign.center,
//               style: TextStyle(
//                 fontSize: 24,
//                 fontWeight: FontWeight.w700,
//                 color: Colors.white,
//               ),
//             ),
//             const SizedBox(height: 12),
//             Text(
//               "Create, share, and explore albums\nwith your friends.",
//               textAlign: TextAlign.center,
//               style: TextStyle(
//                 fontSize: 16,
//                 color: Colors.white70,
//               ),
//             ),

//             const SizedBox(height: 40),

//             // CTA Button
//             ElevatedButton(
//               onPressed: () {
//                 // Navigate to CreateAlbumScreen
//                 DefaultTabController.of(context)?.animateTo(1);
//               },
//               style: ElevatedButton.styleFrom(
//                 padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 14),
//                 backgroundColor: Colors.white,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//               ),
//               child: const Text(
//                 "Create New Album",
//                 style: TextStyle(color: Colors.black, fontSize: 16),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
















// import 'package:flutter/material.dart';

// class HomeDashboard extends StatelessWidget {
//   const HomeDashboard({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFFFA726), // Warm orange base
//       body: SafeArea(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.spaceAround,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             const SizedBox(height: 20),

//             // Center Art/Graphic (your selfie image or similar stack of images)
//             Stack(
//               alignment: Alignment.center,
//               children: [
//                 // Background Cards for layered effect
//                 Positioned(
//                   left: 40,
//                   child: Transform.rotate(
//                     angle: -0.2,
//                     child: Image.asset('assets/animations/selfie.png', height: 200, width: 130, fit: BoxFit.cover),
//                   ),
//                 ),
//                 Positioned(
//                   right: 40,
//                   child: Transform.rotate(
//                     angle: 0.2,
//                     child: Image.asset('assets/animations/selfie.png', height: 200, width: 130, fit: BoxFit.cover),
//                   ),
//                 ),
//                 // Foreground center card
//                 Container(
//                   height: 230,
//                   width: 150,
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(16),
//                     boxShadow: [
//                       BoxShadow(color: Colors.black26, blurRadius: 10, offset: Offset(0, 4)),
//                     ],
//                   ),
//                   child: ClipRRect(
//                     borderRadius: BorderRadius.circular(16),
//                     child: Image.asset('assets/selfie.png', fit: BoxFit.cover),
//                   ),
//                 ),
//               ],
//             ),

//             // App Title
//             Text(
//               "KanShare",
//               style: TextStyle(
//                 fontFamily: 'Montserrat',
//                 fontSize: 28,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.white,
//               ),
//             ),

//             // Description
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 40.0),
//               child: Column(
//                 children: [
//                   Text(
//                     "Start your new\nPhoto Journey",
//                     textAlign: TextAlign.center,
//                     style: TextStyle(
//                       fontSize: 24,
//                       fontWeight: FontWeight.w700,
//                       color: Colors.white,
//                     ),
//                   ),
//                   const SizedBox(height: 12),
//                   Text(
//                     "Snap, share, and relive memories.\nOnly good vibes allowed.",
//                     textAlign: TextAlign.center,
//                     style: TextStyle(
//                       fontSize: 16,
//                       color: Colors.white70,
//                     ),
//                   ),
//                 ],
//               ),
//             ),

//             // Page Indicator
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Icon(Icons.circle, size: 10, color: Colors.white),
//                 SizedBox(width: 4),
//                 Icon(Icons.circle_outlined, size: 10, color: Colors.white70),
//               ],
//             ),

//             // CTA Button
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 32.0),
//               child: ElevatedButton(
//                 onPressed: () {
//                   DefaultTabController.of(context)?.animateTo(1);
//                 },
//                 style: ElevatedButton.styleFrom(
//                   minimumSize: Size.fromHeight(50),
//                   backgroundColor: Colors.black,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(16),
//                   ),
//                 ),
//                 child: const Text(
//                   "Get Started",
//                   style: TextStyle(color: Colors.white, fontSize: 18),
//                 ),
//               ),
//             ),

//             // Login text
//             TextButton(
//               onPressed: () {
//                 // Navigate to login
//               },
//               child: Text(
//                 "Already have an account? Login",
//                 style: TextStyle(color: Colors.white),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
