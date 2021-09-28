import 'package:animated_card/animated_card.dart';
import 'package:flutter/material.dart';

import 'package:pay_flow/shared/models/boleto_model.dart';
import 'package:pay_flow/shared/themes/app_text_styles.dart';

class BoletoTileWidget extends StatelessWidget {
  final BoletoModel data;
  const BoletoTileWidget({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedCard(
      direction: AnimatedCardDirection.left,
      child: ListTile(
        title: Text(data.name!, style: TextStyles.titleListTile),
        subtitle:
            Text("Vence em ${data.dueDate}", style: TextStyles.trailingRegular),
        trailing: Text.rich(TextSpan(
          text: "R\$ ",
          style: TextStyles.trailingRegular,
          children: [
            TextSpan(
                text: "${data.value!.toStringAsFixed(2)}",
                style: TextStyles.trailingBold),
          ],
        )),
      ),
    );
  }
}
