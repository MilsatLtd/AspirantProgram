// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:milsat_project_app/aspirant/screens/Blocker/comments_page.dart';
import 'package:milsat_project_app/extras/components/files.dart';
import 'package:milsat_project_app/extras/components/shared_prefs/keys.dart';
import 'package:milsat_project_app/extras/components/shared_prefs/utils.dart';
import 'package:milsat_project_app/extras/models/decoded_token.dart';

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
        return GestureDetector(
          onTap: () async {
            DecodedTokenResponse? decodedTokenResponse =
                await SecureStorageUtils.getDataFromStorage<
                        DecodedTokenResponse>(SharedPrefKeys.tokenResponse,
                    DecodedTokenResponse.fromJsonString);
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              blockerID = '${cred['blockers'][index]['blocker_id']}';
              return CommentsPage(
                description: '${resolvedList[index]['description']}',
                title: '${resolvedList[index]['title']}',
                userName: '${resolvedList[index]['user_name']}',
                blockerId: '${resolvedList[index]['blocker_id']}',
                trackId: '${resolvedList[index]['track']}',
                userId: '${resolvedList[index]['user']}',
                status: resolvedList[index]['status'],
                currentUser: decodedTokenResponse?.userId ?? '',
                time: '',
                comments: [],
              );
            }));
          },
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 16,
            ),
            color: AppTheme.kAppWhiteScheme,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
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
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 4,
                ),
                Row(
                  children: [
                    Text(
                      resolvedList[index]['user_name'],
                      style: kTrackTextStyle,
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Text(
                      '24 min ago',
                      style: kTimeTextStyle,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'Hi everyone,\n'
                  '${resolvedList[index]['description']}',
                  style: GoogleFonts.raleway(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFF504D51),
                      height: 2),
                ),
              ],
            ),
          ),
        );
      }),
      itemCount: resolvedList.length,
      separatorBuilder: (BuildContext context, int index) {
        return const SizedBox(
          height: 6,
        );
      },
    );
  }
}
