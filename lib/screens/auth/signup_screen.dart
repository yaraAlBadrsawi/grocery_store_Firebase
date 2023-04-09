import 'package:flutter/material.dart';
import 'package:grocery_store/model/users_model.dart';
import 'package:grocery_store/screens/add_product.dart';
import 'package:grocery_store/screens/auth/login_screen.dart';
import 'package:grocery_store/screens/home_screen.dart';
import 'package:grocery_store/widget/text_widget.dart';
import 'package:iconly/iconly.dart';
import '../../constants.dart';
import '../../services/FirebaseAuthHelper.dart';
import '../../widget/auth/auth_text_from_field.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({Key? key}) : super(key: key);

  final _fromKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final controller = TextEditingController();

  performSignUp() {
    // TODO: check if data validation true

    if (_fromKey.currentState!.validate()) {
      FirebaseAuthHelper.firebaseAuthHelper.register(Users(
          email: _emailController.text,
          password: _passwordController.text,
          name: _nameController.text));
    } else {
      print('unexpected error ');
      return CircularProgressIndicator();
    }
  }

  checkData(String value) {
    if (!RegExp('').hasMatch(value)) {
      return false;
    } else {
      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          alignment: AlignmentDirectional.center,
          children: [
            SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: Opacity(
                opacity: 0.2,
                child: Image.asset(
                  'assets/images/welcome.jpg',
                  fit: BoxFit.fill,
                ),
              ),
            ),
            SingleChildScrollView(
              child: Column(children: [
                SizedBox(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height / 1.3,
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 25, right: 25, top: 40),
                    child: Form(
                      key: _fromKey,
                      child: Column(
                        children: [
                          Row(
                            children: const [
                              TextWidget(
                                textSize: 28,
                                isTitle: true,
                                title: "SIGN",
                                color: mainColor,
                              ),
                              SizedBox(
                                width: 3,
                              ),
                              TextWidget(
                                textSize: 28,
                                title: "UP",
                                color: Colors.black,
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 50,
                          ),
                          AuthTextFromField(
                            controller: _nameController,
                            obscureText: false,
                            validator: (value) {
                              // TODO: make function that do validation
                              // ruels :

                              // if (value.toString().length <= 2 ||
                              //     !RegExp("validationName").hasMatch(value)) {
                              //   return 'Enter valid name';
                              // } else {
                              //   return null;
                              // }
                            },
                            prefixIcon: const Icon(
                              IconlyLight.user,
                              color: mainColor,
                            ),
                            hintText: 'User Name',
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          AuthTextFromField(
                            // key: const Key(MyKeys.signUpEmail),
                            controller: _emailController,
                            obscureText: false,
                            validator: (value) => null,
                            prefixIcon: const Icon(
                              IconlyLight.message,
                              color: mainColor,
                            ),
                            suffixIcon: const Text(""),
                            hintText: 'Email',
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          AuthTextFromField(
                            // key: const Key(MyKeys.signUpEmail),
                            controller: _passwordController,
                            obscureText: false,
                            validator: (value) {
                              if (!RegExp('').hasMatch(value)) {
                                return 'Invalid password';
                              } else {
                                return null;
                              }
                            },
                            prefixIcon: const Icon(
                              IconlyLight.lock,
                              color: mainColor,
                            ),
                            suffixIcon: const Text(""),
                            hintText: 'Password',
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              Container(
                                alignment: Alignment.center,
                                height: 35,
                                width: 35,
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade200,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              const TextWidget(
                                title: '  I accept ',
                                textSize: 16,
                              ),
                              const Text(
                                'terms & conditions',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ],
                          ),
                          ElevatedButton(
                            onPressed: () {
                              if (_fromKey.currentState!.validate()) {
                                FirebaseAuthHelper.firebaseAuthHelper.register(
                                    Users(
                                        email: _emailController.text,
                                        password: _passwordController.text,
                                        name: _nameController.text));
                              } else {
                                print('error ');
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: mainColor,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 125, vertical: 14),
                            ),
                            child: const TextWidget(
                              title: "Sign up",
                              textSize: 16,
                              isTitle: true,
                            ),
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: TextButton(
                              onPressed: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(builder: (_) {
                                    return LoginScreen();
                                  }),
                                );
                              },
                              child: const TextWidget(
                                title: 'Already have an Account? ',
                                color: Colors.black,
                                textSize: 16,
                                isTitle: true,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
