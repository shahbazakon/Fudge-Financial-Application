import 'dart:developer';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../constants/assets_path.dart';
import '../constants/colors.dart';
import '../models/users_model.dart';
import '../services/API_services.dart';
import '../widgets/list_tile.dart';
import 'card_screen.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  List<Users>? topUserList;
  bool isLoading = true;

  getUser() async {
    topUserList = await APIServices().getTopUsers();
    if (topUserList != null) {
      setState(() {});
      return topUserList;
    }
  }

  @override
  void initState() {
    super.initState();
    getUser();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: topUserList != null
            ? Column(
                children: [
                  appBar(size),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          topPanel(size),
                          sectionHeadline("Performance Chart", isShowMoreButton: true,
                              onTapMore: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) => const CardScreen()));
                          }),

                          ///GraphPNG
                          /*Padding(
                            padding: const EdgeInsets.only(right: 20, left: 8),
                            child: Image.asset(AssetsPath.graph),
                          ),*/
                          chart(size),
                          sectionHeadline("Top User From your community"),
                          topUsersList(size),
                          sectionHeadline("Recent Transactions", isShowMoreButton: true,
                              onTapMore: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) => const CardScreen()));
                          }),
                          recentTransactionList(size),
                          sectionHeadline("financial Goals"),
                          financialGoalsListBar(size),
                        ],
                      ),
                    ),
                  ),
                ],
              )
            : const Center(child: CircularProgressIndicator(color: AppColors.blueSecondary)),
      ),
    );
  }

  /// Main AppBar
  Container appBar(Size size) {
    log("topUserList $topUserList");
    log("topUserList![0].username? ${topUserList![0].username}");
    return Container(
      width: size.width,
      decoration: const BoxDecoration(color: AppColors.blueSecondary),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 4),
                  child: RichText(
                    text: TextSpan(
                        text: "Hello, ",
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                        children: [
                          TextSpan(
                              text: "${topUserList![2].username}",
                              style: const TextStyle(fontWeight: FontWeight.w400))
                        ]),
                  ),
                ),
                Text(
                  "${topUserList![2].company!.name}",
                  style: const TextStyle(color: AppTextColors.white, fontSize: 11),
                )
              ],
            ),
            const Spacer(),
            GestureDetector(
              onTap: () {
                //TODO: Add Notification Button Functionality
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Image.asset(
                  AssetsPath.bell,
                  height: 22,
                ),
              ),
            ),
            Image.asset(
              AssetsPath.circleUserProfile,
              height: 25,
            ),
          ],
        ),
      ),
    );
  }

  /// TOP Panel
  Container topPanel(Size size) {
    return Container(
      width: size.width,
      height: size.height * .32,
      decoration: const BoxDecoration(
          color: AppColors.blueSecondary,
          borderRadius:
              BorderRadius.only(bottomLeft: Radius.circular(30), bottomRight: Radius.circular(20))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            children: [
              const Text(
                "\$56,271.68",
                style: TextStyle(
                    color: AppTextColors.white, fontSize: 35, fontWeight: FontWeight.bold),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 4, bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("+\$9,736",
                        style: TextStyle(color: AppTextColors.white, fontSize: 18)),
                    SizedBox(
                      width: size.width * .05,
                    ),
                    Row(
                      children: const [
                        Icon(
                          Icons.arrow_upward_sharp,
                          color: AppTextColors.green,
                        ),
                        Text(
                          "2.3%",
                          style: TextStyle(color: AppTextColors.green, fontSize: 18),
                        )
                      ],
                    )
                  ],
                ),
              ),
              const Text(
                "ACCOUNT BALANCE",
                style: TextStyle(color: AppTextColors.white30),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              panelBottomBlock("12", "Following"),
              Container(
                height: 50,
                width: 1,
                color: AppTextColors.white30,
              ),
              panelBottomBlock("36", "Transaction"),
              Container(
                height: 50,
                width: 1,
                color: AppTextColors.white30,
              ),
              panelBottomBlock("4", "Bills"),
            ],
          ),
        ],
      ),
    );
  }

  Column panelBottomBlock(
    String title,
    String subTitle,
  ) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 6),
          child: Text(title,
              style: const TextStyle(
                  color: AppTextColors.white, fontWeight: FontWeight.bold, fontSize: 20)),
        ),
        Text(subTitle, style: const TextStyle(color: AppTextColors.white30, fontSize: 13))
      ],
    );
  }
}

///page Secretion HeadLine
ListTile sectionHeadline(String title, {bool? isShowMoreButton = false, Function()? onTapMore}) {
  return ListTile(
      title: Text(
        title.toUpperCase(),
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      trailing: InkWell(
        onTap: onTapMore,
        child: isShowMoreButton ?? false
            ? Container(
                padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                decoration: BoxDecoration(
                  color: AppColors.grey,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text("MORE", style: TextStyle(color: AppTextColors.white)),
              )
            : const SizedBox(),
      ));
}

/// performance Chart
Container chart(Size size) {
  return Container(
    padding: const EdgeInsets.only(right: 20, left: 8),
    height: size.height * .23,
    width: size.width,
    child: LineChart(
      LineChartData(
          minX: 0,
          maxX: 6,
          minY: 0,
          maxY: 500,
          titlesData: FlTitlesData(
              show: true,
              rightTitles: AxisTitles(),
              topTitles: AxisTitles(),
              leftTitles: AxisTitles(
                  sideTitles: SideTitles(showTitles: true, reservedSize: 35, interval: 250)),
              bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  if (value.toInt() == 0) {
                    return chartBottomLabel("JAN");
                  }
                  if (value.toInt() == 1) {
                    return chartBottomLabel("FEB");
                  }
                  if (value.toInt() == 2) {
                    return chartBottomLabel("MAR");
                  }
                  if (value.toInt() == 3) {
                    return chartBottomLabel("APR");
                  }
                  if (value.toInt() == 4) {
                    return chartBottomLabel("MAY");
                  }
                  if (value.toInt() == 5) {
                    return chartBottomLabel("JUN");
                  } else {
                    return chartBottomLabel("");
                  }
                },
              ))),
          backgroundColor: Colors.deepPurple.shade900.withOpacity(.1),
          borderData: FlBorderData(show: false),
          gridData: FlGridData(
            show: true,
            drawHorizontalLine: false,
            getDrawingVerticalLine: (value) {
              return FlLine(color: AppColors.white, strokeWidth: 3);
            },
          ),
          lineTouchData: LineTouchData(
              touchTooltipData: LineTouchTooltipData(tooltipBgColor: AppColors.white)),
          lineBarsData: [
            LineChartBarData(
                color: AppColors.blue,
                barWidth: 1.3,
                isCurved: true,
                dotData: FlDotData(show: false),
                spots: [
                  const FlSpot(0, 275),
                  const FlSpot(1.2, 250),
                  const FlSpot(1.9, 425),
                  // const FlSpot(2.5, 390),
                  const FlSpot(2.9, 330),
                  const FlSpot(3.3, 310),
                  const FlSpot(3.7, 150),
                  const FlSpot(4.2, 166),
                  const FlSpot(4.8, 240),
                  const FlSpot(5.2, 235),
                  const FlSpot(5.6, 190),
                  const FlSpot(6, 90),
                ])
          ]),
      swapAnimationDuration: const Duration(milliseconds: 150), // Optional
      swapAnimationCurve: Curves.linear, // Optional
    ),
  );
}

Widget chartBottomLabel(String label) {
  return Text(
    label,
    style: const TextStyle(color: AppTextColors.black26, fontSize: 12),
  );
}

/// Top User List
SizedBox topUsersList(Size size) {
  return SizedBox(
    height: size.height * .1,
    child: GridView.count(
      crossAxisCount: 1,
      scrollDirection: Axis.horizontal,
      children: [
        topUsersProfile("Jayden", AssetsPath.dp1),
        topUsersProfile("Mike", AssetsPath.dp2),
        topUsersProfile("Nikki", AssetsPath.dp3),
        topUsersProfile("Oslo", AssetsPath.dp4),
        topUsersProfile("Jayden", AssetsPath.dp1),
        topUsersProfile("Mike", AssetsPath.dp2),
        topUsersProfile("Nikki", AssetsPath.dp3),
        topUsersProfile("Oslo", AssetsPath.dp4),
      ],
    ),
  );
}

FittedBox topUsersProfile(String userName, String userProfilePic) {
  return FittedBox(
    child: Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset(userProfilePic),
        ),
        Text(
          userName,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
        )
      ],
    ),
  );
}

/// Recent Transaction List
SizedBox recentTransactionList(Size size) {
  return SizedBox(
    height: size.height * .35,
    child: ListView(
      physics: const NeverScrollableScrollPhysics(),
      children: const [
        TransactionListTile(
          leading: AssetsPath.user,
          title: "John Doe",
          subTitle: "United Kingdom",
          trallingTitle: "80,000 AED",
          trallingSubTitle: "11 Aug 2021",
          trallingIcon: AssetsPath.processCircle,
        ),
        TransactionListTile(
          leading: AssetsPath.user,
          title: "John Doe",
          subTitle: "United Kingdom",
          trallingTitle: "80,000 AED",
          trallingSubTitle: "11 Aug 2021",
          trallingIcon: AssetsPath.checkCircle,
        ),
        TransactionListTile(
          leading: AssetsPath.user,
          title: "John Doe",
          subTitle: "United Kingdom",
          trallingTitle: "80,000 AED",
          trallingSubTitle: "11 Aug 2021",
          trallingIcon: AssetsPath.checkCircle,
        ),
        TransactionListTile(
          leading: AssetsPath.user,
          title: "John Doe",
          subTitle: "United Kingdom",
          trallingTitle: "80,000 AED",
          trallingSubTitle: "11 Aug 2021",
          trallingIcon: AssetsPath.checkCircle,
        )
      ],
    ),
  );
}

///Financial Goals

Column financialGoalsListBar(Size size) {
  return Column(
    children: [
      financialGoalsTiles(size, "XX of total XX", AppColors.blue, .3),
      financialGoalsTiles(size, "XX of total XX", AppColors.red, .7),
      financialGoalsTiles(size, "XX of total XX", AppColors.greenAccent, .6),
    ],
  );
}

Widget financialGoalsTiles(
    Size size, String? title, Color? progressBarColor, double? progressPercentage) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 10),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 2, bottom: 8),
          child: Text(
            title!,
            style: const TextStyle(fontSize: 16, color: AppTextColors.black26),
          ),
        ),
        SizedBox(
          width: size.width * .87,
          child: LinearProgressIndicator(
            color: progressBarColor,
            minHeight: 5,
            value: progressPercentage,
            backgroundColor: AppColors.greyLite,
          ),
        ),
      ],
    ),
  );
}
