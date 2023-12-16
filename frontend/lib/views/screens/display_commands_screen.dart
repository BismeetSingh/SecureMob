import 'dart:math';

import 'package:SecureXccess/models/display_command_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:SecureXccess/views/screens/prerequisites_screen.dart';

import '../../blocs/commands_display_bloc.dart';
import '../../controllers/repositories/commands_repository.dart';
import '../widgets/display_command_widget.dart';

class DisplayCommandsScreen extends StatefulWidget {
  const DisplayCommandsScreen({Key? key}) : super(key: key);

  @override
  _DisplayCommandsScreenState createState() => _DisplayCommandsScreenState();
}

class _DisplayCommandsScreenState extends State<DisplayCommandsScreen> {
  TextEditingController editingController = TextEditingController();
  List<DisplayCommandModel> _searchResults = [];
  List<DisplayCommandModel>  apiResults = [];





  @override
  Widget build(BuildContext context) {
    TextEditingController controller = new TextEditingController();

    void onSearchTextChanged(String text) async {
      _searchResults.clear();


      if (text.isEmpty) {
        setState(() {

        });
        return;
      }
    }

    return BlocProvider(
      create: (context) => CommandsBloc(
        RepositoryProvider.of<CommandsRepository>(context),
      )..add(FetchCommandsEvent()),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(


            title: const Text("Available Commands"),

            leading: IconButton(
              icon: const Icon(Icons.qr_code_scanner),
              onPressed: () {
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (_, __, ___) => const ScanCommandsScreen(),
                    transitionDuration: const Duration(seconds: 2),
                    transitionsBuilder: (_, a, __, c) =>
                        FadeTransition(opacity: a, child: c),
                  ),
                );
              },
            ),
          ),
          body: BlocBuilder<CommandsBloc, CommandsState>(
              builder: (context, state) {
            if (state is CommandsLoadingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (state is CommandsLoadingFailedState) {
              return Text(state.error);
            }

            if (state is CommandsLoadedState) {
              if (state.commands.isEmpty) {
                return const Text("No Commands Found");
              }


              return Column(
                children: [
                  Container(
                    color: Theme.of(context).primaryColor,
                    child:  Padding(padding: EdgeInsets.all(8.0),
                    child: Card(
                child: ListTile(
                leading: const Icon(Icons.search),
                title: TextField(
                // controller: controller,
                decoration: const InputDecoration(
                hintText: 'Search', border: InputBorder.none),
//                 onChanged: (value){
// print("LOOK");
// print(value);
//                   if (value.isEmpty) {
//
//                     setState(() {
//                       _searchResults.addAll(apiResults);
//                     });
//                   }
//                   else{
//
// // print("in else");
//                     setState(() {
//
//                       var a = <DisplayCommandModel>[];
//                       print(_searchResults);
//                       for (var e in state.commands) {
//                         print(e);
//                         if(e.title.toLowerCase().contains(value.toLowerCase())){
//                           a.add(e);
//                         }
//                       }
//                       print("AAA");
//                       print(a);
//                       _searchResults.clear();
//                       _searchResults = a;
//
//                     });
//
//                   }
//
//
//                 }


                ),trailing: IconButton(icon: new Icon(Icons.cancel), onPressed: () {
                controller.clear();
                // setState(() {
                //   _searchResults=state.commands;
                // });

                onSearchTextChanged('');
                },),
                    ),),

                  ))
                ,
               Expanded(child:ListView.builder(

                itemBuilder: (_, i) {
                  // if (!_searchResults.contains(state.commands[i])){
                  //   _searchResults.add(state.commands[i]);
                  //   apiResults.add(state.commands[i]);
                  // }


                  return DisplayCommandWidget(

                    commandObject: state.commands[i],
                  );
                },
                itemCount: state.commands.length,
              ))]);
            }

            return const Text("Undefined/Unhandled State Occurred");
          }),
        ),
      ),
    );
  }
}


