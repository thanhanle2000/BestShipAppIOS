import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/conect_bloc.dart';
import 'bloc/conect_state.dart';

class ConectOffPage extends StatefulWidget {
  const ConectOffPage({Key? key}) : super(key: key);

  @override
  State<ConectOffPage> createState() => _ConectOffPageState();
}

class _ConectOffPageState extends State<ConectOffPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: BlocBuilder<ConectBloc, ConectState>(
          builder: (context, state) {
            if (state is NetworkFailure) {
              return const Text("No Internet Connection");
            } else if (state is NetworkSuccess) {
              return const Text("You're Connected to Internet");
            } else {
              return const SizedBox.shrink();
            }
          },
        ),
      ),
    );
  }
}
