import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:milsat_project_app/extras/components/files.dart';

class Resolved extends StatelessWidget {
  const Resolved({super.key});

  @override
  Widget build(BuildContext context) {
    if (resolvedList.isEmpty) {
      return Center(
        child: Text(
          'No resolved blockers yet...',
          style: GoogleFonts.raleway(
            color: Colors.black,
          ),
        ),
      );
    }
    return ListView.separated(
      itemBuilder: ((context, index) {
        return Container(
          padding: EdgeInsets.symmetric(
            horizontal: 16.w,
            vertical: 16.w,
          ),
          color: AppTheme.kAppWhiteScheme,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {},
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      resolvedList[index]['title'],
                      style: kOnboardingLightTextStyle,
                    ),
                    Row(
                      children: [
                        SvgPicture.asset('assets/double_mark.svg'),
                        Text(
                          status[1]!,
                          style: GoogleFonts.raleway(
                            color: const Color(0xFF11A263),
                            fontSize: 10.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 4.h,
              ),
              Row(
                children: [
                  Text(
                    resolvedList[index]['user_name'],
                    style: kTrackTextStyle,
                  ),
                  SizedBox(
                    width: 8.w,
                  ),
                  Text(
                    '24 min ago',
                    style: kTimeTextStyle,
                  ),
                ],
              ),
              SizedBox(
                height: 10.h,
              ),
              Text(
                'Hi everyone,\n'
                '${resolvedList[index]['description']}',
                style: GoogleFonts.raleway(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF504D51),
                    height: 2.h),
              ),
            ],
          ),
        );
      }),
      itemCount: resolvedList.length,
      separatorBuilder: (BuildContext context, int index) {
        return SizedBox(
          height: 6.h,
        );
      },
    );
  }
}
