import 'package:flutter/material.dart';

import '../constants/assets_path.dart';
import '../constants/colors.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            appBar(size),
            SingleChildScrollView(
              child: Column(
                children: [topPanel(size)],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Main AppBar
  Container appBar(Size size) {
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
                    text: const TextSpan(
                        text: "Hola, ",
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                        children: [
                          TextSpan(text: "Michael", style: TextStyle(fontWeight: FontWeight.w400))
                        ]),
                  ),
                ),
                const Text(
                  "Te tenemos exelentes noticias para ti",
                  style: TextStyle(color: AppTextColors.white, fontSize: 11),
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
              AssetsPath.processCircle,
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
      height: size.height * .4,
      decoration: const BoxDecoration(
          color: AppColors.blueSecondary,
          borderRadius:
              BorderRadius.only(bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            children: [
              const Text(
                "56271.68",
                style: TextStyle(color: AppTextColors.white),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("+9,736", style: TextStyle(color: AppTextColors.white)),
                  Row(
                    children: const [
                      Icon(
                        Icons.arrow_upward_sharp,
                        color: AppTextColors.green,
                      ),
                      Text(
                        "2.3%",
                        style: TextStyle(color: AppTextColors.green),
                      )
                    ],
                  )
                ],
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
              const VerticalDivider(
                  color: AppTextColors.white30, width: 10, thickness: 3, endIndent: 20),
              panelBottomBlock("36", "Transaction"),
              const VerticalDivider(),
              panelBottomBlock("4", "Bills"),
            ],
          )
        ],
      ),
    );
  }

  Column panelBottomBlock(
    String title,
    String subTitle,
  ) {
    return Column(
      children: [Text(title), Text(subTitle)],
    );
  }
}
