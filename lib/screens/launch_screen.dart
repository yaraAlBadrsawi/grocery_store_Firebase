import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:grocery_store/admin/dashBoard_screen.dart';
import 'package:grocery_store/constants.dart';
import 'package:grocery_store/screens/auth/signup_screen.dart';

// import '../firebase_options.dart';
import '../admin/add_product_screen.dart';
import '../firebase_options.dart';
import '../widget/text_widget.dart';
import 'add_product.dart';
import 'buttom_bar.dart';

class WelcomeScreen extends StatefulWidget {
  static const routeName = "/launchScreen";
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  void connectWithFirebase() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    )
        .then(
          (app) => print("Firebase is connected"),
        )
        .catchError(
          (error) => print("Error connecting to Firebase: $error"),
        );
  }

  @override
  void initState() {
    super.initState();
    connectWithFirebase();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: Opacity(
                opacity: 0.4,
                child: Image.asset(
                  'assets/images/welcome.jpg',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              color: Colors.black.withOpacity(0.2),
              width: double.infinity,
              height: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 60,
                    width: 230,
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        TextWidget(
                            textSize: 30,
                            isTitle: true,
                            title: "Grocery",
                            color: Color(0xfff4a261)),
                        SizedBox(
                          width: 7,
                        ),
                        TextWidget(
                          textSize: 30,
                          isTitle: true,
                          title: "Shop",
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 250,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xfff4a261),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 40,
                          vertical: 12,
                        )),
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (context) => const BottomBarScreen()),
                      );
                    },
                    child: const TextWidget(
                      textSize: 22,
                      isTitle: true,
                      title: 'Get Start',
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const TextWidget(
                        textSize: 18,
                        title: "Don't have an Account?",
                        color: Colors.white,
                        isTitle: true,
                      ),
                      InkWell(
                        splashColor: mainColor,
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => SignUpScreen()));
                        },
                        child: const TextWidget(
                          title: 'Sign Up',
                          color: Colors.white,
                          textSize: 18,
                        ),
                      ),
                    ],
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
