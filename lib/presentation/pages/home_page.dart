import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/presentation/bloc/home_bloc.dart';
import 'package:test_app/data/models/comment_data_table_source.dart';
import 'package:test_app/presentation/widgets/comment_data_status_widget.dart';
import 'package:test_app/presentation/widgets/comment_table_view.dart';
import 'package:test_app/presentation/widgets/error_state_widget.dart';

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
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
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
                  CommentDataStatusWidget(
                    dataLocation: state.getDataLocation(),
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: CommetTableView(
                        controller: controller, data: state.getData()),
                  )
                ]),
              );
            }
            if (state is LoadingComments) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is ErrorWhileLoading) {
              return const ErrorStateWidget();
            }
            return const Center(child: Text("Uncaught error"));
          },
        ),
      ),
    );
  }
}
