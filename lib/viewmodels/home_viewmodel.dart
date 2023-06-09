import 'package:lotus_trading_company_sivakasi/app/api.dart';
import 'package:lotus_trading_company_sivakasi/app/app.router.dart';
import 'package:lotus_trading_company_sivakasi/app/locator.dart';
import 'package:lotus_trading_company_sivakasi/models/category_model.dart';
import 'package:lotus_trading_company_sivakasi/models/product_model.dart';
import 'package:lotus_trading_company_sivakasi/services/authentication_service.dart';
import 'package:lotus_trading_company_sivakasi/services/carousel_service.dart';
import 'package:lotus_trading_company_sivakasi/services/cart_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../models/carousel_item_model.dart';

class HomeViewModel extends BaseViewModel {
  final _carouselService = locator<CarouselService>();
  final _auth = locator<AuthenticationService>();
  final _cartService = locator<CartService>();
  final _navigator = locator<NavigationService>();

  List<Product> get cart => _cartService.cart;
  List<Product> get favorites => _cartService.favorites;
  String? get email => _auth.email;

  bool _isLoading = true;
  bool get isLoading => _isLoading;

  bool _hasError = false;
  bool get hasError => _hasError;

  List<CarouselItem> carouselList = <CarouselItem>[];
  List<Category> categories = <Category>[];
  List<Product> products = <Product>[];

  int productQuantity(Product product) {
    return _cartService.getQuantityFromProduct(product);
  }

  int getCartTotalQuantity(){
    return _cartService.getCartTotalQuantity();
  }

  void addToCart(Product product) {
    _cartService.addProduct(product);
    notifyListeners();
  }

  void removeFromCart(Product product) {
    _cartService.removeProduct(product);
    notifyListeners();
  }

  void addOrRemoveFavorites(Product product) {
    _cartService.addOrRemoveFavorites(product);
    notifyListeners();
  }

  bool isFavorited(Product product) {
    int index = favorites.indexWhere((element) => element.id == product.id);
    if (index == -1) {
      return false;
    } else {
      return true;
    }
  }

  String logoutLoadingText = 'Logging out';
  bool logoutAnimationActive = false;

  void logoutAnimator() async {
    int counter = 1;
    while (true) {
      if (logoutAnimationActive == false) {
        break;
      } else {
        int multiplier = counter % 3;
        counter += 1;
        logoutLoadingText = 'Logging out' + ('.' * multiplier);
        notifyListeners();
        await Future.delayed(const Duration(milliseconds: 300));
      }
    }
  }

  void logoutUser() async {
    logoutAnimationActive = true;
    notifyListeners();
    logoutAnimator();
    await Future.delayed(const Duration(seconds: 1));
    try {
      await _auth.logout();
      logoutAnimationActive = false;
      _navigator.replaceWith(Routes.loginView);
    } catch (e) {
      await _auth.resetUser();
      logoutAnimationActive = false;
      _navigator.replaceWith(Routes.loginView);
    }
    logoutAnimationActive = false;
    notifyListeners();
  }

  String _searchBarText = '';
  set searchBarText(String value) {
    _searchBarText = value;
  }

  bool onlyProducts = false;

  void onModelReady() async {
    _isLoading = true;
    _hasError = false;
    notifyListeners();
    carouselList = _carouselService.getCarouselList();
    categories = <Category>[];
    products = <Product>[];
    try {
      if (onlyProducts) {

        products =await Api.getProducts(_auth.authToken);
        //var data = products.where((element) => (element.title!.contains(_searchBarText)));
        products = products.where((element) => element.title!.toLowerCase().contains(_searchBarText)).take(10).toList();
            //await Api.getProductsByTitle(_auth.authToken, _searchBarText);
        print(products);

        _isLoading = false;
      } else {
        categories = await Api.getCategories(_auth.authToken);
        products = await Api.getProducts(_auth.authToken);
        products = products.take(10).toList();
        _isLoading = false;
      }
    } catch (e) {
      print(e);
      _hasError = true;
    }
    notifyListeners();
  }

  void navigateToCategoryPage(int? id, String? title) {
    _navigator
        .navigateTo(Routes.categoryView,
            arguments: CategoryViewArguments(
                id: id ?? 0, title: title ?? 'Not Found'))!
        .then((value) {
      notifyListeners();
    });
  }

  void navigateToCartPage() {
    _navigator.navigateTo(Routes.shoppingCartView)!.then((value) {
      notifyListeners();
    });
  }
}
