// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:milsat_project_app/extras/components/shared_prefs/keys.dart';
import 'package:milsat_project_app/extras/components/shared_prefs/utils.dart';
import 'package:milsat_project_app/extras/models/decoded_token.dart';
import '../../../../extras/api/blockers_api.dart';
import '../../../../extras/components/files.dart';

class AddBlocker extends ConsumerWidget {
  const AddBlocker({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final titleController = TextEditingController();
    final descriptionController = TextEditingController();
    final formKey = GlobalKey<FormState>();
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(44.h),
        child: AppBar(
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          elevation: 0.5,
          leading: GestureDetector(
            onTap: () => AppNavigator.pop(),
            child: Icon(
              Icons.arrow_back,
              color: Colors.black,
              size: 18.sp,
            ),
          ),
          title: Text(
            'Raise a Blocker',
            style: GoogleFonts.raleway(
              color: const Color(0xFF423B43),
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          centerTitle: true,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
            top: 20.h,
            left: 16.w,
            right: 16.w,
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
                SizedBox(
                  height: 8.h,
                ),
                TextFormField(
                  controller: titleController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'topic cannot be empty';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    constraints: BoxConstraints(maxHeight: 54.h),
                    hintText: 'e.g Dashboard visualization',
                    hintStyle: GoogleFonts.raleway(
                      color: const Color(0xFFB7B6B8),
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w500,
                    ),
                    border: const OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xFFB7B6B8),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 32.h,
                ),
                TextFormField(
                  controller: descriptionController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'description cannot be empty';
                    }
                    return null;
                  },
                  maxLines: 12,
                  decoration: InputDecoration(
                    hintText: 'Describe your blocker in details',
                    hintStyle: GoogleFonts.raleway(
                      color: const Color(0xFFB7B6B8),
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w500,
                    ),
                    contentPadding: EdgeInsets.only(top: 16.h, left: 16.w),
                    border: const OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xFFB7B6B8),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 64.h,
                ),
                CustomButton(
                  height: 54.h,
                  pressed: () async {
                    DecodedTokenResponse? response = await SecureStorageUtils
                        .getDataFromStorage<DecodedTokenResponse>(
                            SharedPrefKeys.tokenResponse,
                            DecodedTokenResponse.fromJsonString);
                    if (formKey.currentState!.validate()) {
                      ref.read(blockerProvider).postBlocker(
                            description: descriptionController.text,
                            status: 0,
                            title: titleController.text,
                            trackId: d.track!.trackId!,
                            userId: response!.userId!,
                          );
                      popUp(context);
                    }
                  },
                  color: AppTheme.kPurpleColor3,
                  width: double.infinity,
                  borderRadius: BorderRadius.circular(8.r),
                  child: Text(
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

  Future<dynamic> popUp(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            'Blocker Submitted!',
            textAlign: TextAlign.center,
            style: GoogleFonts.raleway(
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF383639),
            ),
          ),
          content: Text(
            'You will be notified once your mentor responds',
            textAlign: TextAlign.center,
            style: GoogleFonts.raleway(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF504D51),
            ),
          ),
          actions: [
            CustomButton(
              height: 54.h,
              pressed: () {
                AppNavigator.pop();
              },
              color: AppTheme.kPurpleColor,
              width: 307.w,
              elevation: 0,
              borderRadius: BorderRadius.circular(8.r),
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
