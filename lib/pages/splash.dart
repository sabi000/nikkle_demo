import 'package:flutter/material.dart';
import 'package:nikkle/utils/colors.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

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
          children: [
            SizedBox(
              width: width,
              height: isPortrait ? height * 0.6 : height * 0.4,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  isPortrait
                      ? Image.asset(
                          'assets/images/splash.png',
                          width: width,
                          height: height * 0.6,
                          fit: BoxFit.fill,
                        )
                      : Image.asset(
                          'assets/images/splash_land.png',
                          width: width,
                          height: height * 0.4,
                          fit: BoxFit.fill,
                        ),
                  Image.asset(
                    'assets/images/nikkle.png',
                    width: smallestSide * 0.2,
                    height: smallestSide * 0.2,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: height * 0.05,
            ),
            Container(
              padding: EdgeInsets.symmetric(
                  vertical: 20.0,
                  horizontal: isPortrait ? width * 0.12 : width * 0.3),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('NIKKLE',
                      style: Theme.of(context).textTheme.headlineLarge),
                  const SizedBox(height: 8),
                  Text(
                    'Simplify everything with Nikkle: accounting, HR, CRM, project management, and credit applications!',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  SizedBox(height: height * 0.05),
                  SizedBox(
                    width: smallestSide * 0.5,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        //go to login page
                      },
                      icon: const CircleAvatar(
                        radius: 20,
                        backgroundColor: TColors.bg,
                        child: Icon(
                          Icons.login,
                          color: TColors.primary,
                          size: 28,
                        ),
                      ),
                      iconAlignment: IconAlignment.end,
                      label: Text(
                        'LOGIN',
                        style:
                            Theme.of(context).textTheme.titleMedium?.copyWith(
                                  color: Colors.white,
                                ),
                      ),
                      style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 32.0, vertical: 12.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          backgroundColor: TColors.primary,
                          foregroundColor: TColors.bg),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
