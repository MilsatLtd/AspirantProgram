import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:milsat_project_app/aspirant/screens/Blocker/comments_page.dart';
import 'package:milsat_project_app/extras/api/blockers_api.dart';
import 'package:milsat_project_app/extras/components/files.dart';
import 'package:milsat_project_app/extras/components/shared_prefs/keys.dart';
import 'package:milsat_project_app/extras/components/shared_prefs/utils.dart';
import 'package:milsat_project_app/extras/models/decoded_token.dart';

import '../../../mentor/more/blocker/reply_blocker.dart';

String blockerID = '';

class Pending extends ConsumerStatefulWidget {
  const Pending({super.key});

  @override
  ConsumerState<Pending> createState() => _PendingState();
}

class _PendingState extends ConsumerState<Pending> {
  getUserData() async {
    loginResponse =
        await SecureStorageUtils.getDataFromStorage<DecodedTokenResponse>(
            SharedPrefKeys.tokenResponse, DecodedTokenResponse.fromJsonString);
  }

  @override
  void initState() {
    super.initState();
    getUserData();
  }

  @override
  Widget build(BuildContext context) {
    // String status = 'Resolve';
    if (pendingList.isNotEmpty) {
      return Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text('Tap blocker below'),
          ),
          Expanded(
            child: ListView.separated(
              itemBuilder: ((context, index) {
                String time = pendingList[index]['created_at'];
                DateTime p = DateTime.parse(time);
                DateTime now = DateTime.now();

                final duration = now.difference(p);
                final timeAgo = duration.inDays;
                return GestureDetector(
                  onTap: () async {
                    if (loginResponse?.role == 1) {
                      String time = pendingList[index]['created_at'];
                      DateTime p = DateTime.parse(time);
                      DateTime now = DateTime.now();

                      final duration = now.difference(p);
                      final timeAgo = duration.inDays;
                      final comments = await ref
                          .read(apiBlockerServiceProvider)
                          .getCommentsById(pendingList[index]['blocker_id']);
                      // ignore: use_build_context_synchronously
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return ReplyBlocker(
                          description: '${pendingList[index]['description']}',
                          title: '${pendingList[index]['title']}',
                          userName: '${pendingList[index]['user_name']}',
                          blockerId: '${pendingList[index]['blocker_id']}',
                          time: '$timeAgo',
                          trackId: '${pendingList[index]['track']}',
                          comments: comments,
                        );
                      }));
                    } else {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        blockerID = '${pendingList[index]['blocker_id']}';
                        return CommentsPage(
                          description: '${pendingList[index]['description']}',
                          title: '${pendingList[index]['title']}',
                          userName: '${pendingList[index]['user_name']}',
                          blockerId: '${pendingList[index]['blocker_id']}',
                          trackId: '${pendingList[index]['track']}',
                          userId: '${pendingList[index]['user']}',
                        );
                      }));
                    }
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
                        GestureDetector(
                          onTap: () {},
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                pendingList[index]['title'],
                                style: kOnboardingLightTextStyle,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        Row(
                          children: [
                            Text(
                              pendingList[index]['user_name'],
                              style: kTrackTextStyle,
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            Text(
                              '$timeAgo days ago',
                              style: kTimeTextStyle,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Hi everyone,\n'
                          '${pendingList[index]['description']}',
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
              itemCount: pendingList.length,
              separatorBuilder: (BuildContext context, int index) {
                return const SizedBox(
                  height: 6,
                );
              },
            ),
          ),
        ],
      );
    } else {
      return const Center(
        child: Text('No pending blockers yet..'),
      );
    }
  }
}
