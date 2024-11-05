// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:milsat_project_app/aspirant/screens/Blocker/comments_page.dart';
import 'package:milsat_project_app/extras/components/files.dart';
import 'package:milsat_project_app/extras/components/shared_prefs/keys.dart';
import 'package:milsat_project_app/extras/components/shared_prefs/utils.dart';
import 'package:milsat_project_app/extras/models/aspirant_model.dart';
import 'package:milsat_project_app/extras/models/decoded_token.dart';
import 'package:milsat_project_app/mentor/more/blocker/reply_blocker.dart';
import '../../../extras/api/blockers_api.dart';

final allBlockers = FutureProvider.autoDispose((ref) async {
  AspirantModelClass? userData =
      await SharedPreferencesUtil.getModel<AspirantModelClass>(
          SharedPrefKeys.userData, (json) => AspirantModelClass.fromJson(json));
  return ref
      .read(apiBlockerServiceProvider)
      .getRaisedBlockersById(userData?.track?.trackId ?? '');
});

Map<int, String> status = {
  0: 'Pending',
  1: 'Resolved',
};

List pendingList = [];
List resolvedList = [];

class AllBlockers extends ConsumerStatefulWidget {
  static const String name = 'all-blockers';
  static const String route = '/all-blockers';
  const AllBlockers({super.key});

  @override
  ConsumerState<AllBlockers> createState() => _AllBlockersState();
}

class _AllBlockersState extends ConsumerState<AllBlockers> {
  void sortBlockersByDate(List blockers, {bool ascending = false}) {
    blockers.sort((a, b) {
      DateTime dateA = DateTime.parse(a['created_at']);
      DateTime dateB = DateTime.parse(b['created_at']);
      return ascending ? dateA.compareTo(dateB) : dateB.compareTo(dateA);
    });
  }

  Future<void> getPendingAndResolvedList() async {
    pendingList.clear();
    resolvedList.clear();

    if (cred['blockers'] != null) {
      sortBlockersByDate(cred['blockers']);
      for (var i in cred['blockers']) {
        if (i['status'] == 0 && !pendingList.contains(i['blocker_id'])) {
          pendingList.add(i);
        } else if (i['status'] == 0 && pendingList.contains(i['blocker_id'])) {
          continue;
        } else if (i['status'] == 1 && !resolvedList.contains(i)) {
          resolvedList.add(i);
        }
      }
    }
    setState(() {}); // Trigger UI update
  }

  @override
  Widget build(BuildContext context) {
    final allBlockersData = ref.watch(allBlockers);

    Future<void> onDeleted(index) async {
      ref
          .read(apiBlockerServiceProvider)
          .deleteBlocker(cred['blockers'][index]['blocker_id']);
    }

    return allBlockersData.when(
      data: (data) {
        if (cred['blockers'] != null) {
          // Sort blockers when data is loaded
          sortBlockersByDate(cred['blockers']);
        }
        getPendingAndResolvedList();

        return RefreshIndicator(
          onRefresh: () async {},
          child: ListView.separated(
            physics: const AlwaysScrollableScrollPhysics(),
            itemBuilder: ((context, index) {
              String time = cred['blockers'][index]['created_at'];
              DateTime p = DateTime.parse(time);
              DateTime now = DateTime.now();

              final duration = now.difference(p);
              final timeAgo = duration.inDays;

              return InkWell(
                onTap: () async {
                  DecodedTokenResponse? decodedTokenResponse =
                      await SharedPreferencesUtil.getModel<
                              DecodedTokenResponse>(
                          SharedPrefKeys.tokenResponse,
                          (json) => DecodedTokenResponse.fromJson(json));
                  final comments = await ref
                      .read(apiBlockerServiceProvider)
                      .getCommentsById(cred['blockers'][index]['blocker_id']);
                  if (decodedTokenResponse?.role == 1) {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return ReplyBlocker(
                        description:
                            '${cred['blockers'][index]['description']}',
                        title: '${cred['blockers'][index]['title']}',
                        userName: '${cred['blockers'][index]['user_name']}',
                        blockerId: '${cred['blockers'][index]['blocker_id']}',
                        time: '$timeAgo',
                        trackId: '${cred['blockers'][index]['track']}',
                        comments: comments,
                      );
                    }));
                  } else {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      blockerID = '${cred['blockers'][index]['blocker_id']}';
                      return CommentsPage(
                        description:
                            '${cred['blockers'][index]['description']}',
                        title: '${cred['blockers'][index]['title']}',
                        userName: '${cred['blockers'][index]['user_name']}',
                        blockerId: '${cred['blockers'][index]['blocker_id']}',
                        trackId: '${cred['blockers'][index]['track']}',
                        userId: '${cred['blockers'][index]['user']}',
                        status: cred['blockers'][index]['status'],
                        currentUser: decodedTokenResponse?.userId ?? '',
                        time: '$timeAgo',
                        comments: comments,
                      );
                    }));
                  }
                },
                child: Slidable(
                  startActionPane: ActionPane(
                    motion: const StretchMotion(),
                    children: [
                      Consumer(
                        builder: (context, ref, child) {
                          return SlidableAction(
                            onPressed: (context) async {
                              await onDeleted(index);
                              showInSnackBar(
                                  'Blocker Deleted Successfully', context);
                              return ref.refresh(allBlockers.future);
                            },
                            backgroundColor: Colors.red,
                            icon: Icons.delete,
                            label: 'Delete',
                          );
                        },
                      ),
                    ],
                  ),
                  child: Card(
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 16,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: AppTheme.kAppWhiteScheme,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '${cred['blockers'][index]['title']}',
                                style: kBlockerHeadingTextStyle,
                              ),
                              Row(
                                children: [
                                  cred['blockers'][index]['status'] == 0
                                      ? SvgPicture.asset(
                                          'assets/double_mark.svg',
                                          colorFilter: ColorFilter.mode(
                                            Colors.grey.shade500,
                                            BlendMode.srcIn,
                                          ),
                                        )
                                      : const SizedBox.shrink(),
                                  Text(
                                    cred['blockers'][index]['status'] == 0
                                        ? status[0] as String
                                        : status[1] as String,
                                    style: GoogleFonts.raleway(
                                      color:
                                          cred['blockers'][index]['status'] == 0
                                              ? Colors.grey.shade500
                                              : const Color(0xFF11A263),
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
                                style: kBlockerSubHeadingTextStyle,
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
                ),
              );
            }),
            itemCount: cred['blockers'] == null ? 0 : cred['blockers'].length,
            separatorBuilder: (BuildContext context, int index) {
              return const SizedBox(
                height: 6,
              );
            },
          ),
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

  void showInSnackBar(String value, BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          value,
          textAlign: TextAlign.center,
        ),
        duration: const Duration(seconds: 7),
        dismissDirection: DismissDirection.up,
      ),
    );
  }
}
