import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/presentation/bloc/home_bloc.dart';

class ErrorStateWidget extends StatelessWidget {
  const ErrorStateWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
}

