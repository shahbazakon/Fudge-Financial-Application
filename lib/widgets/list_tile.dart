import 'package:flutter/material.dart';

import '../constants/assets_path.dart';
import '../constants/colors.dart';

class TransactionListTile extends StatefulWidget {
  final String? leading;
  final String? title;
  final String? subTitle;
  final String? trallingTitle;
  final String? trallingSubTitle;
  final String? trallingIcon;
  const TransactionListTile({
    Key? key,
    this.leading,
    this.title,
    this.subTitle,
    this.trallingTitle,
    this.trallingSubTitle,
    this.trallingIcon,
  }) : super(key: key);

  @override
  State<TransactionListTile> createState() => _TransactionListTileState();
}

class _TransactionListTileState extends State<TransactionListTile> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Image.asset(AssetsPath.user, scale: 1.5),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 5),
                child: Text(widget.title!,
                    style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 15)),
              ),
              Text(widget.subTitle!, style: const TextStyle(color: AppTextColors.black26))
            ],
          ),
          const Spacer(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 5),
                child: Text(widget.trallingTitle!,
                    style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 15)),
              ),
              Text(
                widget.trallingSubTitle!,
                style: const TextStyle(color: AppTextColors.black26),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Image.asset(widget.trallingIcon!, scale: 1.3),
          )
        ],
      ),
    );
  }
}
