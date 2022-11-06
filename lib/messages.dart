import 'dart:ui';

import 'package:grouped_list/grouped_list.dart';
import 'package:flutter/material.dart';
import 'package:mush2/utils/colors.dart';

class M extends StatefulWidget {
  const M({Key? key}) : super(key: key);

  @override
  State<M> createState() => _MState();
}

class _MState extends State<M> {

  List<Message> message = [
    Message(
      text: 'Yes sure!',
      date: DateTime.now().subtract(Duration(minutes: 1)),
      isSentByMe: false,
    ),
    Message(text: 'Hey, are you on your way back?', date: DateTime.now().subtract(Duration(days: 3, minutes: 4),), isSentByMe: true),
  ].reversed.toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: bgColor,
        title: const Text('Messaging'),
      ),
      body: Column(
        children: [
          Expanded(
            child: GroupedListView<Message, DateTime>(
              padding: const EdgeInsets.all(8),
              reverse: true,
              order: GroupedListOrder.DESC,
              useStickyGroupSeparators: true,
              floatingHeader: true,
              // elements: messages, //originally
              elements: message,
              groupBy: (message) => DateTime(
                message.date.year,
                message.date.month,
                message.date.day,
              ),
              groupHeaderBuilder: (Message message) => SizedBox(
                height: 40,
                child: Card(
                  color: Theme.of(context).primaryColor,
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Text(
                      //DateFormat.yMMMd().format(message.date),
                      'Date',
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
              itemBuilder: (context, Message message) => Align(
                alignment: message.isSentByMe
                    ? Alignment.centerRight : Alignment.centerLeft,
                child: Card(
                  color: bgCard,
                  elevation: 8,
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Text(message.text),
                  ),
                ),
              ),
            ),
          ), //textfield moves to the bottom
          Container(
            color: bgCard,
            child: Container(
              color: Colors.grey.shade200,
              child: TextField(
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.all(12),
                  hintText: 'Type your message here...',
                ),
                onSubmitted: (text){
                  final message = Message(
                      text: text,
                      date: DateTime.now(),
                      isSentByMe: true
                  );

                  // setState(() => message.add(message));
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}


class Message extends StatefulWidget {
  final String text;
  final DateTime date;
  final bool isSentByMe;

  const Message({
    Key? key,
    required  this.text,
    required  this.date,
    required  this.isSentByMe,
  }) : super(key: key);

  @override
  State<Message> createState() => _MessageState();
}

class _MessageState extends State<Message> {

  List<Message> message = [
    Message(
      text: 'Yes sure!',
      date: DateTime.now().subtract(Duration(minutes: 1)),
      isSentByMe: false,
    ),
    Message(text: 'Hey, are you on your way back?', date: DateTime.now().subtract(Duration(days: 3, minutes: 4),), isSentByMe: true),
  ].reversed.toList();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat App'),
      ),
      body: Column(
        children: [
          Expanded(
              child: GroupedListView<Message, DateTime>(
                padding: const EdgeInsets.all(8),
                reverse: true,
                order: GroupedListOrder.DESC,
                useStickyGroupSeparators: true,
                floatingHeader: true,
                // elements: messages, //originally
                elements: message,
                groupBy: (message) => DateTime(
                  message.date.year,
                  message.date.month,
                  message.date.day,
                ),
                groupHeaderBuilder: (Message message) => SizedBox(
                  height: 40,
                  child: Card(
                    color: Theme.of(context).primaryColor,
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(
                        //DateFormat.yMMMd().format(message.date),
                        'Date',
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
                itemBuilder: (context, Message message) => Align(
                  alignment: message.isSentByMe
                  ? Alignment.centerRight : Alignment.centerLeft,
                  child: Card(
                    elevation: 8,
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Text(message.text),
                    ),
                  ),
                ),
              ),
          ), //textfield moves to the bottom
          Container(
            color: bgCard,
            child: Container(
              color: Colors.grey.shade200,
              child: TextField(
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.all(12),
                  hintText: 'Type your message here...',
                ),
                onSubmitted: (text){
                  final message = Message(
                      text: text,
                      date: DateTime.now(),
                      isSentByMe: true
                  );
                  // setState(() => message.add(message));
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}




