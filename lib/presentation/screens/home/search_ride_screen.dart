import 'package:flutter/material.dart';

/// Search Ride screen
class SearchRideScreen extends StatelessWidget {
  const SearchRideScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Search Rides')),
      body: const Center(child: Text('Search Rides Screen')),
    );
  }
}
