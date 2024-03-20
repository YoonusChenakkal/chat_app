import 'package:flutter/material.dart';

class d extends StatelessWidget {
  const d({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(children: [SizedBox(height: 60,),
          Row(mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(   margin:
                              EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                          padding: EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30),
                              topRight: Radius.circular(25),
                              bottomLeft: Radius.circular(30),
                            ),
                            color: Color.fromARGB(147, 133, 156, 238),
                          ),
               child: Text('yoonus hi'),
              ),
            ],
          ),
           Row(mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(   margin:
                              EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                          padding: EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30),
                              topRight: Radius.circular(25),
                              bottomLeft: Radius.circular(30),
                            ),
                            color: Color.fromARGB(147, 133, 156, 238),
                          ),
               child: Text('yoonus hi'),
              ),
            ],
          ), Row(mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(   margin:
                              EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                          padding: EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30),
                              topRight: Radius.circular(25),
                              bottomLeft: Radius.circular(30),
                            ),
                            color: Color.fromARGB(147, 133, 156, 238),
                          ),
               child: Text('yoonus hi'),
              ),
            ],
          ),
           Row(mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(   margin:
                              EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                          padding: EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30),
                              topRight: Radius.circular(25),
                              bottomLeft: Radius.circular(30),
                            ),
                            color: Color.fromARGB(147, 133, 156, 238),
                          ),
               child: Text('yoonus hi'),
              ),
            ],
          )
        ],),
      ),
    );
  }
}