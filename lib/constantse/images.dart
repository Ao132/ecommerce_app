import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../data/entities/product.dart';
import 'color_constantse.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  const ProductCard({super.key, required this.product});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          child: ListView(scrollDirection: Axis.horizontal, children: [
          ]),
        )
      ],
    );
  }
}
