import 'package:flutter/cupertino.dart';

class TextForValueSection extends StatelessWidget {
  const TextForValueSection({Key? key, required this.firstText, required this.secondText}) : super(key: key);
final String firstText;
final String secondText;
  @override
  Widget build(BuildContext context) {
    return  Row(
      children:  [
        Expanded(
            child: Text(
              firstText,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            )),
        Text(
          secondText,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
