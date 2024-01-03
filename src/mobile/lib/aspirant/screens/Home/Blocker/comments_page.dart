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
          preferredSize: const Size.fromHeight(44),
          child: AppBar(
            backgroundColor: Colors.white,
            title: Text(
              'Comments',
              style: GoogleFonts.raleway(
                color: const Color(0xFF423B43),
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            centerTitle: true,
            elevation: 0.5,
            leading: GestureDetector(
              onTap: () => AppNavigator.pop(),
              child: const Icon(
                Icons.arrow_back,
                color: Colors.black,
                size: 24,
              ),
            ),
          ),
        ),
        body: mentorComments.when(
            data: (data) {
              return Column(
                children: [
                  Container(
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
                                      fontSize: 10,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        Row(
                          children: [
                            Text(
                              userName,
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
                          '$description',
                          style: GoogleFonts.raleway(
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xFF504D51),
                              height: 2),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: data.data.isNotEmpty
                        ? ListView.separated(
                            itemBuilder: (context, index) {
                              return Container(
                                width: 200,
                                alignment: Alignment.centerRight,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 16,
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
                                        fontSize: 13,
                                        fontWeight: FontWeight.w500,
                                        color: const Color(0xFF504D51),
                                        height: 2,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                            separatorBuilder: (context, index) {
                              return const SizedBox(
                                height: 6,
                              );
                            },
                            itemCount: data.data.length,
                          )
                        : Center(
                            child: Text(
                              'Awaiting review... check back!',
                              style: GoogleFonts.raleway(
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                                color: const Color(0xFF504D51),
                                height: 2,
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
