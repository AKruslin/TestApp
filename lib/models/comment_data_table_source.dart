import 'package:flutter/material.dart';
import 'package:test_app/models/comment.dart';

class CommentDataTableRow {
  final List<Comment> comments;
  List<DataRow> dataRowComments = List.empty(growable: true);
  BuildContext context;

  CommentDataTableRow(this.comments, this.context) {
    for (var i = 0; i < comments.length; i++) {
      final Comment comment = comments[i];
      dataRowComments.add(
        DataRow(
          cells: [
            DataCell(
              Text(comment.id.toString()),
              onTap: () => getAlertDialog(comment.id.toString()),
            ),
            DataCell(
              Text(comment.postId.toString()),
              onTap: () => getAlertDialog(comment.postId.toString()),
            ),
            DataCell(
              Text(comment.name),
              onTap: () => getAlertDialog(comment.name),
            ),
            DataCell(
              Text(comment.email),
              onTap: () => getAlertDialog(comment.email),
            ),
            DataCell(
              Text(comment.body),
              onTap: () => getAlertDialog(comment.body),
            ),
          ],
        ),
      );
    }
  }

  List<DataRow> getDataRowList() {
    return dataRowComments;
  }

  dynamic getAlertDialog(String text) => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(text),
          actions: [
            TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Dismiss")),
          ],
        ),
      );
}
