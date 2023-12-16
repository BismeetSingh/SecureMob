import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:SecureXccess/views/widgets/display_execution_result_widget.dart';

import '../../blocs/commands_execution_bloc.dart';

class DisplayCommandOutputScreen extends StatelessWidget {
  const DisplayCommandOutputScreen({Key? key, required this.commandId})
      : super(key: key);

  final String commandId;

  @override
  Widget build(BuildContext context) {
    context.read<CommandsExecutionBloc>().add(ExecuteCommandsEvent(commandId));

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Execution Result"),
        ),
        body: BlocBuilder<CommandsExecutionBloc, CommandsExecutionState>(
          builder: (context, state) {
            if (state is CommandsExecutingState) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is CommandsExecutionFailedState) {
              return DisplayExecutionResultWidget(
                result: state.error,
              );
            }

            if (state is CommandsExecutedState) {
              return DisplayExecutionResultWidget(
                  result: state.executionResult);
            }

            return const Text("Unknown/Unhandled State Occurred");
          },
        ),
      ),
    );
  }
}
