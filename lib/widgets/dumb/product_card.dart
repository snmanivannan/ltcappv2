import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../constants/asset_constants.dart';
import '../../shared/styles.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'dart:ui';

class ProductCard extends StatefulWidget {
  final String? shadeColor;
  final String? image;
  final int? price;
  final String? title;
  final String? unit;
  int qtyInCart;
  bool favoriteToggle;
  VoidCallback onMinusTap;
  VoidCallback onPlusTap;
  VoidCallback onFavoriteButtonTap;

  ProductCard({
    Key? key,
    required this.shadeColor,
    required this.image,
    required this.price,
    required this.title,
    required this.unit,
    required this.qtyInCart,
    required this.favoriteToggle,
    required this.onMinusTap,
    required this.onPlusTap,
    required this.onFavoriteButtonTap,
  }) : super(key: key);

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  bool _showPreview = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(
                      //left: 30,
                      //right: 30,
                      //top: 21,
                      ),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      // Container(
                      //   margin: const EdgeInsets.only(bottom: 18),
                      //   child: FittedBox(
                      //     child: Container(
                      //       height: 10,
                      //       width: 10,
                      //       decoration: BoxDecoration(
                      //         color: Color(
                      //           int.parse(
                      //             '0xFF' + shadeColor.toString().substring(1),
                      //           ),
                      //         ).withOpacity(0.3),
                      //         shape: BoxShape.circle,
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      GestureDetector(
                        onTap: (){
                          setState((){
                            _showPreview = true;


                          });
                        },
                        child: Container(
                          margin: const EdgeInsets.only(
                            bottom: 8,
                            //    top: 8
                          ),
                          child:
                          CachedNetworkImage(
                            imageUrl: widget.image.toString(),
                            progressIndicatorBuilder: (context, url, downloadProgress) =>
                                CircularProgressIndicator(value: downloadProgress.progress),
                            errorWidget: (context, url, error) => Icon(Icons.error),
                          ),
                          // Image.network(
                          //    image ?? AssetConstants.errorIcon,
                          //   fit: BoxFit.cover,
                          //   alignment: Alignment.topCenter,
                          // ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              // Text(
              //   '\$' + (price ?? 0).toString().padRight(4, '0'),
              //   style: paragraph6.copyWith(color: appGreenColor),
              // ),
              Text(
                widget.title ?? '',
                style: heading7.copyWith(color: Colors.black),
                maxLines: 2,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 2),
              // Text(
              //   unit ?? '',
              //   style: paragraph6,
              // ),
              const SizedBox(height: 15),
              Container(
                height: 1,
                color: appGreySecondary,
              ),
              SizedBox(
                height: 41,
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 150),
                  child: widget.qtyInCart > 0
                      ? Container(
                          color: Colors.transparent,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                onTap: widget.onMinusTap,
                                child: Container(
                                  color: Colors.transparent,
                                  width: 41,
                                  alignment: Alignment.center,
                                  child: SvgPicture.asset(
                                    AssetConstants.subtractIcon,
                                    width: 13.5,
                                  ),
                                ),
                              ),
                              Text(
                                widget.qtyInCart.toString(),
                                style: paragraph6.copyWith(color: Colors.black),
                              ),
                              GestureDetector(
                                onTap: widget.onPlusTap,
                                child: Container(
                                  color: Colors.transparent,
                                  width: 41,
                                  alignment: Alignment.center,
                                  child: SvgPicture.asset(
                                    AssetConstants.addIcon,
                                    width: 13.5,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      : GestureDetector(
                          onTap: widget.onPlusTap,
                          child: Container(
                            height: 40,
                            color: Colors.transparent,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  AssetConstants.addToCartIcon,
                                  height: 15,
                                ),
                                const SizedBox(width: 9),
                                Padding(
                                  padding: const EdgeInsets.only(top: 4),
                                  child: Text(
                                    'Add to cart',
                                    style: paragraph6.copyWith(
                                      color: const Color(0xFF010101),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                ),
              ),
            ],
          ),
        ),
        Positioned(
            top: 5,
            left: 8,
            child: GestureDetector(
              onTap: widget.onFavoriteButtonTap,
              child: Image.asset(
                widget.favoriteToggle
                    ? AssetConstants.favoriteSelected
                    : AssetConstants.favoriteUnselected,
                width: 18,
                height: 16,
              ),
            )),

        if (_showPreview) ...[
          BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: 5.0,
              sigmaY: 5.0,
            ),
            child: Container(
              color: Colors.white.withOpacity(0.6),
            ),
          ),
          Container(
            child: Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child:
                CachedNetworkImage(
                  imageUrl: widget.image.toString(),
                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                      CircularProgressIndicator(value: downloadProgress.progress),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                  height: 300,
                  width: 300,
                ),
              ),
            ),
          ),
        ],
      ],
    );
  }
}
