import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MyDonationsPage extends StatelessWidget {
  const MyDonationsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return const Center(
        child: Text('User not signed in'),
      );
    }

    final donationsRef =
        FirebaseFirestore.instance.collection('donations').doc(user.uid);
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Donations'),
      ),
      body: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        stream: donationsRef.snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text('Error loading donations'),
            );
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          final data = snapshot.data?.data();
          if (data == null || data.isEmpty) {
            return const Center(
              child: Text('No donations found'),
            );
          }

          final items = (data['items'] as List<dynamic>)
              .map((item) => DonationItem.fromMap(item))
              .toList();

          return ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              final item = items[index];
              return ListTile(
                title: Text(item.itemName),
                subtitle: Text('Quantity: ${item.quantity}'),
              );
            },
          );
        },
      ),
    );
  }
}

class DonationItem {
  final String itemName;
  final int quantity;

  const DonationItem({
    required this.itemName,
    required this.quantity,
  });

  factory DonationItem.fromMap(Map<String, dynamic> map) {
    return DonationItem(
      itemName: map['itemName'] as String,
      quantity: map['quantity'] as int,
    );
  }
}
