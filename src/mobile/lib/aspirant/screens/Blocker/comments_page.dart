import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:milsat_project_app/extras/api/blockers_api.dart';

import '../../../extras/components/files.dart';

final mentorComment = FutureProvider.autoDispose((ref) {
  return ref.read(apiBlockerServiceProvider).getCommentsById(blockerID);
});

class CommentsPage extends ConsumerStatefulWidget {
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
  ConsumerState<CommentsPage> createState() => _CommentsPageState();
}

class _CommentsPageState extends ConsumerState<CommentsPage> {
  @override
  Widget build(BuildContext context) {
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
                              widget.title,
                              style: kOnboardingLightTextStyle,
                            ),
                            GestureDetector(
                              onTap: () async {
                                await ref
                                    .read(apiBlockerServiceProvider)
                                    .resolveABlocker(
                                      trackId: widget.trackId,
                                      userId: widget.userId,
                                      blockerId: widget.blockerId,
                                      description: widget.description,
                                      title: widget.title,
                                      status: 1,
                                    );
                                showInSnackBar('Blocker Resolved Successfully');
                                AppNavigator.navigateToAndReplace(
                                    raiseABlocker);
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
                              widget.userName,
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
                          '${widget.description}',
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
                    child: data.isNotEmpty
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
                                      '${data[index].senderName}',
                                      style: kTrackTextStyle,
                                    ),
                                    Text(
                                      'Hello ${widget.userName}},\n'
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
                            itemCount: data.length,
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

  void showInSnackBar(String value) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(value),
        duration: const Duration(seconds: 5),
        dismissDirection: DismissDirection.up,
      ),
    );
  }
}
