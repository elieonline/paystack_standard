import 'package:flutter/material.dart';

class XWarningDialog extends StatelessWidget {
  final String positive;
  final String negative;
  final String title;
  final String description;

  final Function() onPositive;
  final Function() onNegative;

  const XWarningDialog(
      {super.key,
      required this.onNegative,
      required this.onPositive,
      required this.description,
      this.negative = "No",
      required this.positive,
      required this.title});

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Column(
          children: [
            Text(
              title,
              style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            Container(
              height: 16,
            ),
            Text(
              description,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
            ),
            Container(
              height: 24,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                    onPositive();
                  },
                  child: Text(
                    positive,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 16),
                  ),
                ),
                Container(
                  width: 32,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                    onNegative();
                  },
                  child: Text(negative,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                          fontSize: 16)),
                )
              ],
            )
          ],
        ),
      );
}
