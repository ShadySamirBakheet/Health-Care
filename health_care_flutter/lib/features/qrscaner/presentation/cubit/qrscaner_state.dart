part of 'qrscaner_cubit.dart';

abstract class QrScanerState {
  const QrScanerState();
}

class QrScanerInitial extends QrScanerState {}

class QrScanerWithDataState extends QrScanerState {
  QrScanerWithDataState(this.data);

  final String data;
}
