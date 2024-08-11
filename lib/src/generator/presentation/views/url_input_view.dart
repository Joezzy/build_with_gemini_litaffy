import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:littafy/custom/btn.dart';
import 'package:littafy/custom/txt.dart';
import 'package:littafy/src/generator/presentation/controller/generator_controller.dart';
import 'package:littafy/utils/size_config.dart';

class UrlInputView extends StatefulWidget {
  const UrlInputView({
    super.key,
    this.isInputView = true,
  });

  final bool isInputView;
  @override
  State<UrlInputView> createState() => _UrlInputViewState();
}

class _UrlInputViewState extends State<UrlInputView> {
  final generatorController = Get.put(GeneratorController());
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Article  url"),
          Txt(
            hintText: "Enter a valid url",
            hintColor: Colors.grey,
            controller: generatorController.urlInputController.value,
          ),
          SizedBox(
            height: MySize.size20,
          ),
          generatorController.isLoading.value
              ? const Center(child: CupertinoActivityIndicator())
              : FillButton(
                  text: "Get text",
                  enabled: true,
                  onPressed: () {
                    // Navigator.pop(context);
                    generatorController.getArticleMethod(
                        context, widget.isInputView);
                  })
        ],
      ),
    );
  }
}
