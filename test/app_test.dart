import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:test_app/presentation/bloc/home_bloc.dart';
import 'package:test_app/data/models/comment.dart';
import 'package:test_app/data/models/comment_data_table_source.dart';
import 'package:test_app/presentation/widgets/comment_table_view.dart';

void main() {
  testWidgets('Open 20th data cell alert dialog', (widgetTester) async {
    ScrollController controller = ScrollController();
    List<Comment> comments = List.empty(growable: true);
    for (var i = 0; i < 50; i++) {
      comments.add(
        Comment(
            postId: i,
            id: i,
            name: "user$i",
            email: "email$i",
            body: "body$i"),
      );
    }

    await widgetTester.pumpWidget(
      MaterialApp(home: Scaffold(body: Builder(
        builder: (context) {
          CommentDataTableRow dataTableRow =
              CommentDataTableRow(comments, context);
          return CommetTableView(
            controller: controller,
            data: dataTableRow.dataRowComments,
          );
        },
      ))),
    );

    final listFinder = find.byKey(const ValueKey('commentDataList'));
    final itemFinder = find.byKey(const ValueKey('id20'));

    await widgetTester.drag(listFinder, const Offset(0, -600));
    await widgetTester.pumpAndSettle(const Duration(seconds: 1));
    await widgetTester.tap(itemFinder, pointer: 20);
    await widgetTester.pumpAndSettle(const Duration(seconds: 1));

    expect(find.byKey(const ValueKey('AlertDialog-ID20')), findsOneWidget);
    expect(find.text("ID-20"), findsOneWidget);
    expect(find.text("Dismiss"), findsOneWidget);
  });

  HomeBloc? bloc;
  setUp(() {
    bloc = HomeBloc();
  });

  tearDown(() {
    bloc?.close();
  });

  test("Check if first state of homeBloc is loading state", () {
    expect(
      bloc!.state,
      LoadingComments(),
    );
  });

  test("Check if isLive parameter is false on data that is loaded from DB", () {
    bloc!.emit(LoadedDatabaseComments(data: []));
    expect(
      bloc!.state.getDataLocation(),
      false,
    );
  });

  blocTest<HomeBloc, HomeState>("Check if load more actually loads more comments",
      build: () => HomeBloc(),
      act: (bloc) {
        for (var i = 0; i < 150; i++) {
          bloc.rowComments.add(DataRow(
            cells: [
              DataCell(
                Text('comment$i'),
              ),
            ],
          ));
        }
        bloc.add(LoadMoreData());
      },
      wait: const Duration(seconds: 2),
      verify: (bloc) {
        expect(bloc.endPointer, 100);
      });
}
