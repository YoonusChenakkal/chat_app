import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Chat extends StatefulWidget {
  Chat({required this.users, required this.index, super.key});
  List<String> users = [];
  int index;

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  bool checkUser = false;

  String messageContent = '';
  String fo_date = '';
  String fo_time = '';

  TextEditingController messageController = TextEditingController();

  final CollectionReference chat =
      FirebaseFirestore.instance.collection('chat');

  sendMessage(BuildContext context) {
    _updateTime();
    String user = widget.users[widget.index];
    final data = {
      'message': messageContent,
      'user': user,
      'createdAt': Timestamp.now(),
      'time': fo_time
    };
    if (messageContent != '') {
      chat.add(data);
      messageContent = '';
      messageController.clear();
      FocusScope.of(context).unfocus();
    }
  }

  deleteMessage(docId) {
    chat.doc(docId).delete();
  }

  _updateTime() {
    setState(() {
      fo_date = DateFormat("MMMM, dd").format(DateTime.now());
      fo_time = DateFormat("hh:mm a").format(DateTime.now());
    });
  }

  @override
  Widget build(BuildContext context) {
    print(fo_time);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.users[widget.index]),
      ),
      body: ListView(
        physics: ScrollPhysics(parent: NeverScrollableScrollPhysics()),
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height / 1.22,
            width: MediaQuery.of(context).size.width,
            child: StreamBuilder<QuerySnapshot>(
              stream: chat.orderBy('createdAt', descending: true).snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(
                    child: Text('Error: ${snapshot.error}'),
                  );
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }

                final List<QueryDocumentSnapshot> documents =
                    snapshot.data!.docs;

                return ListView.builder(
                  reverse: true,
                  padding: EdgeInsets.symmetric(vertical: 30),
                  itemCount: documents.length,
                  itemBuilder: (context, index) {
                    final DocumentSnapshot chatSnap = documents[index];

                    return Row(
                      mainAxisAlignment:
                          chatSnap['user'] == widget.users[widget.index]
                              ? MainAxisAlignment.end
                              : MainAxisAlignment.start,
                      children: [
                        InkWell(
                          onLongPress: () {
                            deleteMessage(chatSnap.id);
                          },
                          child: Container(
                            constraints: BoxConstraints(
                                minWidth: 100,
                                maxWidth:
                                    MediaQuery.of(context).size.width / 1.5),
                            margin: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 20),
                            padding: EdgeInsets.all(15),
                            decoration: chatSnap['user'] ==
                                    widget.users[widget.index]
                                ? BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(30),
                                      topRight: Radius.circular(25),
                                      bottomLeft: Radius.circular(30),
                                    ),
                                    color: Color.fromARGB(146, 214, 223, 255),
                                  )
                                : BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(30),
                                      topRight: Radius.circular(25),
                                      bottomRight: Radius.circular(30),
                                    ),
                                    color: Color.fromARGB(146, 109, 184, 255),
                                  ),
                            child: Stack(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      chatSnap['user'],
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: chatSnap['user'] ==
                                                widget.users[widget.index]
                                            ? Color.fromARGB(255, 13, 213, 136)
                                            : Color.fromARGB(255, 148, 5, 126),
                                      ),
                                    ),
                                    Text(
                                      chatSnap['message'],
                                      style: TextStyle(
                                        fontSize: 16,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 12,
                                    )
                                  ],
                                ),
                                Positioned(
                                    bottom: 0,
                                    right: 0,
                                    child: Text(
                                      chatSnap['time'],
                                      style: TextStyle(
                                          fontSize: 9, color: Colors.grey[600]),
                                    ))
                              ],
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ),
          Row(
            children: [
              Container(
                padding: EdgeInsets.only(left: 15),
                width: MediaQuery.of(context).size.width / 1.2,
                child: TextField(
                  controller: messageController,
                  onSubmitted: (value) {
                    // Close the keyboard when the user submits
                    FocusScope.of(context).unfocus();
                  },
                  onChanged: (value) {
                    messageContent = value;
                  },
                  decoration: InputDecoration(
                      hintText: 'Type Something...',
                      hintStyle: TextStyle(fontSize: 14),
                      alignLabelWithHint: true,
                      contentPadding: EdgeInsets.all(10),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12))),
                ),
              ),
              GestureDetector(
                onTap: () {
                  sendMessage(context);
                },
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 12),
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(),
                  ),
                  child: Icon(
                    Icons.send_outlined,
                    size: 29,
                  ),
                ),
              )
            ],
          ),
          SizedBox(
            height: 15,
          )
        ],
      ),
    );
  }
}
