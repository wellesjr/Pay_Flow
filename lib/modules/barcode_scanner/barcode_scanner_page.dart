import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pay_flow/modules/barcode_scanner/barcode_scanner_controller.dart';
import 'package:pay_flow/modules/barcode_scanner/barcode_scanner_status.dart';
import 'package:pay_flow/shared/themes/app_colors.dart';
import 'package:pay_flow/shared/themes/app_text_styles.dart';
import 'package:pay_flow/shared/widgets/bottom_sheet/bottom_sheet_widget.dart';
import 'package:pay_flow/shared/widgets/set_label_buttons/set_label_buttons_widgets.dart';

class BarcodeSacannerPage extends StatefulWidget {
  BarcodeSacannerPage({Key? key}) : super(key: key);

  @override
  _BarcodeSacannerPageState createState() => _BarcodeSacannerPageState();
}

class _BarcodeSacannerPageState extends State<BarcodeSacannerPage> {
  final controller = BarcodeScannerController();

  @override
  void initState() {
    controller.getAvailableCameras();
    controller.statusNotifier.addListener(() {
      if (controller.status.hasBarcode) {
        Navigator.pushReplacementNamed(context, "/insert_boleto",
            arguments: controller.status.barcode);
      }
    });
    super.initState();
  }

  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      bottom: true,
      left: true,
      right: true,
      child: Stack(
        children: [
          ValueListenableBuilder<BarcodeScannerStatus>(
              valueListenable: controller.statusNotifier,
              builder: (_, status, __) {
                if (status.showCamera) {
                  return Container(
                    color: Colors.blue,
                    child: controller.cameraController!.buildPreview(),
                  );
                } else {
                  return Container();
                }
              }),
          RotatedBox(
            quarterTurns: 1,
            child: Scaffold(
                backgroundColor: Colors.transparent,
                appBar: AppBar(
                  backgroundColor: Colors.black,
                  title: Text("Escaneie o código de barras do boleto",
                      style: TextStyles.buttonBackground),
                  centerTitle: true,
                  leading: BackButton(
                    color: AppColors.background,
                  ),
                ),
                body: Column(
                  children: [
                    Expanded(child: Container(color: Colors.black)),
                    Expanded(
                        flex: 2, child: Container(color: Colors.transparent)),
                    Expanded(child: Container(color: Colors.black)),
                  ],
                ),
                bottomNavigationBar: SetLabelButton(
                  primaryLabel: 'Inserir código do boleto',
                  primaryOnPressed: () {
                    controller.status = BarcodeScannerStatus.error("Error");
                  },
                  secundaryLabel: 'Adicionar da galeria',
                  secundaryOnPressed: controller.scanWithImagePiker,
                )),
          ),
          ValueListenableBuilder<BarcodeScannerStatus>(
              valueListenable: controller.statusNotifier,
              builder: (_, status, __) {
                if (status.hasError) {
                  return Align(
                      alignment: Alignment.bottomLeft,
                      child: BottomSheetWidget(
                        title:
                            "Não foi possível identificar um código de barras.",
                        subtitle:
                            "Tente escanear novamente ou digite o código do seu boleto.",
                        primaryLabel: 'Escanear novamente',
                        primaryOnPressed: () {
                          controller.scanWithCamera();
                        },
                        secundaryLabel: 'Digitar código',
                        secundaryOnPressed: () async {
                          await Navigator.pushNamed(context, "/insert_boleto");
                        },
                      ));
                } else {
                  return Container();
                }
              }),
        ],
      ),
    );
  }
}
