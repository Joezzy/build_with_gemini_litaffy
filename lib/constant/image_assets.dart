import 'package:flutter/material.dart';
import 'package:littafy/constant/constants.dart';

class LoadImage {
  static preLoadImages(context) {
    precacheImage(const AssetImage("${assetImage}splash.png"), context);
    precacheImage(const AssetImage("${assetImage}slide1.png"), context);
    precacheImage(const AssetImage("${assetImage}slide2.png"), context);
    precacheImage(const AssetImage("${assetImage}slide3.png"), context);
    precacheImage(const AssetImage("${assetImage}refer.png"), context);
    precacheImage(const AssetImage("${assetImage}refer_back.png"), context);
    precacheImage(const AssetImage("${assetImage}marker.png"), context);
    precacheImage(const AssetImage("${assetImage}recent.png"), context);
    precacheImage(const AssetImage("${assetImage}req_car.png"), context);
    precacheImage(const AssetImage("${assetImage}req_bike.png"), context);
    precacheImage(const AssetImage("${assetImage}req_van.png"), context);
    precacheImage(const AssetImage("${assetImage}req_truck.png"), context);
    precacheImage(const AssetImage("${assetImage}my_location.png"), context);
    precacheImage(const AssetImage("${assetImage}is-express.png"), context);
  }
}
