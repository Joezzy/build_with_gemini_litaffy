import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:littafy/utils/size_config.dart';

class OptionTile extends StatelessWidget {
  const OptionTile({
    super.key,
    required this.text,
    required this.onTap,
  });

  final VoidCallback onTap;
  final String text;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Container(
          padding: EdgeInsets.all(MySize.size20),
          decoration: BoxDecoration(
              color: Colors.blue.withOpacity(0.5),
              borderRadius: BorderRadius.circular(10)),
          child: Row(
            children: [
              const Icon(Icons.picture_as_pdf_outlined),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(text).tr(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
