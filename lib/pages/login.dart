import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:nikkle/utils/colors.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    double smallestSide = width < height ? width : height;
    bool isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: width,
              height: height * 0.2,
              child: isPortrait
                  ? Image.asset(
                      'assets/images/vec1.png',
                      fit: BoxFit.fill,
                    )
                  : Image.asset(
                      'assets/images/vec1_land.png',
                      fit: BoxFit.fill,
                    ),
            ),
            SizedBox(height: height * 0.05),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: isPortrait ? width * 0.1 : width * 0.3),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(
                    'assets/images/logo.png',
                    height: 100,
                  ),
                  SizedBox(height: smallestSide * 0.05),
                  Text(
                    "Let's get something",
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  Text(
                    'Good to see you back.',
                    style: Theme.of(context)
                        .textTheme
                        .titleSmall
                        ?.copyWith(color: Colors.black.withOpacity(0.65)),
                  ),
                ],
              ),
            ),
            SizedBox(height: smallestSide * 0.1),
            Center(
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: isPortrait ? width * 0.1 : width * 0.3),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const TextField(
                      decoration: InputDecoration(
                          labelText: 'Email',
                          labelStyle: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                          hintText: 'abc123@gmail.com'),
                    ),
                    SizedBox(height: smallestSide * 0.05),
                    TextField(
                      obscureText: true,
                      obscuringCharacter: '*',
                      decoration: InputDecoration(
                        isCollapsed: true,
                        contentPadding:
                            const EdgeInsets.symmetric(vertical: 0.0),
                        labelText: 'Password',
                        labelStyle: const TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                        hintText: '********',
                        suffix: TextButton(
                          onPressed: () {
                            // go to forgot password
                          },
                          child: const Text(
                            'Forgot?',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: smallestSide * 0.1),
                    SizedBox(
                      width: smallestSide * 0.7,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/home');
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 32.0, vertical: 12.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          backgroundColor: TColors.primary,
                          foregroundColor: TColors.white,
                        ),
                        child: Text(
                          'Log In',
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge
                              ?.copyWith(color: TColors.white),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Text.rich(
                        style: const TextStyle(fontSize: 16),
                        TextSpan(
                          children: [
                            const TextSpan(text: "Don't have an account? "),
                            TextSpan(
                              text: 'Sign Up',
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  // go to signup
                                },
                              style: const TextStyle(
                                color: TColors.primary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: smallestSide * 0.2),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
