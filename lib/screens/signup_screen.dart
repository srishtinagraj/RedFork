import 'package:flutter/material.dart';
import 'package:flutter_application_1/resources/auth_methods.dart';
import 'package:flutter_application_1/screens/login_screeen.dart';
import 'package:flutter_application_1/utils/colors.dart';
import 'package:flutter_application_1/widgets/text_field_input.dart';
import '../utils/colors.dart';

bool _isLoading = false;

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 32),

              // logo
              Image.asset("assets/redfork_logo.png"),

              const SizedBox(height: 32),

              // first name text input
              TextInput(
                hintText: 'Enter your first name',
                textInputType: TextInputType.name,
                textEditingController: _firstNameController,
              ),
              const SizedBox(height: 16),

              // last name text input
              TextInput(
                hintText: 'Enter your last name',
                textInputType: TextInputType.name,
                textEditingController: _lastNameController,
              ),
              const SizedBox(height: 16),

              // email text input
              TextInput(
                hintText: 'Enter your email',
                textInputType: TextInputType.emailAddress,
                textEditingController: _emailController,
              ),
              const SizedBox(height: 16),

              // password text input
              TextInput(
                hintText: 'Enter your password',
                textInputType: TextInputType.text,
                textEditingController: _passwordController,
                isPass: true,
              ),
              const SizedBox(height: 32),

              // signup button
              ElevatedButton(
                onPressed: () async {
                  // Get the user input
                  final firstName = _firstNameController.text.trim();
                  final lastName = _lastNameController.text.trim();
                  final email = _emailController.text.trim();
                  final password = _passwordController.text.trim();

                  // Validate the input
                  if (firstName.isEmpty ||
                      lastName.isEmpty ||
                      email.isEmpty ||
                      password.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Please fill in all the fields.'),
                        backgroundColor: Colors.red,
                      ),
                    );
                    return;
                  }

                  setState(() {
                    _isLoading = true;
                  });

                  String? res = await AuthMethods().signUpUser(
                      firstName: _firstNameController.text,
                      lastName: _lastNameController.text,
                      email: _emailController.text,
                      password: _passwordController.text);
                  print(res);
                },


                child: const Text('Sign up'),
                
              ),
              

              const SizedBox(height: 32),

              // login link
              GestureDetector(
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                  );
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: const Text(
                    'Already have an account? Log in',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
