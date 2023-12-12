import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:milsat_project_app/extras/components/files.dart';
import 'package:milsat_project_app/extras/components/shared_prefs/keys.dart';
import 'package:milsat_project_app/extras/components/shared_prefs/utils.dart';
import 'package:milsat_project_app/extras/models/decoded_token.dart';
import 'package:milsat_project_app/extras/models/profile_picture_model.dart';
import 'package:milsat_project_app/mentor/profile/mentor_profile_card.dart';

import '../../extras/api/file_upload.dart';

final ImagePicker _imagePicker = ImagePicker();

final pickedMentorImage = StateProvider<XFile?>((ref) {
  return;
});
final mentorImage = StateProvider<File?>((ref) {
  return;
});

class MentorProfilePage extends ConsumerStatefulWidget {
  const MentorProfilePage({super.key});

  @override
  ConsumerState<MentorProfilePage> createState() => _MentorProfilePageState();
}

class _MentorProfilePageState extends ConsumerState<MentorProfilePage> {
  ProfilePictureResponse? profilePictureResponse;
  void getUserProfile() async {
    profilePictureResponse =
        await SecureStorageUtils.getDataFromStorage<ProfilePictureResponse>(
            SharedPrefKeys.profileResponse,
            ProfilePictureResponse.fromJsonString);
  }

  @override
  void initState() {
    getUserProfile();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final mentorData = ref.watch(mentorDetails);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: appBarHeight,
        child: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          automaticallyImplyLeading: false,
          actions: [
            TextButton(
              onPressed: () {
                AppNavigator.navigateTo(editMentorsProfileRoute);
              },
              child: Text(
                'Edit',
                style: GoogleFonts.raleway(
                  color: const Color(0xFF383639),
                  fontWeight: FontWeight.w600,
                  fontSize: 13.sp,
                ),
              ),
            ),
          ],
        ),
      ),
      body: mentorData.when(
        data: (data) {
          return SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(
              parent: BouncingScrollPhysics(),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Stack(
                    children: [
                      if (ref.watch(mentorImage) != null)
                        ClipOval(
                          child: Image.file(
                            ref.watch(mentorImage)!,
                            height: 88.h,
                            width: 80.w,
                            fit: BoxFit.cover,
                          ),
                        )
                      else if (profilePictureResponse?.profilePicture != null)
                        CircleAvatar(
                          radius: 44.r,
                          backgroundImage: NetworkImage(
                            profilePictureResponse!.profilePicture!,
                          ),
                          backgroundColor: Colors.grey,
                        )
                      else
                        CircleAvatar(
                          radius: 44.r,
                          backgroundImage: data.profilePicture == null
                              ? const AssetImage(
                                  'assets/defaultImage.jpg',
                                )
                              : NetworkImage(
                                  data.profilePicture,
                                ) as ImageProvider<Object>?,
                          backgroundColor: Colors.grey,
                        ),
                      Positioned(
                        right: 0,
                        bottom: 0,
                        child: GestureDetector(
                          onTap: () async {
                            try {
                              DecodedTokenResponse? decodedToken =
                                  await SecureStorageUtils.getDataFromStorage<
                                          DecodedTokenResponse>(
                                      SharedPrefKeys.tokenResponse,
                                      DecodedTokenResponse.fromJsonString);
                              ref.read(pickedImage.notifier).state =
                                  await _imagePicker.pickImage(
                                      source: ImageSource.gallery);
                              if (ref.watch(pickedImage) != null) {
                                File imageFile =
                                    File(ref.watch(pickedImage)!.path);
                                ref.read(mentorImage.notifier).state =
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
                            height: 26.07.h,
                            width: 26.07.w,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppTheme.kAppWhiteScheme,
                            ),
                            child: Center(
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
                      MentorProfileCardContent(
                        trackName: data.track!.name!,
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
                          border: Border.all(color: AppTheme.kHintTextColor),
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
                          border: Border.all(color: AppTheme.kHintTextColor),
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
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 16.w,
                          vertical: 12.h,
                        ),
                        height: 96.h,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          border: Border.all(color: AppTheme.kHintTextColor),
                          borderRadius: BorderRadius.circular(6.r),
                        ),
                        child: Text(
                          personalInfo['personalUserInfo'] != null
                              ? personalInfo['personalUserInfo']['bio']
                              : data.bio!,
                          textAlign: TextAlign.left,
                          style: GoogleFonts.raleway(
                            color: const Color(0xFF6E6B6F),
                            fontWeight: FontWeight.w500,
                            fontSize: 16.sp,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 32.h,
                ),
                GestureDetector(
                  onTap: () {
                    AppNavigator.navigateTo(mentorPasswordRoute);
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 28.8.w,
                      vertical: 11.h,
                    ),
                    height: 56.h,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: const Color(0xFFEEEDEE),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Password',
                              style: GoogleFonts.raleway(
                                color: const Color(0xFF504D51),
                                fontWeight: FontWeight.w600,
                                fontSize: 13.sp,
                              ),
                            ),
                            SizedBox(
                              height: 4.h,
                            ),
                            Text(
                              'Change password',
                              style: GoogleFonts.raleway(
                                color: const Color(0xFF6E6B6F),
                                fontWeight: FontWeight.w500,
                                fontSize: 10.sp,
                              ),
                            ),
                          ],
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          size: 14.sp,
                          color: const Color(0xFF79717A),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 16.h,
                ),
                GestureDetector(
                  onTap: () {
                    signOut();
                  },
                  child: Container(
                    padding: EdgeInsets.only(
                      top: 19.h,
                      left: 29.w,
                    ),
                    height: 56.h,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: const Color(0xFFEEEDEE),
                      ),
                    ),
                    child: Text(
                      'Logout',
                      style: GoogleFonts.raleway(
                        fontWeight: FontWeight.w600,
                        fontSize: 13.sp,
                        color: const Color(0xFF504D51),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 24.h,
                ),
              ],
            ),
          );
        },
        error: (((error, stackTrace) => Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Stack(
                    children: [
                      CohortCard(
                        width: double.infinity,
                        height: 212.h,
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
                      ),
                      Column(
                        children: [
                          SvgPicture.asset(
                            'assets/error_image.svg',
                            height: 100.h,
                            width: 100.w,
                          ),
                          SizedBox(height: 16.h),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Try again Later',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Theme.of(context).cardColor,
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ))),
        loading: () {
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
