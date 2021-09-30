import 'package:flutter/material.dart';

class CommetTableView extends StatelessWidget {
  const CommetTableView({
    Key? key,
    required this.controller,
    required this.data,
  }) : super(key: key);

  final ScrollController controller;
  final List<DataRow> data;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      scrollDirection: Axis.horizontal,
      
      slivers: [
        SliverToBoxAdapter(
          child: SingleChildScrollView(
            key: const ValueKey("commentDataList"),
            controller: controller,
            child: DataTable(
              columns: const [
                DataColumn(label: Text("id")),
                DataColumn(label: Text("Post id")),
                DataColumn(label: Text("Name")),
                DataColumn(label: Text("Email")),
                DataColumn(label: Text("Body")),
              ],
              rows: data,
            ),
          ),
        ),
      ],
    );
  }
}
