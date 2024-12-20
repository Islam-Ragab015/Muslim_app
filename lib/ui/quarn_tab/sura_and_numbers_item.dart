// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:islami_app/ui/quarn_tab/sura_model.dart';
import 'package:islami_app/ui/quarn_tab/sura_screen.dart';

class SuraNumberItem extends StatelessWidget {
  String suraName;
  int suraNumbers;
  int index;
  SuraNumberItem(this.suraName, this.index, this.suraNumbers, {super.key});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, SuraScreen.routeName,
            arguments: SuraModel(suraName, index));
      },
      child: IntrinsicHeight(
        child: Row(
          children: [
            Expanded(
              child: Text(
                  textAlign: TextAlign.center,
                  "$suraNumbers",
                  style: const TextStyle(
                      fontSize: 25, fontWeight: FontWeight.bold)),
            ),
            VerticalDivider(
              color: Theme.of(context).primaryColor,
              thickness: 2,
            ),
            Expanded(
              child: Text(
                suraName,
                textAlign: TextAlign.center,
                style:
                    const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
