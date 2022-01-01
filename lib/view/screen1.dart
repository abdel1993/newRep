import 'package:flutter/material.dart';

class Screen1 extends StatelessWidget {
  Screen1(
      {Key? key,
      required this.author,
      required this.description,
      required this.image,
      required this.content})
      : super(key: key);

  String author;
  String description;
  String image;
  String content;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(author),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(padding: EdgeInsets.all(16), child: Text(description)),
          const SizedBox(
            height: 20,
          ),
          Image.network(
            image,
            width: 500,
            height: 300,
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(padding: EdgeInsets.all(16), child: Text(description)),
        ],
      ),
    );
  }
}
