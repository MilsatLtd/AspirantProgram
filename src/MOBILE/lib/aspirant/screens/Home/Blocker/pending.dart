import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:milsat_project_app/aspirant/screens/Home/Blocker/comments_page.dart';
import 'package:milsat_project_app/extras/components/files.dart';

import '../../../../mentor/more/blocker/reply_blocker.dart';

String blockerID = '';

class Pending extends StatelessWidget {
  const Pending({super.key});

  @override
  Widget build(BuildContext context) {
    // String status = 'Resolve';
    if (pendingList.isNotEmpty) {
      return ListView.separated(
        itemBuilder: ((context, index) {
          String time = pendingList[index]['created_at'];
          DateTime p = DateTime.parse(time);
          DateTime now = DateTime.now();

          final duration = now.difference(p);
          final timeAgo = duration.inDays;
          return GestureDetector(
            onTap: () {
              if (cred['role'] == 1) {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return ReplyBlocker(
                    description: '${cred['blockers'][index]['description']}',
                    title: '${cred['blockers'][index]['title']}',
                    userName: '${cred['blockers'][index]['user_name']}',
                    blockerId: '${cred['blockers'][index]['blocker_id']}',
                  );
                }));
              } else {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  blockerID = cred['blockers'][index]['blocker_id'];
                  return CommentsPage(
                    description: '${cred['blockers'][index]['description']}',
                    title: '${cred['blockers'][index]['title']}',
                    userName: '${cred['blockers'][index]['user_name']}',
                    blockerId: '${cred['blockers'][index]['blocker_id']}',
                    trackId: '${cred['blockers'][index]['track']}',
                    userId: '${cred['blockers'][index]['user']}',
                  );
                }));
              }
            },
            child: Container(
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
                          pendingList[index]['title'],
                          style: kOnboardingLightTextStyle,
                        ),
                        // if (cred['role'] != 1)
                        //   Row(
                        //     children: [
                        //       SvgPicture.asset('assets/double_mark.svg'),
                        //       Text(
                        //         status,
                        //         style: GoogleFonts.raleway(
                        //           color: const Color(0xFF11A263),
                        //           fontSize: 10.sp,
                        //           fontWeight: FontWeight.w600,
                        //         ),
                        //       ),
                        //     ],
                        //   ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 4.h,
                  ),
                  Row(
                    children: [
                      Text(
                        pendingList[index]['user_name'],
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
                    '${pendingList[index]['description']}',
                    style: GoogleFonts.raleway(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF504D51),
                        height: 2.h),
                  ),
                ],
              ),
            ),
          );
        }),
        itemCount: pendingList.length,
        separatorBuilder: (BuildContext context, int index) {
          return SizedBox(
            height: 6.h,
          );
        },
      );
    } else {
      return const Center(
        child: Text('No pending blockers yet..'),
      );
    }
  }
}
