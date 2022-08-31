import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import 'package:ecommerce_app/data/mock_data.dart';
import 'package:ecommerce_app/data/enums/category.dart';
import 'package:ecommerce_app/utils/products_util.dart';
import 'package:ecommerce_app/constantse/font_style.dart';
import 'package:ecommerce_app/data/entities/product.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ecommerce_app/constantse/color_constantse.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_app/presentation/config/route_constantse.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int? chipValue = 0;
  late List<Product> randomProducts;
  List<Product> featuredProducts = MockData.productsMockData[Category.values[0]]!;
  List<Product> allProducts = MockData.productsMockData.values.expand((catProducts) => catProducts).toList();

  @override
  void initState() {
    super.initState();
    //Pick 5 random Products
    randomProducts = allProducts.sample(5);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: REdgeInsets.symmetric(horizontal: 12),
                child: Column(
                  children: [
                    buildAppBar(),
                    const SizedBox(height: 10),
                    _categoriesBar(),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              _featuredProducts(),
              _recommendedProducts(),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildAppBar() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const CircleAvatar(backgroundImage: AssetImage('assets/images/photo.jpg')),
            const Icon(Icons.search),
            Badge(
              badgeColor: ColorConstants.accentColor,
              badgeContent: const Text('3'),
              child: const Icon(Icons.shopping_cart),
            ),
          ],
        ),
      ],
    );
  }

  Widget _categoriesBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: Category.values
          .map((e) => ChoiceChip(
                shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                label: Text(e.title, style: FontSyles.title),
                selectedColor: ColorConstants.accentColor,
                backgroundColor: Colors.white,
                elevation: 0,
                selected: chipValue == e.index,
                onSelected: (bool value) => setState(() {
                  chipValue = value ? e.index : null;
                  featuredProducts = MockData.productsMockData[e] ?? [];
                }),
              ))
          .toList(),
    );
  }

  Widget featuredProductCard(Product product) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, Routes.productScreen, arguments: product),
      child: Container(
        width: .5.sw,
        padding: REdgeInsets.all(11),
        child: Column(
          children: [
            Container(
              width: .5.sw,
              height: 0.32.sh,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: const BorderRadius.all(Radius.circular(20)),
              ),
              child: CachedNetworkImage(
                imageUrl: product.images.last,
                memCacheHeight: 800,
                memCacheWidth: 800,
                maxHeightDiskCache: 800,
                maxWidthDiskCache: 800,
                fit: ProductsUtil.getProductCategory(id: product.id) == Category.sneakers ? BoxFit.contain : BoxFit.cover,
                progressIndicatorBuilder: (context, url, downloadProgress) => Center(
                  child: CircularProgressIndicator(
                    value: downloadProgress.progress,
                    strokeWidth: 3,
                    color: ColorConstants.subTitles,
                  ),
                ),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
            SizedBox(height: .015.sh),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Text(
                    product.title,
                    style: FontSyles.title,
                    overflow: TextOverflow.fade,
                    maxLines: 1,
                    softWrap: false,
                  ),
                ),
                SizedBox(width: .04.sw),
                Text(
                  '\$${product.price.toString()}',
                  style: FontSyles.subTitle,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _featuredProducts() {
    return SizedBox(
      height: .4.sh,
      child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          itemCount: featuredProducts.length + 2,
          itemBuilder: (context, index) {
            if (index == 0) {
              return SizedBox(width: .032.sw);
            } else if (index == featuredProducts.length + 1) {
              return SizedBox(width: .032.sw);
            } else {
              return featuredProductCard(featuredProducts[index - 1]);
            }
          }),
    );
  }

  Widget _recommendedProducts() {
    return Column(
      children: [
        Container(
          padding: REdgeInsets.all(18),
          alignment: Alignment.topLeft,
          child: const Text('Recommended For You'),
        ),
        SizedBox(
          height: .4.sh,
          child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemCount: randomProducts.length + 2,
              itemBuilder: (context, index) {
                if (index == 0) {
                  return SizedBox(width: .032.sw);
                } else if (index == randomProducts.length + 1) {
                  return SizedBox(width: .032.sw);
                } else {
                  return featuredProductCard(randomProducts[index - 1]);
                }
              }),
        )
      ],
    );
  }
}
