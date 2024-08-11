import 'package:flutter/material.dart';

import '../../../../../utils/size_config.dart';

class FrameOne extends StatelessWidget {
  // final String image;
  final Widget body;
  final Widget image;
  const FrameOne({
    Key? key,
    required this.image,
    required this.body,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          // color: AppTheme.white,
          child: Center(
              child: Column(
        children: [
          image,
          Container(
            padding: EdgeInsets.symmetric(horizontal: MySize.size20),
            child: body,
          ),
        ],
      ))),
    );
  }
}
