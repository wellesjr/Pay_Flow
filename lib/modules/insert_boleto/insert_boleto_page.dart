import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pay_flow/modules/insert_boleto/insert_boleto_controller.dart';
import 'package:pay_flow/shared/themes/app_colors.dart';
import 'package:pay_flow/shared/themes/app_text_styles.dart';
import 'package:pay_flow/shared/widgets/input_text/input_text_page.dart';
import 'package:pay_flow/shared/widgets/set_label_buttons/set_label_buttons_widgets.dart';

class InsertBoletoPage extends StatefulWidget {
  final String? barcode;
  const InsertBoletoPage({Key? key, this.barcode}) : super(key: key);

  @override
  _InsertBoletoPageState createState() => _InsertBoletoPageState();
}

class _InsertBoletoPageState extends State<InsertBoletoPage> {
  final controller = InsertBoletoController();
  final moneyInputTextController =
      MoneyMaskedTextController(leftSymbol: "R\$", decimalSeparator: ",");
  final dueDateInputTextController = MaskedTextController(mask: "00/00/0000");
  final barcodeInputTextController = TextEditingController();

  @override
  void initState() {
    if (widget.barcode != null) {
      barcodeInputTextController.text = widget.barcode!;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: BackButton(
          onPressed: () {
            Navigator.pushNamed(context, "/splash");
          },
          color: AppColors.input,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 70, vertical: 24),
              child: Text(
                "Preencha os dados do boleto",
                style: TextStyles.titleBoldHeading,
                textAlign: TextAlign.center,
              ),
            ),
            Form(
                key: controller.formKey,
                child: Expanded(
                  child: ListView(
                    children: [
                      InputTextWidget(
                          label: 'Nome do boleto',
                          icon: Icons.description_outlined,
                          onChanged: (value) {
                            controller.onChange(name: value);
                          },
                          validator: controller.validateName),
                      InputTextWidget(
                          controller: dueDateInputTextController,
                          label: 'Vencimento',
                          icon: FontAwesomeIcons.timesCircle,
                          onChanged: (value) {
                            controller.onChange(dueDate: value);
                          },
                          validator: controller.validateVencimento),
                      InputTextWidget(
                        controller: moneyInputTextController,
                        label: 'Valor',
                        icon: FontAwesomeIcons.wallet,
                        onChanged: (value) {
                          controller.onChange(
                              value: moneyInputTextController.numberValue);
                        },
                        validator: (_) => controller.validateValor(
                            moneyInputTextController.numberValue),
                      ),
                      InputTextWidget(
                        controller: barcodeInputTextController,
                        label: 'Código',
                        icon: FontAwesomeIcons.barcode,
                        onChanged: (value) {
                          controller.onChange(barcode: value);
                        },
                        validator: controller.validateCodigo,
                      ),
                    ],
                  ),
                ))
          ],
        ),
      ),
      bottomNavigationBar: SetLabelButton(
          enableSegundaryColor: true,
          primaryLabel: "Cancelar",
          primaryOnPressed: () {
            Navigator.pushNamed(context, "/splash");
          },
          secundaryLabel: "Cadastrar",
          secundaryOnPressed: () async {
            await controller.cadastrar();
            Navigator.pushNamed(context, "/splash");
          }),
    );
  }
}
