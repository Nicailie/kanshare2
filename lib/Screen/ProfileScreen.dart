import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 20),
              CircleAvatar(
                radius: 60,
                backgroundImage: NetworkImage('https://via.placeholder.com/150'), // replace with your image url
              ),
              const SizedBox(height: 20),
              Center(
                child: Text(
                  'John Doe', // replace with your dynamic name
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Center(
                child: Text(
                  'johndoe@example.com', // replace with your dynamic email
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Card(
                child: ListTile(
                  leading: const Icon(Icons.phone),
                  title: const Text('Phone Number'),
                  subtitle: const Text('123-456-7890'), // replace with your dynamic phone number
                  trailing: IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () {
                      // implement edit functionality
                    },
                  ),
                ),
              ),
              Card(
                child: ListTile(
                  leading: const Icon(Icons.location_on),
                  title: const Text('Location'),
                  subtitle: const Text('Accra, Ghana'), // replace with your dynamic location
                  trailing: IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () {
                      // implement edit functionality
                    },
                  ),
                ),
              ),
              Card(
                child: ListTile(
                  leading: const Icon(Icons.business),
                  title: const Text('Company'),
                  subtitle: const Text('Example Company'), // replace with your dynamic company name
                  trailing: IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () {
                      // implement edit functionality
                    },
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // implement logout functionality
                },
                child: const Text('Logout'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
