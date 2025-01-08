// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:milsat_project_app/extras/api/blockers_api.dart';
import 'package:milsat_project_app/extras/components/shared_prefs/keys.dart';
import 'package:milsat_project_app/extras/components/shared_prefs/utils.dart';
import 'package:milsat_project_app/extras/models/blocker_model.dart';
import 'package:milsat_project_app/extras/models/decoded_token.dart';

import '../../../extras/components/files.dart';
import '../../../extras/components/widgets.dart';

final mentorComment = FutureProvider.autoDispose((ref) {
  return ref.read(apiBlockerServiceProvider).getCommentsById(blockerID);
});

class CommentsPage extends ConsumerStatefulWidget {
  static const String name = 'comments-page';
  static const String route = '/comments-page';
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
  bool _isResolving = false;

  @override
  Widget build(BuildContext context) {
    final mentorComments = ref.watch(mentorComment);

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(44),
        child: AppBar(
          backgroundColor: Colors.white,
          title: Text(
            widget.title,
            style: GoogleFonts.raleway(
              color: const Color(0xFF423B43),
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
            centerTitle: true,
            elevation: 0.5,
            leading: InkWell(
              onTap: () => context.canPop()
                  ? context.pop()
                  : context.pushReplacement(HomeScreen.route),
              child: const Icon(
                Icons.arrow_back,
                color: Colors.black,
                size: 24,
              ),
            ),
          ),
        ),
      ),
      body: mentorComments.when(
        data: (data) {
          return Column(
            children: [
              const SizedBox(
                height: 30,
              ),
              RichText(
                text: TextSpan(
                  text: widget.userName,
                  style: kSmallHeadingStyle,
                  children: [
                    TextSpan(
                      text: " created this blocker ",
                      style: kSmallTextStyle,
                    ),
                    TextSpan(
                      text: "${widget.time} days ago",
                      style: kTimeTextStyle,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    margin: const EdgeInsets.all(5),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 16,
                    ),
                    constraints: const BoxConstraints(maxWidth: 250),
                    color: AppTheme.kAppWhiteScheme,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.min, // Add this
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              widget.title,
                              style: kOnboardingLightTextStyle,
                            ),
                            if (widget.status == 0 &&
                                widget.userId == widget.currentUser) ...{
                              InkWell(
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
                                    context.go(AddBlocker.route);
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
                              widget.userId == widget.currentUser
                                  ? "You"
                                  : widget.userName,
                              style: kTrackTextStyle,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              '24 min ago',
                              style: kTimeTextStyle,
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Hi everyone,\n${widget.description}',
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
                ],
              ),
              if (widget.status == 1) ...{
                Expanded(
                  child: data.isNotEmpty
                      ? ListView.separated(
                          itemBuilder: (context, index) {
                            return Row(
                              mainAxisAlignment:
                                  widget.userName == data[index].senderName
                                      ? MainAxisAlignment.end
                                      : MainAxisAlignment.start,
                              children: [
                                Container(
                                  margin: const EdgeInsets.all(5),
                                  color: AppTheme.kAppWhiteScheme,
                                  constraints:
                                      const BoxConstraints(maxWidth: 250),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 16,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        widget.userName ==
                                                data[index].senderName
                                            ? "You"
                                            : '${data[index].senderName}',
                                        style: kTrackTextStyle,
                                      ),
                                      Text(
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
                                ),
                              ],
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
                            return Row(
                              mainAxisAlignment:
                                  widget.userName == data[index].senderName
                                      ? MainAxisAlignment.end
                                      : MainAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    constraints:
                                        const BoxConstraints(maxWidth: 250),
                                    padding: const EdgeInsets.all(12),
                                    color: AppTheme.kAppWhiteScheme,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          widget.userName ==
                                                  data[index].senderName
                                              ? "You"
                                              : '${widget.comments[index].senderName}',
                                          style: kTrackTextStyle,
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(right: 16),
                                          child: Text(
                                            '${widget.comments[index].message}',
                                            style: GoogleFonts.raleway(
                                              fontSize: 13,
                                              fontWeight: FontWeight.w500,
                                              color: const Color(0xFF504D51),
                                              height: 2,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
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
                                    await SharedPreferencesUtil.getModel<
                                            DecodedTokenResponse>(
                                        SharedPrefKeys.tokenResponse,
                                        (json) => DecodedTokenResponse.fromJson(
                                            json));
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
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor:
            (widget.status == 0 && widget.userId == widget.currentUser)
                ? const Color(0xFF11A263)
                : Colors.grey.shade400,
        tooltip: widget.status == 0 && widget.userId == widget.currentUser
            ? "Mark as resolved"
            : "This Blocker has been resolved",
        onPressed: widget.status != 0 || _isResolving
            ? null
            : () async {
                setState(() {
                  _isResolving = true;
                });
                try {
                  await ref.read(apiBlockerServiceProvider).resolveABlocker(
                        trackId: widget.trackId,
                        userId: widget.userId,
                        blockerId: widget.blockerId,
                        description: widget.description,
                        title: widget.title,
                        status: 1,
                      );
                } finally {
                  showInSnackBar(message[0]);
                  setState(() {
                    _isResolving = false;
                  });

                  context.go(HomeScreen.route);
                }
              },
        child: _isResolving
            ? const SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: Colors.white,
                ))
            : SvgPicture.asset(
                'assets/double_mark.svg',
                width: 24,
                colorFilter: ColorFilter.mode(
                  widget.status == 0 && widget.userId == widget.currentUser
                      ? Colors.white
                      : Colors.grey.shade100,
                  BlendMode.srcIn,
                ),
              ),
      ),
      floatingActionButtonLocation: widget.status == 0
          ? CustomFabLocation(
              location: FloatingActionButtonLocation.endFloat,
              offsetY: -50, // Move up by 50 pixels
              offsetX: -10, // Move right by 16 pixels from left edge
            )
          : null,
    );
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
