import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fudge_finance/services/API_services.dart';

import '../constants/assets_path.dart';
import '../constants/colors.dart';
import '../models/users_model.dart';
import '../widgets/list_tile.dart';

class TabScreen1 extends StatefulWidget {
  const TabScreen1({Key? key}) : super(key: key);

  @override
  State<TabScreen1> createState() => _TabScreen1State();
}

class _TabScreen1State extends State<TabScreen1> {
  List<Users>? topUserList;
  getUser() async {
    topUserList = await APIServices().getTopUsers();
    if (topUserList != null) {
      return topUserList;
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        sectionHeadline("Recent Transaction"),
        FutureBuilder(
          future: getUser(),
          builder: (context, snapshot) {
            return snapshot.hasData
                ? Expanded(
                    child: ListView.builder(
                    physics: const AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
                    itemCount: topUserList!.length,
                    itemBuilder: (context, index) {
                      log("topUserList: ${topUserList![index]}");
                      return TransactionListTile(
                        leading: AssetsPath.user,
                        title: topUserList![index].name,
                        subTitle: topUserList![index].address?.city,
                        trallingTitle: "80,000 AED",
                        trallingSubTitle: "11 Aug 2021",
                        trallingIcon: AssetsPath.processCircle,
                      );
                    },
                  ))
                : const CircularProgressIndicator(
                    color: AppColors.blueSecondary,
                  );
          },
        )
      ],
    );
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
}
