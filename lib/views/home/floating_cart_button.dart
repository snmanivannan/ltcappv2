import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import '../../constants/asset_constants.dart';
import '../../shared/styles.dart';
import '../../viewmodels/home_viewmodel.dart';

class FloatingCartButton extends ViewModelWidget<HomeViewModel> {
  const FloatingCartButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, HomeViewModel viewModel) {
    return Align(
      alignment: Alignment.bottomRight,
      child: GestureDetector(
        onTap: () => viewModel.navigateToCartPage(),
        child: Stack(
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 8, right: 2),
              alignment: Alignment.center,
              width: 68,
              height: 68,
              decoration: BoxDecoration(
                color: appGreenColor,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    offset: const Offset(0, 4),
                    blurRadius: 4,
                    color: appGreenColor.withOpacity(0.26),
                  ),
                ],
              ),
              child: Image.asset(
                AssetConstants.cartIconWhite,
                width: 21,
              ),
            ),
            Positioned(
              top: 9,
              right: 15,
              child: Container(
                margin: const EdgeInsets.only(bottom: 8, right: 2),
                height: 16,
                width: 25,
                decoration: BoxDecoration(
                  color: Color(0xFFFF4848),
                  shape: BoxShape.circle,
                  //border: Border.all(width: 1.5, color: Colors.white),
                ),
                child: Center(
                  child: Text(
                    //"117",
                      (viewModel.cart.length).toString(),

                    style: TextStyle(
                      fontSize: 10,
                      height: 1,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,

                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
