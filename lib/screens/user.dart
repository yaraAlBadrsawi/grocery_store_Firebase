import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

import '../widget/list_tile_widget.dart';
import '../widget/text_widget.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({Key? key}) : super(key: key);

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  List titles = [
    'Address',
    'Order',
    'wishlist',
    'Viewed',
    'Forget Password',
    'Logout'
  ];

  onPressed() {}

  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                text: TextSpan(
                  text: ' Hi,  ',
                  style: TextStyle(
                      fontSize: 27,
                      color: Colors.blue,
                      fontWeight: FontWeight.bold),
                  children: [
                    TextSpan(
                        text: 'My name',
                        style: TextStyle(
                            fontSize: 25,
                            color: Colors.black,
                            fontWeight: FontWeight.w600),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            print('my name is pressed');
                          }),
                  ],
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              TextWidget(
                title: '  Emai@email.com',
                textSize: 18,
              ),
              const SizedBox(
                height: 20,
              ),
              Divider(
                thickness: 2,
              ),
              SizedBox(
                height: 20,
              ),
              ListTileWidget(
                TextWidget(
                  title: titles[0],
                  isTitle: true,
                  textSize: 24,
                ),
                IconlyLight.profile,
                () {
                  _showAddressDialog();
                },
                subtitle: 'subtitle here',
              ),
              ListTileWidget(
                TextWidget(
                  title: titles[1],
                  isTitle: true,
                  textSize: 24,
                ),
                IconlyLight.bag,
                onPressed,
              ),
              ListTileWidget(
                TextWidget(
                  title: titles[2],
                  isTitle: true,
                  textSize: 24,
                ),
                IconlyLight.heart,
                onPressed,
              ),
              ListTileWidget(
                TextWidget(
                  title: titles[3],
                  isTitle: true,
                  textSize: 24,
                ),
                IconlyLight.show,
                onPressed,
              ),
              ListTileWidget(
                TextWidget(
                  title: titles[4],
                  isTitle: true,
                  textSize: 24,
                ),
                IconlyLight.lock,
                onPressed,
              ),
              ListTileWidget(
                  TextWidget(
                    title: titles[5],
                    isTitle: true,
                    textSize: 24,
                  ),
                  IconlyLight.logout,
                  () => _showLogOutDialog()),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _showAddressDialog() async {
    await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Update"),
            content: TextField(
              onChanged: (value) {
                print(_controller.text);
              },
              controller: _controller,
              maxLines: 5,
              decoration: InputDecoration(hintText: 'your Address'),
            ),
            actions: [
              TextButton(onPressed: () {}, child: const Text('update'))
            ],
          );
        });
  }

  Future<void> _showLogOutDialog() async {
    await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Row(
              children: [
                Image.asset(
                  'assets/images/log_out.png',
                  fit: BoxFit.fill,
                  height: 20,
                  width: 20,
                ),
                const Padding(
                  padding: EdgeInsets.all(12.0),
                  child: Text('Sign out'),
                ),
              ],
            ),
            content: const Text("Do you want log out ? "),
            actions: [
              TextButton(
                onPressed: () {
                  if (Navigator.canPop(context)) {
                    Navigator.pop(context);
                  }
                },
                child: const TextWidget(
                  title: 'Cancel',
                  textSize: 18,
                  color: Colors.blue,
                ),
              ),
              TextWidget(
                title: 'Ok',
                textSize: 18,
                color: Colors.red,
              ),
            ],
          );
        });
  }
}
