import 'package:flutter/material.dart';
import 'package:milsat_project_app/extras/components/files.dart';

class CohortCard extends StatelessWidget {
  const CohortCard({
    super.key,
    this.height,
    required this.width,
    required this.radius,
    required this.first,
    required this.second_1,
    required this.second_2,
    required this.third,
    required this.forth_1,
    required this.forth_2,
    required this.forthHeight,
    required this.thirdHeight,
    required this.secondHeight,
  });

  final double? height;
  final double width;
  final double first;
  final double second_1;
  final double second_2;
  final double secondHeight;
  final double third;
  final double thirdHeight;
  final double forth_1;
  final double forth_2;
  final double forthHeight;

  final BorderRadiusGeometry? radius;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
            color: AppTheme.kPurpleColor2,
            borderRadius: radius,
          ),
        ),
        Positioned(
          top: first,
          child: SvgPicture.asset(
            'assets/deco1.svg',
            colorFilter: ColorFilter.mode(
              const Color(0XFFCBADCD).withOpacity(0.05),
              BlendMode.srcIn,
            ),
          ),
        ),
        Positioned(
          right: second_1,
          top: second_2,
          child: SvgPicture.asset(
            'assets/deco2.svg',
            height: secondHeight,
            colorFilter: ColorFilter.mode(
              const Color(0XFFCBADCD).withOpacity(0.05),
              BlendMode.srcIn,
            ),
          ),
        ),
        Positioned(
          top: third,
          child: SvgPicture.asset(
            'assets/deco3.svg',
            height: thirdHeight,
            colorFilter: ColorFilter.mode(
              const Color(0XFFCBADCD).withOpacity(0.05),
              BlendMode.srcIn,
            ),
          ),
        ),
        Positioned(
          right: forth_1,
          bottom: forth_2,
          child: SvgPicture.asset(
            'assets/deco4.svg',
            height: forthHeight,
            colorFilter: ColorFilter.mode(
              const Color(0XFFCBADCD).withOpacity(0.05),
              BlendMode.srcIn,
            ),
          ),
        ),
      ],
    );
  }
}
