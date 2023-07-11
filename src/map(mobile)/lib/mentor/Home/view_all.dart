import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:milsat_project_app/extras/components/files.dart';

class ViewAllPage extends StatelessWidget {
  const ViewAllPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(44.h),
        child: AppBar(
          title: Text(
            'View recent activities',
            style: GoogleFonts.raleway(
              color: const Color(0xFF423B43),
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          backgroundColor: AppTheme.kAppWhiteScheme,
          elevation: 0.5,
          centerTitle: true,
          leading: IconButton(
            onPressed: () {
              AppNavigator.doPop();
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 16.w,
        ),
        child: ListView.separated(
          padding: EdgeInsets.symmetric(
            vertical: 16.h,
          ),
          physics: const AlwaysScrollableScrollPhysics(
            parent: BouncingScrollPhysics(),
          ),
          itemBuilder: (BuildContext context, int index) {
            String time = cred['blockers'][index]['created_at'];
            DateTime p = DateTime.parse(time);
            DateTime now = DateTime.now();

            final duration = now.difference(p);
            final timeAgo = duration.inDays;
            return Container(
              padding: EdgeInsets.symmetric(
                horizontal: 16.w,
                vertical: 16.w,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6.r),
                color: AppTheme.kAppWhiteScheme,
                border: Border.all(
                  color: const Color(0xFFCBADCD),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${cred['blockers'][index]['title']}',
                    style: kOnboardingLightTextStyle,
                  ),
                  SizedBox(
                    height: 4.h,
                  ),
                  Row(
                    children: [
                      Text(
                        '${cred['blockers'][index]['user_name']}',
                        style: kTrackTextStyle,
                      ),
                      SizedBox(
                        width: 8.w,
                      ),
                      Text(
                        '$timeAgo days ago',
                        style: kTimeTextStyle,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Text(
                    'Hi everyone,\n'
                    '${cred['blockers'][index]['description']}',
                    overflow: TextOverflow.ellipsis,
                    maxLines: 8,
                    style: GoogleFonts.raleway(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFF504D51),
                      height: 1.75.h,
                    ),
                  ),
                ],
              ),
            );
          },
          separatorBuilder: (BuildContext context, int index) => SizedBox(
            height: 16.h,
          ),
          itemCount: cred['blockers'].length,
        ),
      ),
      bottomNavigationBar: const CustomNavBar(),
    );
  }
}
