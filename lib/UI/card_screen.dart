import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';

import '../constants/assets_path.dart';
import '../constants/colors.dart';
import '../widgets/appbar.dart';

class CardScreen extends StatefulWidget {
  const CardScreen({Key? key}) : super(key: key);

  @override
  State<CardScreen> createState() => _CardScreenState();
}

class _CardScreenState extends State<CardScreen> with SingleTickerProviderStateMixin {
  late final TabController _tabController = TabController(
    length: 3,
    vsync: this,
  );
  final cardList = [
    AssetsPath.card1,
    AssetsPath.card2,
    AssetsPath.card1,
    AssetsPath.card2,
  ];
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: const BuildAppBar(),
      body: Column(
        children: [
          swiperCards(context, size),
          TabBar(
              indicatorSize: TabBarIndicatorSize.tab,
              indicatorColor: AppColors.blueSecondary,
              isScrollable: true,
              controller: _tabController,
              indicatorPadding: const EdgeInsets.all(6),
              labelColor: AppColors.blueSecondary,
              unselectedLabelColor: AppColors.greyLite,
              tabs: const [
                Tab(
                  text: "Menu Title 1",
                ),
                Tab(
                  text: "Menu Title 2",
                ),
                Tab(
                  text: "Menu Title 3",
                ),
                Tab(
                  text: "Menu Title 4",
                ),
              ]),
          Expanded(
            child: TabBarView(controller: _tabController, children: const [
              Icon(Icons.directions_transit),
              Icon(Icons.directions_transit),
              Icon(Icons.directions_bike),
            ]),
          )
        ],
      ),
    );
  }

  Widget swiperCards(BuildContext context, Size size) {
    return SizedBox(
      height: size.height * .3,
      child: Swiper(
        itemCount: cardList.length,
        itemBuilder: (BuildContext context, int index) {
          return Image.asset(
            cardList[index],
          );
        },
        viewportFraction: .8,
        scale: .9,
        autoplay: true,
        pagination: const SwiperPagination(
          alignment: Alignment.bottomCenter,
          builder: DotSwiperPaginationBuilder(
              activeSize: 10,
              space: 6,
              size: 6,
              color: Colors.black26,
              activeColor: AppColors.blueSecondary),
        ),
      ),
    );
  }
}
