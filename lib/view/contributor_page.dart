import 'package:flutter/material.dart';
import 'package:Surveyors/res/constants/custom_textstyle.dart';

class ContributorPage extends StatelessWidget {
  const ContributorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          const SizedBox(
            height: 10.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                'Person',
                style: KTextStyle.regularDescFontStyle,
              ),
            ],
          ),
          const SizedBox(
            height: 10.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Contributor',
                style: KTextStyle.regularPolicyFontStyle,
              ),
              Text(
                'Employer',
                style: KTextStyle.bold14BFontStyle,
              ),
            ],
          ),
          const SizedBox(
            height: 20.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                'Currency',
                style: KTextStyle.regularDescFontStyle,
              ),
            ],
          ),
          const SizedBox(
            height: 10.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Plan Currency',
                style: KTextStyle.regularPolicyFontStyle,
              ),
              Text(
                'INR',
                style: KTextStyle.bold14BFontStyle,
              ),
            ],
          ),
          const SizedBox(
            height: 10.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Renewal Currency',
                style: KTextStyle.regularPolicyFontStyle,
              ),
              Text(
                'INR',
                style: KTextStyle.bold14BFontStyle,
              ),
            ],
          ),
          const SizedBox(
            height: 20.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                'Total',
                style: KTextStyle.regularDescFontStyle,
              ),
            ],
          ),
          const SizedBox(
            height: 10.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total Contributions',
                style: KTextStyle.regularPolicyFontStyle,
              ),
              Text(
                '\u{20B9} 72,502',
                style: KTextStyle.bold14BFontStyle,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
