import 'package:barcode_scan2/barcode_scan2.dart';
import 'package:flutter/material.dart';

import '../../utils/constants.dart';

class ScanCommandsScreen extends StatefulWidget {
  const ScanCommandsScreen({Key? key}) : super(key: key);

  @override
  State<ScanCommandsScreen> createState() => _ScanCommandsScreenState();
}

class _ScanCommandsScreenState extends State<ScanCommandsScreen> {
  final _serverUriController = TextEditingController();

  @override
  void initState() {
    if (SERVER_URI != null && SERVER_URI!.isNotEmpty) {
      _serverUriController.text = SERVER_URI!;
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Prerequisites"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                width: 340,
                // height: 100,
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: _serverUriController,
                  decoration: const InputDecoration(
                    label: Text("Server URI | IP | URL"),
                    hintText: "10.0.0.22:3000 | https://test.com",
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(right: 3),
                child: IconButton(
                  onPressed: () async {
                    if (_serverUriController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            "Enter a URI",
                          ),
                          duration: Duration(seconds: 10),
                        ),
                      );
                      return;
                    }

                    await STORAGE.write(
                      key: "serverUri",
                      value: _serverUriController.text,
                    );

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          "URI Stored Successfully. Restart Application.",
                        ),
                        duration: Duration(seconds: 10),
                      ),
                    );
                  },
                  icon: const Icon(
                    Icons.save,
                    size: 30,
                  ),
                ),
              ),
            ],
          ),
          ListTile(
            title: const Text("AES Key"),
            leading: AES_KEY == null
                ? const Icon(Icons.cancel_rounded, color: Colors.red)
                : const Icon(Icons.check_sharp, color: Colors.green),
            trailing: IconButton(
              onPressed: () async {
                String scannedKey = await scanQr(context);

                if (scannedKey == 'NULL') {
                  return;
                }

                await STORAGE.delete(key: "aesKey");

                await STORAGE.write(
                  key: "aesKey",
                  value: scannedKey,
                );

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      "Key Stored Successfully. Restart Application.",
                    ),
                    duration: Duration(seconds: 10),
                  ),
                );
              },
              icon: const Icon(
                Icons.add_circle_outline,
              ),
            ),
          ),
          const Divider()
        ],
      ),
    );
  }

  Future<String> scanQr(BuildContext context) async {
    var result = await BarcodeScanner.scan();

    if (result.type == ResultType.Cancelled ||
        result.type == ResultType.Error) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "QR Not Scanned",
          ),
        ),
      );
      return 'NULL';
    }

    if (result.format != BarcodeFormat.qr) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Not a QR Code",
          ),
        ),
      );
      return 'NULL';
    }

    return result.rawContent;
  }
}
