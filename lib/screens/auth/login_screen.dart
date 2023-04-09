import 'package:flutter/material.dart';
import 'package:grocery_store/screens/auth/signup_screen.dart';
import 'package:grocery_store/storage/shared_preferences_controller.dart';
import 'package:iconly/iconly.dart';

import '../../admin/dashBoard_screen.dart';
import '../../constants.dart';
import '../../model/users_model.dart';
import '../../services/FirebaseAuthHelper.dart';
import '../../widget/auth/auth_text_from_field.dart';
import '../../widget/auth/container_under.dart';
import '../../widget/text_widget.dart';
import '../home_screen.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _fromKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final controller = TextEditingController();

  @override
  void initState() {
    SharedPreferencesController.getInstance;
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _nameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: _fromKey,
        body: Stack(alignment: AlignmentDirectional.center, children: [
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
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 22, vertical: 55.0),
                  child: Row(
                    children: const [
                      TextWidget(
                          textSize: 28,
                          isTitle: true,
                          title: "LOG",
                          color: mainColor),
                      SizedBox(
                        width: 3,
                      ),
                      TextWidget(
                        textSize: 28,
                        isTitle: true,
                        title: "IN",
                        color: Colors.black,
                      ),
                    ],
                  ),
                ),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: AuthTextFromField(
                        // key: const Key('MyKeys.signInEmail'),
                        controller: _emailController,
                        obscureText: false,
                        validator: (value) {
                          if (!RegExp("validationEmail").hasMatch(value)) {
                            return 'Invalid email';
                          } else {
                            return null;
                          }
                        },
                        prefixIcon:
                            const Icon(IconlyBold.user_2, color: mainColor),
                        hintText: 'Email',
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 18.0, vertical: 0),
                      child: AuthTextFromField(
                        // key: const Key('MyKeys.signInEmail'),
                        controller: _passwordController,
                        obscureText: false,
                        validator: (value) {
                          if (!RegExp("validationEmail").hasMatch(value)) {
                            return 'Invalid password';
                          } else {
                            return null;
                          }
                        },
                        prefixIcon: const Icon(
                          IconlyBold.lock,
                          color: Color(0xfff4a261),
                        ),
                        hintText: 'Password',
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {},
                        child: const TextWidget(
                          title: 'Forgot Password?',
                          textSize: 14,
                          color: Colors.black,
                          isTitle: true,
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        // if (_fromKey.currentState!.validate()) {
                        if (_emailController.text == 'admin@mail.com' &&
                            _passwordController.text == '123456') {
                          FirebaseAuthHelper.firebaseAuthHelper.login(Users(
                            email: _emailController.text,
                            password: _passwordController.text,
                          ));
                          Navigator.push(context,
                              MaterialPageRoute(builder: (_) {
                            return DashBoardScreen();
                          }));
                        } else {
                          FirebaseAuthHelper.firebaseAuthHelper.login(Users(
                            email: _emailController.text,
                            password: _passwordController.text,
                          ));
                          Navigator.push(context,
                              MaterialPageRoute(builder: (_) {
                            return HomeScreen();
                          }));
                        }
                        //   else {
                        //   print('error ');
                        // }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color(0xff000000).withOpacity(0.8),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 130, vertical: 14),
                      ),
                      child: TextWidget(
                          title: 'log in'.toUpperCase(),
                          textSize: 20,
                          color: Colors.white,
                          isTitle: true),
                    )
                  ],
                ),
                const SizedBox(
                  height: 130,
                ),
                ContainerUnder(
                  text: "Don't have an Account? ",
                  textType: "Sign up",
                  onPressed: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return SignUpScreen();
                    }));
                  },
                  color: const Color(0xfff4a261),
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
