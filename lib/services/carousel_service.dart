import 'package:lotus_trading_company_sivakasi/models/carousel_item_model.dart';
import 'package:injectable/injectable.dart';
import '../constants/asset_constants.dart';

@lazySingleton
class CarouselService {
  List<CarouselItem> getCarouselList() {
    List<CarouselItem> carouselList = <CarouselItem>[];
    carouselList.add(CarouselItem(
        text: '50% off on your\nfirst purchase',
        imagePath: AssetConstants.bannerImage));
    carouselList.add(CarouselItem(
        text: 'Buy 1\nGet 1 FREE',
        imagePath: AssetConstants.bannerImage));
    carouselList.add(CarouselItem(
        text: 'Direct Manufacturer\nfrom Sivakasi',
        imagePath: AssetConstants.bannerImage));
    carouselList.add(CarouselItem(
        text: 'New products\nComing Soon..',
        imagePath: AssetConstants.bannerImage));
    return carouselList;
  }
}
