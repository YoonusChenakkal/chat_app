import 'package:chat_app/firebase_options.dart';
import 'package:chat_app/users.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: loginPage());
  }
}

class loginPage extends StatefulWidget {
  loginPage({super.key});

  @override
  State<loginPage> createState() => _loginPageState();
}

class _loginPageState extends State<loginPage> {
  TextEditingController username = TextEditingController();
  List<String> _userList = [];

  @override
  void initState() {
    super.initState();
    _getList();
   
    ();
  }

 
  // set list items from shared preferences
  setList() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setStringList('items', _userList);
  }

  // get list items from shared preferences

  _getList() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<String>? items = prefs.getStringList('items');
    if (items != null) {
      setState(() {
        _userList = items;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 200,
            ),
            // Title
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.chat_outlined, size: 30, weight: 2),
                SizedBox(width: 10),
                Text(
                  'Add Person',
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.w300),
                )
              ],
            ),
            SizedBox(
              height: 20,
            ),

            // Text Field

            Container(
              height: 50,
              padding: EdgeInsets.only(left: 50, right: 50),
              child: TextField(
                controller: username,
                onSubmitted:
                    (value) => // Close the keyboard when the user submits
                        FocusScope.of(context).unfocus(),
                decoration: InputDecoration(
                    hintText: 'Add Person to the Chat',
                    hintStyle: TextStyle(fontSize: 14),
                    alignLabelWithHint: true,
                    contentPadding: EdgeInsets.all(10),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12))),
              ),
            ),
            SizedBox(
              height: 20,
            ),

            //button

            SizedBox(
              width: 130,
              child: ElevatedButton(
                  onPressed: () async {
                    if (username.text.isNotEmpty) {
                      setState(() {
                        _userList.add(username.text);
                        username.text = '';
                      });
                      await setList(); // Wait for setList() to complete
                      await _getList(); // Retrieve the updated list
                      FocusScope.of(context).unfocus();
                    }
                  },
                  child: Text(
                    'Enter',
                    style: TextStyle(color: Colors.black),
                  ),
                  style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      backgroundColor: MaterialStatePropertyAll(
                          Color.fromARGB(255, 255, 255, 255)))),
            ),
            SizedBox(
              height: 30,
            ),

            // Added Users

            Expanded(child: Users(userList: _userList))
          ],
        ),
      ),
    );
  }
}
