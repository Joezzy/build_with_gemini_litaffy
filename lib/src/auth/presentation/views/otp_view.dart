// import 'package:flutter/gestures.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// class OtpView extends StatefulWidget {
//   final String email;
//   final String password;
//   final String otp;
//   final String accountCreationToken;
//   const OtpView(
//       {super.key,
//       required this.email,
//       required this.password,
//       required this.otp,
//       required this.accountCreationToken});
//
//   @override
//   State<OtpView> createState() => _OtpViewState();
// }
//
// class _OtpViewState extends State<OtpView> {
//   final otpViewController = Get.put(OtpViewController());
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     otpViewController.setVar(context, widget.email, widget.password, widget.otp,
//         widget.accountCreationToken);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: ListView(
//         children: [
//           const SizedBox(
//             height: 50,
//           ),
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Text(
//               "Verify Your Account",
//               textAlign: TextAlign.center,
//               style: TextStyle(
//                   fontWeight: FontWeight.bold,
//                   fontSize: MySize.size30,
//                   color: AppTheme.black),
//             ),
//           ),
//           otpForm(),
//         ],
//       ),
//     );
//   }
//
//   SingleChildScrollView otpForm() {
//     return SingleChildScrollView(
//       padding: EdgeInsets.only(
//         left: MySize.size20,
//         right: MySize.size20,
//       ),
//       // margin: EdgeInsets.only(top: MySize.size250),
//       physics: const NeverScrollableScrollPhysics(),
//       child: Obx(
//         () => Form(
//           key: otpViewController.otpFormKey,
//           child: Column(
//             children: [
//               Padding(
//                 padding: EdgeInsets.symmetric(
//                     vertical: MySize.size20, horizontal: 15),
//                 child: Text(
//                   "A 6-digit code has been sent to your email address "
//                   "\n${otpViewController.email.replaceAll(RegExp(r'.(?=.{11})'), '*')}",
//                   // "\n${otpViewController.email.replaceRange(0, 4, "****")}",
//                   // "*****ame@gmail.com",
//                   style: TextStyle(fontSize: MySize.size14),
//                   textAlign: TextAlign.center,
//                 ),
//               ),
//               const SizedBox(
//                 height: 20,
//               ),
//               if (otpViewController.showCountDown.value)
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Text(
//                       "Enter the code within",
//                       style: TextStyle(
//                           color: AppTheme.black,
//                           fontSize: MySize.size15,
//                           fontFamily: 'Raleway'),
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         SlideCountdown(
//                           separator: ":",
//                           decoration:
//                               const BoxDecoration(color: Colors.transparent),
//                           textStyle:
//                               const TextStyle(color: AppTheme.primaryColor),
//                           duration: Duration(
//                               seconds: otpViewController.countDown.value),
//                           onChanged: (val) {
//                             print(val);
//                           },
//                           onDone: () {
//                             otpViewController.showCountDown.value = false;
//                           },
//                         ),
//                         const Text(
//                           "mins",
//                           style: TextStyle(color: AppTheme.primaryColor),
//                         )
//                       ],
//                     ),
//                   ],
//                 ),
//               const SizedBox(
//                 height: 20,
//               ),
//               Pinput(
//                 length: 6,
//                 defaultPinTheme: PinTheme(
//                   width: 35,
//                   height: 35,
//                   textStyle:
//                       const TextStyle(fontSize: 14, color: AppTheme.black),
//                   decoration: BoxDecoration(
//                     border: Border.all(color: Colors.grey),
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                 ),
//                 controller: otpViewController.otpEditController.value,
//                 validator: (val) {
//                   print(otpViewController.otp.value);
//                   print(otpViewController.otpEditController.value);
//                   // return s == '2222' ? null : 'Pin is incorrect';
//                   if (val == otpViewController.otp.value) {
//                     print(val);
//                     otpViewController.completeSetUpMethod(context);
//                   } else {
//                     return 'OTP is incorrect';
//                   }
//                 },
//                 pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
//                 showCursor: true,
//                 onCompleted: (pin) => print(pin),
//               ),
//               const SizedBox(
//                 height: 50,
//               ),
//               Container(
//                 padding: EdgeInsets.symmetric(horizontal: MySize.size20),
//                 child: RichText(
//                   textAlign: TextAlign.center,
//                   text: TextSpan(
//                     children: [
//                       TextSpan(
//                         text: "Didn't receive a code?",
//                         style: TextStyle(
//                             color: AppTheme.black,
//                             fontSize: MySize.size15,
//                             fontFamily: 'Raleway'),
//                       ),
//                       TextSpan(
//                         text: otpViewController.isLoadingResend.value
//                             ? "  Loading..."
//                             : ' Resend code ',
//                         style: TextStyle(
//                             color: otpViewController.showCountDown.value
//                                 ? AppTheme.grey
//                                 : AppTheme.primaryColor,
//                             fontSize: MySize.size15,
//                             fontFamily: 'Raleway'),
//                         recognizer: TapGestureRecognizer()
//                           ..onTap = () {
//                             if (!otpViewController.showCountDown.value) {
//                               otpViewController.requestOtpMethod(context);
//                             }
//                           },
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               const SizedBox(
//                 height: 30,
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   //
//   // final defaultPinTheme =   PinTheme(
//   //   width: 56,
//   //   height: 56,
//   //   textStyle:  const TextStyle(fontSize: 20, color: Color.fromRGBO(30, 60, 87, 1),
//   //       fontWeight: FontWeight.w600),
//   //   decoration:   BoxDecoration(
//   //     // border:  Border.all(color: const Color.fromRGBO(234, 239, 243, 1)),
//   //     borderRadius:  BorderRadius.circular(20),
//   //   ),
//   // );
// }
