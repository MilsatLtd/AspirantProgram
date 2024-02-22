// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:milsat_project_app/aspirant/screens/Blocker/comments_page.dart';
import 'package:milsat_project_app/extras/components/files.dart';
import '../../../extras/api/blockers_api.dart';

final allBlockers = FutureProvider.autoDispose((ref) {
  return ref.read(apiBlockerServiceProvider).getRaisedBlockers();
});

Map<int, String> status = {
  0: 'Pending',
  1: 'Resolved',
};

List pendingList = [];
List resolvedList = [];

getPendngAndResolvedList() {
  pendingList = [];
  resolvedList = [];
  if (cred['blockers'] != null) {
    for (var i in cred['blockers']) {
      if (i['status'] == 0 && !pendingList.contains(i['blocker_id'])) {
        pendingList.add(i);
      } else if (i['status'] == 0 && pendingList.contains(i['blocker_id'])) {
        return pendingList;
      } else if (i['status'] == 1 && !pendingList.contains(i)) {
        resolvedList.add(i);
      } else {
        return;
      }
    }
  }
}

class AllBlockers extends ConsumerWidget {
  const AllBlockers({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final allBlockersData = ref.watch(allBlockers);

    void onDeleted(index) {
      ref
          .read(apiBlockerServiceProvider)
          .deleteBlocker(cred['blockers'][index]['blocker_id']);
    }

    return allBlockersData.when(
      data: (data) {
        getPendngAndResolvedList();
        return ListView.separated(
          itemBuilder: ((context, index) {
            String time = cred['blockers'][index]['created_at'];
            DateTime p = DateTime.parse(time);
            DateTime now = DateTime.now();

            final duration = now.difference(p);
            final timeAgo = duration.inDays;
            return GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  blockerID = '${cred['blockers'][index]['blocker_id']}';
                  return CommentsPage(
                    description: '${cred['blockers'][index]['description']}',
                    title: '${cred['blockers'][index]['title']}',
                    userName: '${cred['blockers'][index]['user_name']}',
                    blockerId: '${cred['blockers'][index]['blocker_id']}',
                    trackId: '${cred['blockers'][index]['track']}',
                    userId: '${cred['blockers'][index]['user']}',
                  );
                }));
              },
              child: Slidable(
                startActionPane: ActionPane(
                  motion: const StretchMotion(),
                  children: [
                    Consumer(
                      builder: (context, ref, child) {
                        return SlidableAction(
                          onPressed: (context) => onDeleted(index),
                          backgroundColor: Colors.red,
                          icon: Icons.delete,
                          label: 'Delete',
                        );
                      },
                    ),
                  ],
                ),
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
                            '${cred['blockers'][index]['title']}',
                            style: kOnboardingLightTextStyle,
                          ),
                          Row(
                            children: [
                              cred['blockers'][index]['status'] == 0
                                  ? SvgPicture.asset('assets/double_mark.svg')
                                  : const SizedBox.shrink(),
                              Text(
                                cred['blockers'][index]['status'] == 0
                                    ? status[0] as String
                                    : status[1] as String,
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
                            '${cred['blockers'][index]['user_name']}',
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
                        '${cred['blockers'][index]['description']}',
                        style: GoogleFonts.raleway(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xFF504D51),
                          height: 2,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
          itemCount: cred['blockers'] == null ? 0 : cred['blockers'].length,
          separatorBuilder: (BuildContext context, int index) {
            return const SizedBox(
              height: 6,
            );
          },
        );
      },
      error: (((error, stackTrace) => Text(error.toString()))),
      loading: () {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
