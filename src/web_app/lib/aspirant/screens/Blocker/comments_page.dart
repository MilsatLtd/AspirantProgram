import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:milsat_project_app/extras/api/blockers_api.dart';
import 'package:milsat_project_app/extras/components/shared_prefs/keys.dart';
import 'package:milsat_project_app/extras/components/shared_prefs/utils.dart';
import 'package:milsat_project_app/extras/models/blocker_model.dart';
import 'package:milsat_project_app/extras/models/decoded_token.dart';

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
    required this.status,
    required this.currentUser,
    required this.time,
    required this.comments,
  });

  final String title;
  final String description;
  final String userName;
  final String trackId;
  final String userId;
  final String blockerId;
  final int status;
  final String currentUser;
  final String time;
  final List<BlockerCommentModel> comments;

  @override
  ConsumerState<CommentsPage> createState() => _CommentsPageState();
}

class _CommentsPageState extends ConsumerState<CommentsPage> {
  final textController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  bool textFieldEmpty = true;

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
              widget.status == 1 ? 'Comments' : 'Blocker',
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
                            if (widget.status == 0 &&
                                widget.userId == widget.currentUser) ...{
                              GestureDetector(
                                onTap: () async {
                                  try {
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
                                    AppNavigator.navigateToAndReplace(
                                        raiseABlocker);
                                  } finally {
                                    showInSnackBar(message[0]);
                                  }
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
                            }
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
                  if (widget.status == 1) ...{
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
                                        '${data[index].message}',
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
                                widget.status == 0
                                    ? 'Awaiting review... check back!'
                                    : 'No comment was given before resolving blocker',
                                style: GoogleFonts.raleway(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                  color: const Color(0xFF504D51),
                                  height: 2,
                                ),
                              ),
                            ),
                    )
                  } else ...{
                    Expanded(
                      child: widget.comments.isNotEmpty
                          ? ListView.builder(
                              controller: _scrollController,
                              itemCount: widget.comments.length,
                              itemBuilder: (context, index) {
                                return SizedBox(
                                  width: 250,
                                  child: Align(
                                    alignment:
                                        widget.comments[index].senderName ==
                                                loginResponse?.fullName
                                            ? Alignment.centerRight
                                            : Alignment.centerLeft,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        padding: const EdgeInsets.all(12),
                                        decoration: const BoxDecoration(
                                          color: AppTheme.kAppWhiteScheme,
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              '${widget.comments[index].senderName}',
                                              style: GoogleFonts.raleway(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w600,
                                                  color:
                                                      const Color(0xFF504D51),
                                                  height: 1.5),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 16),
                                              child: Text(
                                                'Hello ${widget.userName},\n'
                                                '${widget.comments[index].message}',
                                                style: GoogleFonts.raleway(
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.w500,
                                                  color:
                                                      const Color(0xFF504D51),
                                                  height: 2,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              })
                          : const SizedBox.shrink(),
                    ),
                    Row(
                      children: [
                        const SizedBox(width: 8),
                        Expanded(
                          child: TextFormField(
                            controller: textController,
                            minLines: 1,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'value cannot be null';
                              }
                              return null;
                            },
                            onChanged: (value) {
                              if (value.isNotEmpty) {
                                setState(() {
                                  textFieldEmpty = false;
                                });
                              } else {
                                setState(() {
                                  textFieldEmpty = true;
                                });
                              }
                            },
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 16,
                              ),
                              border: const OutlineInputBorder(
                                borderSide: BorderSide.none,
                              ),
                              focusedBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: AppTheme.kPurpleColor2,
                                ),
                              ),
                              hintText: 'Send feedback here......',
                              hintStyle: GoogleFonts.raleway(
                                color: const Color(
                                  0xFF9A989A,
                                ),
                                fontWeight: FontWeight.w500,
                                fontSize: 13,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Padding(
                          padding: const EdgeInsets.only(right: 16),
                          child: InkWell(
                            onTap: !textFieldEmpty
                                ? () async {
                                    DecodedTokenResponse? decodedToken =
                                        await SecureStorageUtils
                                            .getDataFromStorage<
                                                    DecodedTokenResponse>(
                                                SharedPrefKeys.tokenResponse,
                                                DecodedTokenResponse
                                                    .fromJsonString);
                                    final reply = await ref
                                        .read(apiBlockerServiceProvider)
                                        .replyABlocker(
                                          message: textController.text,
                                          userId: decodedToken!.userId!,
                                          blocker: widget.blockerId,
                                        );
                                    widget.comments.add(reply);
                                    setState(() {});
                                    textController.clear();
                                  }
                                : null,
                            child: Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                color: !textFieldEmpty
                                    ? AppTheme.kPurpleColor2
                                    : AppTheme.kPurpleColor2.withOpacity(0.5),
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: SvgPicture.asset(
                                  'assets/send_button.svg',
                                  height: 18,
                                  width: 18,
                                  // ignore: deprecated_member_use
                                  color: AppTheme.kAppWhiteScheme,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  },
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
