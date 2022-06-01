import 'dart:io';

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import '../../shared/styles.dart';
import '../../viewmodels/shopping_cart_viewmodel.dart';
import '../../widgets/dumb/app_main_button.dart';
import 'title_with_cost.dart';
import 'package:url_launcher/url_launcher.dart';

const url = "https://wa.me/?text=Hey buddy, try this super cool new app!";

class CostWithMainButton extends ViewModelWidget<ShoppingCartViewModel> {
  const CostWithMainButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, ShoppingCartViewModel viewModel) {
    return Container(
      margin: const EdgeInsets.only(top: 13),
      constraints: const BoxConstraints(minHeight: 100),
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          // const SizedBox(height: 22),
          // TitleWithCost(
          //   title: 'Subtotal',
          //   cost: viewModel.subTotal,
          //   style: paragraph6,
          // ),
          // const SizedBox(height: 7),
          // TitleWithCost(
          //   title: 'Shipping charges',
          //   cost: viewModel.shippingCharges,
          //   style: paragraph6,
          // ),
          // const SizedBox(height: 10),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 17, vertical: 10),
            height: 1,
            color: appGreySecondary,
          ),
          TitleWithCost(
            title: 'Total Quantity',
            cost: 0.0,
            style: paragraph5,
            totalQty: viewModel.subTotalQty,
          ),
          const SizedBox(height: 16),
          AppMainButton(
              onTap: () {
                _launchUrl(viewModel.orderText());
              },
              text: 'ORDER via Whatsapp'),
          const SizedBox(height: 36),
        ],
      ),
    );
  }

  void _launchUrl(var text) async {
    var phonenumber = "919894765095";
    text = text.replaceAll("{","").replaceAll("}","").replaceAll(",","");
    final Uri _url = Uri.parse('whatsapp://send?phone=$phonenumber&text=$text');
    if (!await launchUrl(_url)) throw 'Whatsapp is not installed $_url';
  }
}
