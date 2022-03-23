import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/presentation/bloc/home_bloc.dart';

class CommetTableView extends StatefulWidget {
  const CommetTableView({
    Key? key,
    required this.controller,
    required this.data,
  }) : super(key: key);

  final ScrollController controller;
  final List<DataRow> data;

  @override
  State<CommetTableView> createState() => _CommetTableViewState();
}

class _CommetTableViewState extends State<CommetTableView> {
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        BlocProvider.of<HomeBloc>(context).add(LoadData(context: context));
      },
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        key: const ValueKey("commentDataList"),
        controller: widget.controller,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            columns: const [
              DataColumn(label: Text("id")),
              DataColumn(label: Text("Post id")),
              DataColumn(label: Text("Name")),
              DataColumn(label: Text("Email")),
              DataColumn(label: Text("Body")),
            ],
            rows: widget.data,
          ),
        ),
      ),
    );
  }
}
