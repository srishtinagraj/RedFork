import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/donate_page.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromARGB(255, 236, 220, 214),
      child: Padding(
        padding: const EdgeInsets.only(top: 40),
        child: Stack(
          children: [
            Positioned(
              left: 0,
              top: 0,
              child: Material(
                color: Colors.transparent,
                child: SizedBox(
                  width: 80,
                  height: 80,
                  child: IconButton(
                    onPressed: () {},
                    icon: Image.asset('assets/profile.png'),
                  ),
                ),
              ),
            ),
            Positioned(
              right: 0,
              top: 0,
              child: Material(
                color: Colors.transparent,
                child: SizedBox(
                  width: 80,
                  height: 80,
                  child: IconButton(
                    onPressed: () {},
                    icon: Image.asset('assets/logout.png'),
                  ),
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/redfork_logo.png',
                  width: 300,
                  height: 200,
                ),
                const SizedBox(height: 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DonatePage()));
                      },
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(150, 50),
                        backgroundColor: Colors.red,
                      ),
                      child: const Text(
                        'Donate',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(150, 50),
                        backgroundColor: Colors.red,
                      ),
                      child: const Text(
                        'Receive',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 40),
                const SizedBox(height: 20),
                const SizedBox(height: 40),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
