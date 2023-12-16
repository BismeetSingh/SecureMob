import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/commands_execution_bloc.dart';
import '../../models/display_command_model.dart';
import '../screens/display_command_output.dart';

class DisplayCommandWidget extends StatelessWidget {
  final DisplayCommandModel commandObject;

  const DisplayCommandWidget({
    Key? key,
    required this.commandObject,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CommandsExecutionBloc, CommandsExecutionState>(
      builder: ((context, state) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            GestureDetector(
              onTap: () async {
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (_, __, ___) => DisplayCommandOutputScreen(
                      commandId: commandObject.id,
                    ),
                    transitionDuration: const Duration(seconds: 2),
                    transitionsBuilder: (_, a, __, c) =>
                        FadeTransition(opacity: a, child: c),
                  ),
                );
              },
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 60,
                child: Card(
                  elevation: 0,
                  child: Center(
                    child: Text(commandObject.title),
                  ),
                ),
              ),
            ),
            const Divider(
              color: Colors.black,
              thickness: 1.5,
            ),
          ],
        );
      }),
    );
  }
}
