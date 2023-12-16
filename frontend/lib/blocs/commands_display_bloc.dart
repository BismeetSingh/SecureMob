//This Bloc facilitates fetching and displaying commands from API onto screen
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:SecureXccess/controllers/repositories/commands_repository.dart';
import 'package:SecureXccess/models/display_command_model.dart';

//------------------------Start: Equatables------------------------
abstract class CommandsEvent extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

abstract class CommandsSearchEvent extends Equatable {
  List<Object?> get props => [];
}

abstract class CommandsState extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

//------------------------End: Equatables------------------------

//------------------------Start: Events------------------------

class FetchCommandsEvent extends CommandsEvent {}

//------------------------End: Events------------------------

//------------------------Start: States------------------------

//========================Start: Commands Loading States=======================
class CommandsNotLoadedState extends CommandsState {}

class CommandsLoadingState extends CommandsState {}

class CommandsLoadingFailedState extends CommandsState {
  final String error;

  CommandsLoadingFailedState(this.error);

  @override
  List<Object> get props => [error];
}

class CommandsLoadedState extends CommandsState {
  final List<DisplayCommandModel> commands;

  CommandsLoadedState(this.commands);

  @override
  List<Object> get props => [commands];
}
//========================End: Commands Loading States=======================

//------------------------End: States------------------------

//Bloc
class CommandsBloc extends Bloc<CommandsEvent, CommandsState> {
  final CommandsRepository _commandsRepository;

  CommandsBloc(this._commandsRepository) : super(CommandsLoadingState()) {
    //When FetchCommandsEvent is triggered, it calls API and gets commands from it
    on<FetchCommandsEvent>((event, emit) async {
      emit(CommandsLoadingState());

      try {
        final commands = await _commandsRepository.getCommandsFromAPI();
        emit(CommandsLoadedState(commands));
      } catch (e, s) {
        debugPrint(e.toString());
        debugPrint(s.toString());
        emit(CommandsLoadingFailedState(e.toString()));
      }
    });
  }
}


