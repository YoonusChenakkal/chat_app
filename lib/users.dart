import 'package:chat_app/chat.dart';
import 'package:chat_app/d.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/main.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Users extends StatefulWidget {
  Users({required this.userList, super.key});
  List<String> userList;
 
  @override
  State<Users> createState() => _UsersState();
}

class _UsersState extends State<Users> {
 
     
   

  setList(List<String> list) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setStringList('items', list);
  }

  @override
  Widget build(BuildContext context) {
   
    return ListView.builder(
      itemCount: widget.userList.length,
      itemBuilder: (context, index) {
        return Column(
          children: [
            ListTile(
              contentPadding: EdgeInsets.only(
                left: 40,
                right: 40,
              ),
              leading: Icon(Icons.person_2_outlined),
              trailing: IconButton(
                  onPressed: () {
                    setState(() {
                      widget.userList.removeAt(index);
                      setList(widget.userList);
                    });
                  },
                  icon: Icon(Icons.delete_outline_rounded)),
              title: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  widget.userList[index],
                  style: TextStyle(fontSize: 20),
                ),
              ),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          Chat(users: widget.userList, index: index),
                    ));
              },
            ),
            SizedBox(
              height: 6,
            )
          ],
        );
      },
    );
  }
}
