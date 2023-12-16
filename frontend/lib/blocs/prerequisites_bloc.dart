//This Bloc facilitates the handling of prerequisites for app functioning which are:
//AES Key
//Server URI
import 'package:barcode_scan2/barcode_scan2.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

//------------------------Start: Equatables------------------------
abstract class PrerequisitesEvent extends Equatable {
  // TODO: implement props
  @override
  List<Object?> get props => [];
}

abstract class PrerequisitesState extends Equatable {
  // TODO: implement props
  @override
  List<Object?> get props => [];
}

//------------------------End: Equatables------------------------

//------------------------Start: Events------------------------
class ScanKeyEvent extends PrerequisitesEvent {}
//------------------------End: Events------------------------

//------------------------Start: States------------------------

//========================Start: Key Scanning States====================

class KeyNotPresentState extends PrerequisitesState {}

class KeyScanningState extends PrerequisitesState {}

class KeyScanningFailed extends PrerequisitesState {
  final String error;

  KeyScanningFailed(this.error);

  @override
  List<Object> get props => [error];
}

class KeyScanningSuccessful extends PrerequisitesState {
  final String scannedData;

  KeyScanningSuccessful(this.scannedData);

  @override
  List<Object> get props => [scannedData];
}

//========================End: Key Scanning States====================

//Bloc
class PrerequisitesBloc extends Bloc<PrerequisitesEvent, PrerequisitesState> {
  PrerequisitesBloc() : super(KeyScanningState()) {
    //Scans Key from QR
    on<ScanKeyEvent>((event, emit) async {
      emit(KeyScanningState());

      var scanningResult = await BarcodeScanner.scan();

      if (scanningResult.type == ResultType.Cancelled ||
          scanningResult.type == ResultType.Error) {
        emit(KeyScanningFailed("QR Not Scanned"));
        return;
      }

      if (scanningResult.format != BarcodeFormat.qr) {
        emit(KeyScanningFailed("Not a QR Code"));
        return;
      }

      emit(KeyScanningSuccessful(scanningResult.rawContent));
    });
  }
}
