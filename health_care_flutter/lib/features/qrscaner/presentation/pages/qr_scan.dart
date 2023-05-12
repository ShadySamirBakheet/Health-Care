import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_care_flutter/core/resources/color_manager.dart';
import 'package:health_care_flutter/features/qrscaner/presentation/cubit/qrscaner_cubit.dart';
import 'package:health_care_flutter/features/qrscaner/presentation/widgets/back_arrow.dart';
import 'package:health_care_flutter/features/qrscaner/presentation/widgets/no_flash.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QRScanner extends StatelessWidget {
  const QRScanner({
    required this.postCheckIn,
    super.key,
  });
  final void Function(String) postCheckIn;
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return BlocProvider(
      create: (context) => QrScanerCubit(),
      child: BlocConsumer<QrScanerCubit, QrScanerState>(
        listener: (context, state) {
          if (state is QrScanerWithDataState) {
            postCheckIn(state.data);
          }
        },
        builder: (context, state) {
          return Scaffold(
            body: Center(
              child: Stack(
                children: [
                  QRView(
                    key: QrScanerCubit.cubit(context).qrKey,
                    // overlayMargin: EdgeInsets.only(bottom: 90),
                    overlay: QrScannerOverlayShape(
                      borderRadius: 10,
                      borderColor: ColorManager.primary,
                      borderLength: 20,
                      borderWidth: 15,
                      cutOutSize: height > 600 ? 300 : 250,
                    ),
                    onQRViewCreated:
                        QrScanerCubit.cubit(context).onQRViewCreated,
                  ),
                  const Positioned(
                    top: 40,
                    left: 20,
                    child: BackArrow(),
                  )
                ],
              ),
            ),
            floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
            floatingActionButton: FloatingActionButton(
              backgroundColor: ColorManager.primary,
              onPressed: () async {
                try {
                  await QrScanerCubit.cubit(context).controller?.toggleFlash();
                } catch (_) {
                  showDialogNoFlash(context);
                }
              },
              child: const Icon(
                Icons.flash_on,
                size: 35,
              ),
            ),
          );
        },
      ),
    );
  }

  Future<dynamic> showDialogNoFlash(BuildContext context) {
    return showDialog<dynamic>(
      context: context,
      builder: (context) {
        return const AlertDialog(
          title: NoFlashLight(),
          content: Text(
            'no flashlight',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        );
      },
    );
  }
}
