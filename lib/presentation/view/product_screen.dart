import 'package:badges/badges.dart';
import 'package:ecommerce_app/presentation/config/route_constantse.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecommerce_app/constantse/color_constantse.dart';
import 'package:ecommerce_app/constantse/font_style.dart';
import 'package:ecommerce_app/data/entities/product.dart';

class ProductScreen extends StatefulWidget {
  final Product product;
  ProductScreen({
    required this.product,
  });

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  // final controller = PageController(viewportFraction: 0.5, keepPage: false);
  final controller2 = CarouselController();
  ScrollPhysics physics = const BouncingScrollPhysics();
  var activeIndex = 0;

  int chipValue = 0;

  String size = 'm';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            CarouselSlider.builder(
                carouselController: controller2,
                itemCount: widget.product.images.length,
                itemBuilder: ((context, index, realIndex) => Container(
                      // margin: REdgeInsets.only(right: 10, left: 10),
                      color: ColorConstants.imagesBackground,
                      child: Image.network(
                        widget.product.images[index],
                        fit: BoxFit.fitWidth,
                      ),
                    )),
                options: CarouselOptions(
                    initialPage: 0,
                    onPageChanged: (index, reason) {
                      setState(() {
                        activeIndex = index;
                      });
                    },
                    scrollPhysics: physics,
                    viewportFraction: 1,
                    height: .8.sh,
                    enableInfiniteScroll: false,
                    enlargeCenterPage: true,
                    enlargeStrategy: CenterPageEnlargeStrategy.height)),
            Align(
              alignment: Alignment.topCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.pushNamed(context, Routes.homePage);
                      },
                      icon: Icon(Icons.arrow_back)),
                  Badge(
                    badgeColor: ColorConstants.accentColor,
                    badgeContent: const Text('3'),
                    child: const Icon(Icons.shopping_cart),
                  ),
                ],
              ),
            ),
            Align(
              heightFactor: 200,
              child: AnimatedSmoothIndicator(
                onDotClicked: animate,
                activeIndex: activeIndex,
                count: widget.product.images.length,
                effect: const ScrollingDotsEffect(
                  activeDotColor: Colors.white,
                  dotHeight: 10,
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                decoration:
                    const BoxDecoration(borderRadius: const BorderRadius.vertical(top: const Radius.circular(30)), color: Colors.white),
                height: 280,
                width: 1.sw,
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: Container(
                        padding: REdgeInsets.fromLTRB(20, 25, 0, 10),
                        child: Text(widget.product.title,
                            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: ColorConstants.title1)),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Container(
                        padding: REdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          "\$ ${widget.product.price.toString()}",
                          style: FontSyles.subTitle,
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Container(
                        padding: REdgeInsets.fromLTRB(20, 12, 0, 5),
                        child: const Text('Your Size', style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Row(
                        children: [
                          sizesChoiceChip('m'),
                          sizesChoiceChip('a'),
                          sizesChoiceChip('k'),
                          sizesChoiceChip('u'),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    bottomButton()
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget sizesChoiceChip(String s) {
    return Padding(
      padding: const EdgeInsets.only(left: 0, right: 5),
      child: ChoiceChip(
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5))),
        label: SizedBox(height: 30, width: 15, child: Center(child: Text(s))),
        selectedColor: ColorConstants.accentColor.withOpacity(size == s ? 1 : 0),
        backgroundColor: const Color(0XFFFFFFFF),
        elevation: 6,
        selected: size == s,
        onSelected: (bool value) => setState(() {
          size = s;
          size = value ? s : size;
        }),
      ),
    );
  }

  Widget bottomButton() {
    return SizedBox(
      height: 45,
      width: 330,
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          primary: ColorConstants.secondaryColorDark,
          onPrimary: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        child: const Text('Add To Cart'),
      ),
    );
  }

  void animate(int index) => controller2.animateToPage(index);
}
