import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:grocery_store/widget/price_widget.dart';
import 'package:grocery_store/widget/text_widget.dart';
import 'package:iconly/iconly.dart';

import '../widget/feed_item_widget.dart';
import '../widget/on_sale_widget.dart';
import 'buttom_bar.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = "/mainScreen";

  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List offerImage = [
    "https://img.freepik.com/free-photo/abstract-blur-supermarket-retail-store_74190-7546.jpg?w=740&t=st=1672496720~exp=1672497320~hmac=a704cee805830ca6eba58335eeeed13379182d47ebcc6191a6b36a9163646389",
    "https://images.pexels.com/photos/9705821/pexels-photo-9705821.jpeg?auto=compress&cs=tinysrgb&w=600",
    "https://images.pexels.com/photos/7129711/pexels-photo-7129711.jpeg?auto=compress&cs=tinysrgb&w=600",
    "https://images.pexels.com/photos/277262/pexels-photo-277262.jpeg?auto=compress&cs=tinysrgb&w=600",
  ];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: size.height * 0.33,
                child: Swiper(
                  itemBuilder: (BuildContext context, int index) {
                    return Image.network(
                      offerImage[index],
                      fit: BoxFit.fill,
                    );
                  },
                  autoplay: true,
                  itemCount: offerImage.length,
                  pagination: const SwiperPagination(
                      alignment: Alignment.bottomCenter,
                      builder: DotSwiperPaginationBuilder(
                          color: Colors.white, activeColor: Colors.blue)),
                  // control: SwiperControl(),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              TextButton(
                onPressed: () {},
                child: const TextWidget(
                  title: "View all",
                  color: Colors.blue,
                  textSize: 20,
                  maxLine: 1,
                ),
              ),
              // SizedBox(
              //   height: 6,
              // ),
              // Row(
              //   children: [
              //     RotatedBox(
              //       quarterTurns: -1,
              //       child: Row(
              //         children: [
              //           TextWidget(
              //             title: 'on sale'.toUpperCase(),
              //             color: Colors.red,
              //             textSize: 22,
              //             isTitle: true,
              //           ),
              //           const SizedBox(
              //             width: 5,
              //           ),
              //           const Icon(
              //             IconlyLight.discount,
              //             color: Colors.red,
              //           ),
              //         ],
              //       ),
              //     ),
              //     const SizedBox(
              //       width: 8,
              //     ),
              //     Flexible(
              //       child: SizedBox(
              //         height: size.height * 0.24,
              //         child: ListView.builder(
              //             scrollDirection: Axis.horizontal,
              //             itemCount: 10,
              //             itemBuilder: (context, index) {
              //               return OnSaleWidget(size: size);
              //             }),
              //       ),
              //     ),
              //   ],
              // ),
              // const SizedBox(
              //   height: 10,
              // ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  TextWidget(
                    title: 'our product  ',
                    textSize: 22,
                    color: Colors.black,
                    isTitle: true,
                  ),
                  // TextButton(
                  //   child: const TextWidget(
                  //     title: 'Browse all ',
                  //     color: Colors.blue,
                  //     textSize: 20,
                  //   ),
                  //   onPressed: () {},
                  // ),
                ],
              ),
              GridView.count(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                padding: EdgeInsets.zero,
                childAspectRatio: size.width / (size.height * 0.6),
                children: List.generate(
                  4,
                  (index) {
                    return const FeedWidget();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
