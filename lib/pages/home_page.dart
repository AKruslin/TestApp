import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/bloc/home_bloc.dart';
import 'package:test_app/models/comment_data_table_source.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ScrollController controller = ScrollController();
  late CommentDataTableRow commentRowList;
  late List<DataRow> paginatedList;
  @override
  void initState() {
    BlocProvider.of<HomeBloc>(context).add(LoadData(context: context));
    super.initState();
    controller.addListener(() {
      if (controller.position.pixels >
          controller.position.maxScrollExtent - 100) {
        BlocProvider.of<HomeBloc>(context).add(LoadMoreData());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            if ((state is LoadedNetworkComments) ||
                (state is LoadedDatabaseComments)) {
              paginatedList = state.getData();
              return SizedBox(
                height: MediaQuery.of(context).size.height,
                child: Column(children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        decoration: BoxDecoration(
                          color: state.getDataLocation()
                              ? Colors.green
                              : Colors.red,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                            state.getDataLocation()
                                ? 'Live Data'
                                : 'Stored Data from DB',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                            )),
                      )
                    ],
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: RefreshIndicator(
                      onRefresh: () async {
                        BlocProvider.of<HomeBloc>(context)
                            .add(LoadData(context: context));
                      },
                      child: CommetTableView(
                          controller: controller, data: state.getData()),
                    ),
                  ),
                ]),
              );
            }
            if (state is LoadingComments) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is ErrorWhileLoading) {
              return SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Something went wrong, check your network and try again.",
                      textAlign: TextAlign.center,
                    ),
                    ElevatedButton(
                      onPressed: () => BlocProvider.of<HomeBloc>(context)
                          .add(LoadData(context: context)),
                      child: const Text("Try again"),
                    ),
                  ],
                ),
              );
            }
            return const Center(child: Text("Uncought error"));
          },
        ),
      ),
    );
  }
}

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
