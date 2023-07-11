import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:milsat_project_app/extras/api/blockers_api.dart';

import '../../../../extras/components/files.dart';

final mentorComment = FutureProvider((ref) {
  return ref.read(blockerProvider).getCommentsById(blockerID);
});

class CommentsPage extends ConsumerWidget {
  const CommentsPage({
    super.key,
    required this.title,
    required this.description,
    required this.userName,
    required this.trackId,
    required this.userId,
    required this.blockerId,
  });

  final String title;
  final String description;
  final String userName;
  final String trackId;
  final String userId;
  final String blockerId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String status = 'Resolve';

    final mentorComments = ref.watch(mentorComment);

    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(44.h),
          child: AppBar(
            backgroundColor: Colors.white,
            title: Text(
              'Comments',
              style: GoogleFonts.raleway(
                color: const Color(0xFF423B43),
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            centerTitle: true,
            elevation: 0.5,
            leading: GestureDetector(
              onTap: () => AppNavigator.pop(),
              child: Icon(
                Icons.arrow_back,
                color: Colors.black,
                size: 24.sp,
              ),
            ),
          ),
        ),
        body: mentorComments.when(
            data: (data) {
              return Column(
                children: [
                  Container(
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
                              title,
                              style: kOnboardingLightTextStyle,
                            ),
                            GestureDetector(
                              onTap: () async {
                                // await ref.read(blockerProvider).resolveABlocker(
                                //     trackId: trackId,
                                //     userId: userId,
                                //     blockerId: blockerId,
                                //     description: description,
                                //     title: title,
                                //     status: 1);
                              },
                              child: Row(
                                children: [
                                  SvgPicture.asset('assets/double_mark.svg'),
                                  Text(
                                    status,
                                    style: GoogleFonts.raleway(
                                      color: const Color(0xFF11A263),
                                      fontSize: 10.sp,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 4.h,
                        ),
                        Row(
                          children: [
                            Text(
                              userName,
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
                          '$description',
                          style: GoogleFonts.raleway(
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xFF504D51),
                              height: 2.h),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: data.data.isNotEmpty
                        ? ListView.separated(
                            itemBuilder: (context, index) {
                              return Container(
                                width: 200.w,
                                alignment: Alignment.centerRight,
                                padding: EdgeInsets.symmetric(
                                  horizontal: 16.w,
                                  vertical: 16.w,
                                ),
                                // color: AppTheme.kAppWhiteScheme,
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Text(
                                      '${data.data[index]['sender_name']}',
                                      style: kTrackTextStyle,
                                    ),
                                    Text(
                                      'Hello $userName},\n'
                                      '${cred['blockerComments'][index]['message']}',
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
                            },
                            separatorBuilder: (context, index) {
                              return SizedBox(
                                height: 6.h,
                              );
                            },
                            itemCount: data.data.length,
                          )
                        : Center(
                            child: Text(
                              'Awaiting review... check back!',
                              style: GoogleFonts.raleway(
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w500,
                                color: const Color(0xFF504D51),
                                height: 2.h,
                              ),
                            ),
                          ),
                  )
                ],
              );
            },
            error: (((error, stackTrace) => Text(error.toString()))),
            loading: () {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }));
  }
}
