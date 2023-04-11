import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class DonatePage extends StatefulWidget {
  const DonatePage({Key? key}) : super(key: key);

  @override
  _DonatePageState createState() => _DonatePageState();
}

class _DonatePageState extends State<DonatePage> {
  final List<Widget> _itemsList = [];
  final List<TextEditingController> _itemNameControllers = [];
  final List<TextEditingController> _quantityControllers = [];

  Widget _buildItemInput() {
    final itemNameController = TextEditingController();
    final quantityController = TextEditingController();
    _itemNameControllers.add(itemNameController);
    _quantityControllers.add(quantityController);

    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(right: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.white,
                border: Border.all(color: Colors.grey),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: TextField(
                  controller: itemNameController,
                  decoration: const InputDecoration(
                    hintText: 'Item Name',
                    border: InputBorder.none,
                    isDense: true,
                  ),
                ),
              ),
            ),
          ),
          Container(
            width: 50,
            height: 35,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Colors.white,
              border: Border.all(color: Colors.grey),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: TextField(
                controller: quantityController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  hintText: 'No.',
                  border: InputBorder.none,
                  isDense: true,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _addNewItem() {
    setState(() {
      _itemsList.add(_buildItemInput());
    });
  }

  void _submitDonations() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    final donationsRef = FirebaseFirestore.instance.collection('donations');
    final items = _itemsList
        .asMap()
        .entries
        .map((entry) {
          final itemName = _itemNameControllers[entry.key].text.trim();
          final quantity =
              int.tryParse(_quantityControllers[entry.key].text.trim()) ?? 0;
          if (itemName.isEmpty || quantity <= 0) return null;
          return {
            'itemName': itemName,
            'quantity': quantity,
          };
        })
        .where((item) => item != null)
        .map((item) => item as Map<String, dynamic>)
        .toList();

    if (items.isEmpty) return;

    await donationsRef.doc(user.uid).set({
      'user': user.uid,
      'items': items,
      'createdAt': FieldValue.serverTimestamp(),
    });

    // Navigate back to the main home page after submitting donations
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 236, 220, 214),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Image.asset(
              'assets/redfork_logo.png',
              width: 200,
              height: 120,
            ),
            const SizedBox(height: 40),
            Column(
              children: _itemsList,
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: IconButton(
                    onPressed: _addNewItem,
                    icon: Image.asset('assets/plus_logo.png'),
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: ElevatedButton(
                    onPressed: _submitDonations,
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 50),
                      backgroundColor: Colors.red,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: const Text(
                      'Submit',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
