import 'package:animated_card/animated_card.dart';
import 'package:flutter/material.dart';
import 'package:pay_flow/shared/models/boleto_model.dart';
import 'package:pay_flow/shared/themes/app_colors.dart';
import 'package:pay_flow/shared/themes/app_text_styles.dart';
import 'package:pay_flow/shared/widgets/boleto_info/boleto_info.dart';
import 'package:pay_flow/shared/widgets/boleto_list/boleto_list.dart';
import 'package:pay_flow/shared/widgets/boleto_list/boleto_list_controller.dart';

class MeusBoletosPage extends StatefulWidget {
  const MeusBoletosPage({Key? key}) : super(key: key);

  @override
  _MeusBoletosPageState createState() => _MeusBoletosPageState();
}

class _MeusBoletosPageState extends State<MeusBoletosPage> {
  final controller = BoletoListController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(children: [
          Container(
              color: AppColors.primary, height: 40, width: double.maxFinite),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: ValueListenableBuilder<List<BoletoModel>>(
              valueListenable: controller.boletosNotifier,
              builder: (_, boletos, __) => AnimatedCard(
                  direction: AnimatedCardDirection.top,
                  child: BoletoInfoWidget(size: boletos.length)),
            ),
          ),
        ]),
        Padding(
          padding: const EdgeInsets.only(top: 24, left: 24, right: 24),
          child: Row(
            children: [
              Text("Meus Boletos", style: TextStyles.titleBoldHeading),
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
