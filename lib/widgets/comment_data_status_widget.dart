import 'package:flutter/material.dart';

class CommentDataStatusWidget extends StatelessWidget {
  const CommentDataStatusWidget({Key? key, required this.dataLocation})
      : super(key: key);

  final bool dataLocation;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Container(
          margin: const EdgeInsets.all(10),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
            color: dataLocation ? Colors.green : Colors.red,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            dataLocation ? 'Live Data' : 'Stored Data from DB',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
            ),
          ),
        )
      ],
    );
  }
}