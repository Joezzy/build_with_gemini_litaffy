import 'package:flutter/material.dart';
import 'package:littafy/constant/constants.dart';
import 'package:littafy/utils/size_config.dart';

class FrameTwo extends StatefulWidget {
  const FrameTwo({Key? key}) : super(key: key);

  @override
  State<FrameTwo> createState() => _FrameTwoState();
}

class _FrameTwoState extends State<FrameTwo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          child: Center(
              child: Column(
        children: [
          Spacer(),
          Image.asset("${assetImage}slide2.png"),
          // SizedBox(height: MySize.size50,),

          Spacer(),
          Text(
            "Confirm ride",
            textAlign: TextAlign.center,
            style:
                TextStyle(fontWeight: FontWeight.w500, fontSize: MySize.size20),
          ),
          SizedBox(
            height: MySize.size50,
          ),
        ],
      ))),
    );
  }
}
