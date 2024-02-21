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
import 'package:milsat_project_app/mentor/profile/profile.dart';
import '../../../extras/components/files.dart';
import '../../extras/api/file_upload.dart';
import 'mentor_profile_card.dart';

final ImagePicker _imagePicker = ImagePicker();

class EditMentorProfile extends ConsumerWidget {
  const EditMentorProfile({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final bioController = TextEditingController();
    final mentorData = ref.watch(mentorDetails);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: appBarHeight,
        child: AppBar(
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
                fontSize: 13,
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () async {
                DecodedTokenResponse? decodedToken = await SecureStorageUtils
                    .getDataFromStorage<DecodedTokenResponse>(
                        SharedPrefKeys.tokenResponse,
                        DecodedTokenResponse.fromJsonString);
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
                            padding: const EdgeInsets.only(
                              right: 16,
                              top: 6,
                              bottom: 16,
                            ),
                            child: GestureDetector(
                                onTap: () {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                    return const MentorPageSkeleton(
                                      currentPage: 1,
                                    );
                                  }));
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
                  fontSize: 13,
                ),
              ),
            ),
          ],
        ),
      ),
      body: mentorData.when(
          data: (data) {
            return SingleChildScrollView(
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
                              height: 88,
                              width: 80,
                              fit: BoxFit.cover,
                            ),
                          )
                        else if (personalInfo['personalUserInfo'] != null &&
                            personalInfo['personalUserInfo']
                                    ['profile_picture'] !=
                                null)
                          CircleAvatar(
                            radius: 44,
                            backgroundImage: NetworkImage(
                              personalInfo['personalUserInfo']
                                  ['profile_picture'],
                            ),
                            backgroundColor: Colors.grey,
                          )
                        else
                          CircleAvatar(
                            radius: 44,
                            backgroundImage: data.profilePicture == null
                                ? const AssetImage(
                                    'assets/placeholder-person.png',
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
                              DecodedTokenResponse? decodedToken =
                                  await SecureStorageUtils.getDataFromStorage<
                                          DecodedTokenResponse>(
                                      SharedPrefKeys.tokenResponse,
                                      DecodedTokenResponse.fromJsonString);
                              try {
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
                                  print('Failed to pick mentorImage: $e');
                                }
                              }
                            },
                            child: Container(
                              height: 26.07,
                              width: 26.07,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppTheme.kAppWhiteScheme,
                              ),
                              child: Center(
                                child: Container(
                                  height: 22.07,
                                  width: 22.07,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: AppTheme.kPurpleColor,
                                  ),
                                  child: Center(
                                    child: SvgPicture.asset(
                                      'assets/edit_pen.svg',
                                      height: 10.08,
                                      width: 10.08,
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
                  const SizedBox(
                    height: 24,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                    ),
                    child: Stack(
                      children: [
                        CohortCard(
                          width: double.infinity,
                          radius: BorderRadius.circular(4),
                          first: -15.5,
                          second_1: 0,
                          second_2: 0,
                          third: 80.53,
                          forth_1: 0,
                          forth_2: 0,
                          forthHeight: 157.13,
                          thirdHeight: 230.44,
                          secondHeight: 135.28,
                          height: 108,
                        ),
                        MentorProfileCardContent(trackName: data.track!.name!),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 34,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Name',
                          style: GoogleFonts.raleway(
                            color: const Color(0xFF504D51),
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                          height: 48,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            border: Border.all(color: AppTheme.kHintTextColor),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            data.fullName!,
                            style: GoogleFonts.raleway(
                              color: const Color(0xFF6E6B6F),
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        Text(
                          'Email',
                          style: GoogleFonts.raleway(
                            color: const Color(0xFF504D51),
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                          height: 48,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            border: Border.all(color: AppTheme.kHintTextColor),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            data.email!,
                            textAlign: TextAlign.left,
                            style: GoogleFonts.raleway(
                              color: const Color(0xFF6E6B6F),
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        Text(
                          'Bio',
                          style: GoogleFonts.raleway(
                            color: const Color(0xFF504D51),
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        TextField(
                          controller: bioController,
                          maxLines: 3,
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(),
                            hintText: 'Write Something about yourself...',
                            hintStyle: GoogleFonts.raleway(
                              color: const Color(0xFFB7B6B8),
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 10,
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
          }),
      bottomNavigationBar: const CustomNavBar(),
    );
  }
}
