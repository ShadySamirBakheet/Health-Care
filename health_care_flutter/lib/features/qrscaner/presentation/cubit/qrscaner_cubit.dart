import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

part 'qrscaner_state.dart';

class QrScanerCubit extends Cubit<QrScanerState> {
  QrScanerCubit() : super(QrScanerInitial());
  static QrScanerCubit cubit(BuildContext context) => BlocProvider.of(context);
  GlobalKey qrKey = GlobalKey();
  String code = '';
  QRViewController? controller;

  void onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    this.controller?.scannedDataStream.distinct();
    this.controller?.scannedDataStream.listen((data) async {
      if (data.code?.isEmpty ?? true) return;
      await controller.pauseCamera();
      if (data.code != code) {
        code = data.code ?? '';
        emit(QrScanerWithDataState(code));
      }
    });
  }

  @override
  Future<void> close() {
    controller?.dispose();
    return super.close();
  }
}
