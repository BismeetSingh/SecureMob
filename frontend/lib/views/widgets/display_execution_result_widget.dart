import 'package:flutter/material.dart';
import 'package:SecureXccess/models/command_execution_result_model.dart';

class DisplayExecutionResultWidget extends StatelessWidget {
  final CommandExecutionResultModel result;

  const DisplayExecutionResultWidget({
    Key? key,
    required this.result,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 3, 8, 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "HTTP Status: ${result.httpStatusCode}",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: result.httpStatusCode[0] == "2"
                          ? Colors.green
                          : Colors.red,
                    ),
                  ),
                  Text(
                    "API Status: ${result.apiStatusCode}",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: result.apiStatusCode == "1"
                          ? Colors.green
                          : Colors.red,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              color: Colors.black,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  result.executionResult.toString(),
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
