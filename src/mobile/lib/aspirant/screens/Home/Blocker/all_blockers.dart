import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:milsat_project_app/extras/components/files.dart';
import '../../../../extras/api/blockers_api.dart';

final allBlockers = FutureProvider((ref) {
  return ref.read(blockerProvider).getRaisedBlockers();
});

Map<int, String> status = {
  0: 'Pending',
  1: 'Resolved',
};

List pendingList = [];
List resolvedList = [];

getPendngAndResolvedList() {
  if (cred['blockers'] != null) {
    for (var i in cred['blockers']) {
      if (i['status'] == 0 && !pendingList.contains(i)) {
        pendingList.add(i);
      } else if (i['status'] == 0 && pendingList.contains(i)) {
        return;
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
            return Container(
              padding: EdgeInsets.symmetric(
                horizontal: 16.w,
                vertical: 16.w,
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
                              fontSize: 10.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ],
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
                    style: GoogleFonts.raleway(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFF504D51),
                      height: 2.h,
                    ),
                  ),
                ],
              ),
            );
          }),
          itemCount: cred['blockers'] == null ? 0 : cred['blockers'].length,
          separatorBuilder: (BuildContext context, int index) {
            return SizedBox(
              height: 6.h,
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
