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
              Text(comment.id.toString(), key:ValueKey('id$i'),),
              onTap: () => getAlertDialog('ID',  comment.id.toString()),
            ),
            DataCell(
              Text(comment.postId.toString(),key:ValueKey('post-id$i'),),
              onTap: () => getAlertDialog('Post-ID', comment.postId.toString()),
            ),
            DataCell(
              Text(comment.name,key:ValueKey('name$i'),),
              onTap: () => getAlertDialog('Name', comment.name),
            ),
            DataCell(
              Text(comment.email,key:ValueKey('email$i'),),
              onTap: () => getAlertDialog('Email', comment.email),
            ),
            DataCell(
              Text(comment.body,key:ValueKey('body$i'),),
              onTap: () => getAlertDialog('Body', comment.body),
            ),
          ],
        ),
      );
    }
  }

  List<DataRow> getDataRowList() {
    return dataRowComments;
  }

  dynamic getAlertDialog( String title,String content)  {
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
          key: ValueKey('AlertDialog-$title$content'),
          title: Text(title),
          content: Text(title+'-'+content),
          actions: [
            TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Dismiss")),
          ],
        ),
      );}
}
