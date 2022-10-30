import 'package:flutter/material.dart';

import '../constants/assets_path.dart';
import '../constants/colors.dart';

class BuildAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  const BuildAppBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_rounded, color: AppTextColors.black),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      title: const Text(
        "My Saved Card",
        style: TextStyle(color: AppTextColors.black),
      ),
      actions: [
        Image.asset(
          AssetsPath.menu,
          scale: 1.3,
        )
      ],
    );
  }
}
