import 'package:ecommerce_app/data/entities/product.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_app/presentation/view/home_screen.dart';
import 'package:ecommerce_app/presentation/view/product_screen.dart';
import 'package:ecommerce_app/presentation/config/route_constantse.dart';


Route<dynamic> controller(RouteSettings settings) {
  switch (settings.name) {
    case Routes.homePage:
      return MaterialPageRoute(builder: (context) => const MyHomePage());
    case Routes.productScreen:
      final product = settings.arguments as Product;
      return MaterialPageRoute(builder: (context) => ProductScreen(product: product));
    default:
      return MaterialPageRoute(builder: (context) => const MyHomePage());
  }
}
