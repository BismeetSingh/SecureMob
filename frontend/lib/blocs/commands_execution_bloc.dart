//This Bloc facilitates sending command execution request and displaying the result

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../controllers/repositories/commands_repository.dart';
import '../models/command_execution_result_model.dart';

//------------------------Start: Equatables------------------------
abstract class CommandsExecutionEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

abstract class CommandsExecutionState extends Equatable {
  @override
  List<Object?> get props => [];
}

//------------------------End: Equatables------------------------

//------------------------Start: Events------------------------
class ExecuteCommandsEvent extends CommandsExecutionEvent {
  final String commandId;

  ExecuteCommandsEvent(this.commandId);

  @override
  List<Object> get props => [commandId];
}

//------------------------End: Events------------------------

//------------------------Start: States------------------------

//========================Start: Commands Execution States====================
class CommandsNotExecutedState extends CommandsExecutionState {}

class CommandsExecutingState extends CommandsExecutionState {}

class CommandsExecutedState extends CommandsExecutionState {
  final CommandExecutionResultModel executionResult;

  CommandsExecutedState(this.executionResult);

  @override
  List<Object> get props => [executionResult];
}

class CommandsExecutionFailedState extends CommandsExecutionState {
  final CommandExecutionResultModel error;

  CommandsExecutionFailedState(this.error);

  @override
  List<Object> get props => [error];
}
//========================End: Commands Execution States====================

//------------------------End: States------------------------

//Bloc
class CommandsExecutionBloc
    extends Bloc<CommandsExecutionEvent, CommandsExecutionState> {
  final CommandsRepository _commandsRepository;

  CommandsExecutionBloc(this._commandsRepository)
      : super(CommandsExecutingState()) {
    //Executes Command
    on<ExecuteCommandsEvent>((event, emit) async {
      emit(CommandsExecutingState());

      var executionResult;

      try {
        executionResult =
            await _commandsRepository.executeCommand(event.commandId);
        emit(
          CommandsExecutedState(
            CommandExecutionResultModel(
              executionResult: executionResult['executionResult']!,
              apiStatusCode: executionResult['apiStatusCode']!,
              httpStatusCode: executionResult['httpStatusCode']!,
            ),
          ),
        );
      } catch (e, s) {
        debugPrint(e.toString());
        debugPrint(s.toString());
        emit(
          CommandsExecutionFailedState(
            CommandExecutionResultModel(
              executionResult: e.toString(),
              apiStatusCode: "0",
              httpStatusCode: "200",
            ),
          ),
        );
      }
    });
  }
}
