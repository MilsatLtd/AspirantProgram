// ignore_for_file: use_build_context_synchronously

import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:milsat_project_app/extras/components/shared_prefs/keys.dart';
import 'package:milsat_project_app/extras/components/shared_prefs/utils.dart';
import 'package:milsat_project_app/extras/models/decoded_token.dart';
import '../../../extras/api/file_upload.dart';
import '../../../extras/components/files.dart';

final ImagePicker _imagePicker = ImagePicker();

class EditProfile extends ConsumerWidget {
  const EditProfile({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final bioController = TextEditingController();
    final aspirantData = ref.watch(aspirantDetails);
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          automaticallyImplyLeading: false,
          leading: TextButton(
            onPressed: () {
              AppNavigator.pop();
            },
            child: Text(
              'Back',
              style: GoogleFonts.raleway(
                color: const Color(0xFF383639),
                fontWeight: FontWeight.w600,
                fontSize: 13.sp,
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () async {
                DecodedTokenResponse? decodedToken =
                    await SecureStorageUtils.getTokenResponseFromStorage(
                        SharedPrefKeys.tokenResponse);
                ref
                    .read(apiUploadProvider)
                    .updateStatus(decodedToken!.userId!, bioController.text);
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text('Congratulations!'),
                        content: const Text('Profile updated successfully'),
                        actions: [
                          Padding(
                            padding: EdgeInsets.only(
                              right: 16.w,
                              top: 6.h,
                              bottom: 16.h,
                            ),
                            child: GestureDetector(
                                onTap: () {
                                  AppNavigator.navigateToAndReplace(
                                      profileRoute);
                                },
                                child: const Text('Ok')),
                          )
                        ],
                      );
                    });
              },
              child: Text(
                'Save Edit',
                style: GoogleFonts.raleway(
                  color: const Color(0xFF383639),
                  fontWeight: FontWeight.w600,
                  fontSize: 13.sp,
                ),
              ),
            ),
          ],
        ),
        body: aspirantData.when(
            data: (data) {
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Stack(
                        children: [
                          if (ref.watch(image) != null)
                            ClipOval(
                              child: Image.file(
                                ref.watch(image)!,
                                height: 88.h,
                                width: 80.w,
                                fit: BoxFit.cover,
                              ),
                            )
                          else if (personalInfo['personalUserInfo'] != null &&
                              personalInfo['personalUserInfo']
                                      ['profile_picture'] !=
                                  null)
                            CircleAvatar(
                              radius: 44.r,
                              backgroundImage: NetworkImage(
                                personalInfo['personalUserInfo']
                                    ['profile_picture'],
                              ),
                              backgroundColor: Colors.grey,
                            )
                          else
                            CircleAvatar(
                              radius: 44.r,
                              backgroundImage: data?.profilePicture == null
                                  ? const AssetImage(
                                      'assets/defaultImage.jpg',
                                    )
                                  : NetworkImage(
                                      data?.profilePicture,
                                    ) as ImageProvider<Object>?,
                              backgroundColor: Colors.grey,
                            ),
                          Positioned(
                            right: 0,
                            bottom: 0,
                            child: Container(
                              height: 26.07.h,
                              width: 26.07.w,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppTheme.kAppWhiteScheme,
                              ),
                              child: Center(
                                child: GestureDetector(
                                  onTap: () async {
                                    DecodedTokenResponse? decodedToken =
                                        await SecureStorageUtils
                                            .getTokenResponseFromStorage(
                                                SharedPrefKeys.tokenResponse);
                                    try {
                                      ref.read(pickedImage.notifier).state =
                                          await _imagePicker.pickImage(
                                              source: ImageSource.gallery);
                                      if (ref.watch(pickedImage) != null) {
                                        File imageFile =
                                            File(ref.watch(pickedImage)!.path);
                                        ref.read(image.notifier).state =
                                            imageFile;
                                        ref.read(apiUploadProvider).uploadImage(
                                            decodedToken!.userId!, imageFile);
                                      }
                                    } on PlatformException catch (e) {
                                      if (kDebugMode) {
                                        print('Failed to pick image: $e');
                                      }
                                    }
                                  },
                                  child: Container(
                                    height: 22.07.h,
                                    width: 22.07.w,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: AppTheme.kPurpleColor,
                                    ),
                                    child: Center(
                                      child: SvgPicture.asset(
                                        'assets/edit_pen.svg',
                                        height: 10.08.h,
                                        width: 10.08.w,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 24.h,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                      ),
                      child: Stack(
                        children: [
                          CohortCard(
                            width: double.infinity,
                            radius: BorderRadius.circular(4.r),
                            first: -15.5,
                            second_1: 0,
                            second_2: 0,
                            third: 80.53.h,
                            forth_1: 0,
                            forth_2: 0,
                            forthHeight: 157.13.h,
                            thirdHeight: 230.44.h,
                            secondHeight: 135.28.h,
                            height: 108.h,
                          ),
                          ProfileCardContent(
                            trackName: data!.track!.name!,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 34.h,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Name',
                            style: GoogleFonts.raleway(
                              color: const Color(0xFF504D51),
                              fontWeight: FontWeight.w500,
                              fontSize: 16.sp,
                            ),
                          ),
                          SizedBox(
                            height: 8.h,
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 16.w,
                              vertical: 12.h,
                            ),
                            height: 48.h,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              border:
                                  Border.all(color: AppTheme.kHintTextColor),
                              borderRadius: BorderRadius.circular(6.r),
                            ),
                            child: Text(
                              data.fullName!,
                              style: GoogleFonts.raleway(
                                color: const Color(0xFF6E6B6F),
                                fontWeight: FontWeight.w500,
                                fontSize: 16.sp,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 24.h,
                          ),
                          Text(
                            'Email',
                            style: GoogleFonts.raleway(
                              color: const Color(0xFF504D51),
                              fontWeight: FontWeight.w500,
                              fontSize: 16.sp,
                            ),
                          ),
                          SizedBox(
                            height: 8.h,
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 16.w,
                              vertical: 12.h,
                            ),
                            height: 48.h,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              border:
                                  Border.all(color: AppTheme.kHintTextColor),
                              borderRadius: BorderRadius.circular(6.r),
                            ),
                            child: Text(
                              data.email!,
                              textAlign: TextAlign.left,
                              style: GoogleFonts.raleway(
                                color: const Color(0xFF6E6B6F),
                                fontWeight: FontWeight.w500,
                                fontSize: 16.sp,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 24.h,
                          ),
                          Text(
                            'Bio',
                            style: GoogleFonts.raleway(
                              color: const Color(0xFF504D51),
                              fontWeight: FontWeight.w500,
                              fontSize: 16.sp,
                            ),
                          ),
                          SizedBox(
                            height: 8.h,
                          ),
                          TextField(
                            maxLines: 3,
                            controller: bioController,
                            decoration: InputDecoration(
                              border: const OutlineInputBorder(),
                              hintText: 'Write Something about yourself',
                              hintStyle: GoogleFonts.raleway(
                                color: const Color(0xFFB7B6B8),
                                fontWeight: FontWeight.w500,
                                fontSize: 16.sp,
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 16.w,
                                vertical: 10.h,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
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
