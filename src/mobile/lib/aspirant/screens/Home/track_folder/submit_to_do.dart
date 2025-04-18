// ignore_for_file: use_build_context_synchronously

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:milsat_project_app/extras/components/shared_prefs/keys.dart';
import 'package:milsat_project_app/extras/components/shared_prefs/utils.dart';
import 'package:milsat_project_app/extras/models/decoded_token.dart';
import '../../../../extras/api/file_upload.dart';
import '../../../../extras/components/files.dart';
import 'package:file_picker/file_picker.dart';

final fileName = StateProvider.autoDispose<String?>((ref) {
  return '';
});
// final fileContent = StateProvider<dynamic>((ref) {
//   return;
// });

class SubmitToDoPage extends ConsumerStatefulWidget {
  const SubmitToDoPage({super.key, required this.courseId});

  final String courseId;
  @override
  ConsumerState<SubmitToDoPage> createState() => _SubmitToDoPageState();
}

class _SubmitToDoPageState extends ConsumerState<SubmitToDoPage> {
  @override
  void initState() {
    textKey;
    super.initState();
  }

  final textKey = GlobalKey<FormState>();
  TextEditingController textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(
          44,
        ),
        child: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.5,
          title: Text(
            'Submit To-dos',
            style: kCourseTextStyle,
          ),
          leading: GestureDetector(
            onTap: () {
              AppNavigator.doPop();
            },
            child: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
          ),
          centerTitle: true,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          top: 47,
          left: 16,
          right: 16,
        ),
        child: Form(
          key: textKey,
          child: Column(
            children: [
              TextFormField(
                controller: textController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'value cannot be null';
                  }
                  return null;
                },
                maxLines: 6,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 16,
                  ),
                  border: const OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0xFFB7B6B8),
                    ),
                  ),
                  hintText: 'What did you learn during the course',
                  hintStyle: GoogleFonts.raleway(
                    color: const Color(
                      0xFF9A989A,
                    ),
                    fontWeight: FontWeight.w500,
                    fontSize: 13,
                  ),
                ),
              ),
              const SizedBox(
                height: 32,
              ),
              DottedBorder(
                borderType: BorderType.RRect,
                radius: const Radius.circular(6),
                color: const Color(0xFFB7B6B8),
                child: Center(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                    ),
                    height: 56,
                    width: double.infinity,
                    child: Consumer(
                      builder:
                          (BuildContext context, WidgetRef ref, Widget? child) {
                        return GestureDetector(
                          onTap: () async {
                            final result = await FilePicker.platform
                                .pickFiles(type: FileType.any);
                            if (result != null) {
                              final file = result.files.single.path;
                              if (file != null) {
                                if (kDebugMode) {
                                  print('File path: $file');
                                }
                                ref.read(fileName.notifier).state = file;
                              } else {
                                if (kDebugMode) {
                                  print('Failed to retrieve file path');
                                }
                              }
                            } else {
                              if (kDebugMode) {
                                print('File selection canceled');
                              }
                              return;
                            }
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                'assets/file-upload.svg',
                              ),
                              const SizedBox(
                                width: 17.5,
                              ),
                              Text(
                                ref.watch(fileName) == ''
                                    ? 'upload proof of completion'
                                    : ref.watch(fileName)!.split('/').last,
                                softWrap: true,
                                style: GoogleFonts.raleway(
                                  color: const Color(0xFF9A989A),
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 56,
              ),
              CustomButton(
                height: 54,
                pressed: () async {
                  if (textKey.currentState!.validate() &&
                      ref.watch(fileName) != null) {
                    DecodedTokenResponse? decodedToken =
                        await SecureStorageUtils.getDataFromStorage<
                                DecodedTokenResponse>(
                            SharedPrefKeys.tokenResponse,
                            DecodedTokenResponse.fromJsonString);
                    if (kDebugMode) {
                      print(decodedToken!.userId!);
                      print(widget.courseId);
                    }
                    ref.read(apiUploadProvider).submitTodo(
                          textController.text,
                          widget.courseId,
                          decodedToken!.userId!,
                          ref.watch(fileName)!,
                        );

                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text(
                            'Congratulations!',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.raleway(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF383639),
                            ),
                          ),
                          content: Text(
                            'You have successfully completed a milestone',
                            style: GoogleFonts.raleway(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF504D51),
                            ),
                          ),
                          actions: [
                            CustomButton(
                              height: 54,
                              pressed: () {
                                String trackId = d.track!.trackId!;
                                ref.read(apiServiceProvider).getTrackCourses(
                                    decodedToken.userId!, trackId);
                                Navigator.pushReplacement(context,
                                    MaterialPageRoute(builder: (context) {
                                  return TrackDetails(d: d);
                                }));
                              },
                              color: AppTheme.kPurpleColor,
                              width: 307,
                              elevation: 0,
                              borderRadius: BorderRadius.circular(8),
                              child: const Text(
                                'Got it!',
                                style: TextStyle(
                                  color: AppTheme.kAppWhiteScheme,
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  }
                },
                color: AppTheme.kPurpleColor,
                width: double.infinity,
                elevation: 0,
                borderRadius: BorderRadius.circular(8),
                child: Center(
                  child: Text(
                    'Submit',
                    style: GoogleFonts.raleway(
                      color: AppTheme.kAppWhiteScheme,
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
