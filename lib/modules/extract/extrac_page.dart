import 'package:flutter/material.dart';
import 'package:pay_flow/shared/themes/app_colors.dart';
import 'package:pay_flow/shared/themes/app_text_styles.dart';
import 'package:pay_flow/shared/widgets/boleto_list/boleto_list.dart';
import 'package:pay_flow/shared/widgets/boleto_list/boleto_list_controller.dart';

class ExtractPage extends StatefulWidget {
  const ExtractPage({Key? key}) : super(key: key);

  @override
  _ExtractPageState createState() => _ExtractPageState();
}

class _ExtractPageState extends State<ExtractPage> {
  final controller = BoletoListController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 24, left: 24, right: 24),
          child: Row(
            children: [
              Text("Meu Extrato", style: TextStyles.titleBoldHeading),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 24, left: 24, right: 24),
          child: Divider(
            thickness: 1,
            height: 2,
            color: AppColors.stroke,
          ),
        ),
        Expanded(
          child: ListView(children: [
            BoletoListWidget(controller: controller),
          ]),
        )
      ],
    );
  }
}
