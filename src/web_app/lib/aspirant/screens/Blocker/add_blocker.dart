// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:milsat_project_app/extras/components/shared_prefs/keys.dart';
import 'package:milsat_project_app/extras/components/shared_prefs/utils.dart';
import 'package:milsat_project_app/extras/components/widgets.dart';
import 'package:milsat_project_app/extras/models/decoded_token.dart';
import '../../../extras/api/blockers_api.dart';
import '../../../extras/components/files.dart';

class AddBlocker extends ConsumerStatefulWidget {
  static const String name = 'add_blocker';
  static const String route = '/add_blocker';
  const AddBlocker({super.key});

  @override
  ConsumerState<AddBlocker> createState() => _AddBlockerState();
}

class _AddBlockerState extends ConsumerState<AddBlocker> {
  bool titleEmpty = true;
  bool descriptionEmpty = true;

  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  bool _blockerButtonPressed = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        toolbarHeight: 44,
        automaticallyImplyLeading: false,
        elevation: 0.5,
        leading: GestureDetector(
          onTap: () => context.pop(),
          child: const Icon(
            Icons.arrow_back,
            color: Colors.black,
            size: 18,
          ),
        ),
        title: Text(
          'Raise a Blocker',
          style: GoogleFonts.raleway(
            color: const Color(0xFF423B43),
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(
            top: 20,
            left: 16,
            right: 16,
          ),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Blocker topic',
                  style: kSmallHeadingStyle,
                ),
                const SizedBox(
                  height: 8,
                ),
                TextFormField(
                  controller: titleController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Topic cannot be empty';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    if (value.isNotEmpty) {
                      setState(() {
                        descriptionEmpty = false;
                      });
                    }
                  },
                  readOnly: _blockerButtonPressed,
                  decoration: InputDecoration(
                    constraints: const BoxConstraints(maxHeight: 54),
                    hintText: 'e.g Dashboard visualization',
                    hintStyle: GoogleFonts.raleway(
                      color: const Color(0xFFB7B6B8),
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                    border: const OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xFFB7B6B8),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 32,
                ),
                TextFormField(
                  controller: descriptionController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Description cannot be empty';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    if (value.isNotEmpty) {
                      setState(() {
                        descriptionEmpty = false;
                      });
                    }
                  },
                  readOnly: _blockerButtonPressed,
                  maxLines: 12,
                  decoration: InputDecoration(
                    hintText: 'Describe your blocker in details',
                    hintStyle: GoogleFonts.raleway(
                      color: const Color(0xFFB7B6B8),
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                    contentPadding: const EdgeInsets.only(top: 16, left: 16),
                    border: const OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xFFB7B6B8),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 64,
                ),
                CustomButton(
                  pressed: titleController.text.isEmpty ||
                          descriptionController.text.isEmpty ||
                          _blockerButtonPressed
                      ? null
                      : () async {
                          setState(() {
                            _blockerButtonPressed = true;
                          });
                          DecodedTokenResponse? response =
                              await SharedPreferencesUtil.getModel<
                                      DecodedTokenResponse>(
                                  SharedPrefKeys.tokenResponse,
                                  (json) =>
                                      DecodedTokenResponse.fromJson(json));
                          if (formKey.currentState!.validate()) {
                            final result = await ref
                                .read(apiBlockerServiceProvider)
                                .postBlocker(
                                  description: descriptionController.text,
                                  status: 0,
                                  title: titleController.text,
                                  trackId: d.track!.trackId!,
                                  userId: response!.userId!,
                                );

                            popUp(
                              context,
                              result['error'] ??
                                  'Blocker Submitted Successfully, you will receive your response soon',
                              result['error'] == null ? true : false,
                            );
                          }

                          setState(() {
                            _blockerButtonPressed = false;
                          });
                        },
                  color: AppTheme.kPurpleColor,
                  borderRadius: BorderRadius.circular(8),
                  child: _blockerButtonPressed
                      ? const CircularLoadingWidget()
                      : Text(
                          'Submit',
                          style: GoogleFonts.raleway(
                            color: AppTheme.kAppWhiteScheme,
                          ),
                        ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<dynamic> popUp(BuildContext context, String message, bool succeeded) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            'Hello!',
            textAlign: TextAlign.center,
            style: GoogleFonts.raleway(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF383639),
            ),
          ),
          content: Text(
            message,
            textAlign: TextAlign.center,
            style: GoogleFonts.raleway(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF504D51),
            ),
          ),
          actions: [
            CustomButton(
              pressed: () {
                succeeded ? context.go(HomeScreen.route) : context.pop();
              },
              color: AppTheme.kPurpleColor,
              elevation: 0,
              borderRadius: BorderRadius.circular(8),
              child: Text(
                'Ok!',
                style: GoogleFonts.raleway(
                  color: AppTheme.kAppWhiteScheme,
                ),
              ),
            )
          ],
        );
      },
    );
  }
}
