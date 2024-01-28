import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:milsat_project_app/extras/components/shared_prefs/keys.dart';
import 'package:milsat_project_app/extras/components/shared_prefs/utils.dart';
import 'package:milsat_project_app/extras/models/decoded_token.dart';
import '../../../extras/api/blockers_api.dart';
import '../../../extras/components/files.dart';

class ReplyBlocker extends ConsumerStatefulWidget {
  const ReplyBlocker({
    super.key,
    required this.title,
    required this.description,
    required this.userName,
    required this.blockerId,
  });

  final String title;
  final String description;
  final String userName;
  final String blockerId;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ReplyBlockerState();
}

class _ReplyBlockerState extends ConsumerState<ReplyBlocker> {
  final textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(44),
        child: AppBar(
          backgroundColor: Colors.white,
          title: Text(
            'Blockers',
            style: GoogleFonts.raleway(
              color: const Color(0xFF423B43),
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          centerTitle: true,
          leading: GestureDetector(
            onTap: () => AppNavigator.pop(),
            child: const Icon(
              Icons.arrow_back,
              color: Colors.black,
              size: 24,
            ),
          ),
          elevation: 0.5,
        ),
      ),
      body: Column(
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
                Text(
                  widget.title,
                  style: GoogleFonts.raleway(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF504D51),
                  ),
                ),
                const SizedBox(
                  height: 4,
                ),
                Row(
                  children: [
                    Text(
                      widget.userName,
                      style: GoogleFonts.raleway(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF504D51),
                          height: 1.5),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Text(
                      '5 min ago',
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
                    height: 2,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Expanded(
            child: personalInfo['blockerReply'] != null
                ? Container(
                    width: double.infinity,
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 16,
                    ),
                    // color: AppTheme.kAppWhiteScheme,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          personalInfo['blockerReply']['sender_name'],
                          style: GoogleFonts.raleway(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF504D51),
                              height: 1.5),
                        ),
                        Text(
                          'Hello ${widget.userName},\n'
                          '${personalInfo['blockerReply']['message']}',
                          style: GoogleFonts.raleway(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            color: const Color(0xFF504D51),
                            height: 2,
                          ),
                        ),
                      ],
                    ),
                  )
                : const SizedBox(),
          ),
          Consumer(
            builder: (context, ref, child) {
              return Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: textController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'value cannot be null';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 16,
                        ),
                        border: const OutlineInputBorder(
                          borderSide: BorderSide.none,
                        ),
                        hintText: 'Send to feedback here......',
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
                  Padding(
                    padding: const EdgeInsets.only(right: 16),
                    child: InkWell(
                      onTap: () async {
                        DecodedTokenResponse? decodedToken =
                            await SecureStorageUtils.getDataFromStorage<
                                    DecodedTokenResponse>(
                                SharedPrefKeys.tokenResponse,
                                DecodedTokenResponse.fromJsonString);
                        await ref.read(blockerProvider).replyABlocker(
                            message: textController.text,
                            userId: decodedToken!.userId!,
                            blocker: widget.blockerId);
                      },
                      child: SvgPicture.asset(
                        'assets/send_button.svg',
                        height: 18,
                        width: 18,
                        // ignore: deprecated_member_use
                        color: AppTheme.kPurpleColor,
                      ),
                    ),
                  ),
                ],
              );
            },
          )
        ],
      ),
    );
  }
}
