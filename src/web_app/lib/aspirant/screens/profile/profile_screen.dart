import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'dart:io';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:milsat_project_app/extras/components/shared_prefs/keys.dart';
import 'package:milsat_project_app/extras/components/shared_prefs/utils.dart';
import 'package:milsat_project_app/extras/models/aspirant_model.dart';
import 'package:milsat_project_app/extras/models/decoded_token.dart';
import 'package:milsat_project_app/extras/models/profile_picture_model.dart';

import '../../../extras/api/file_upload.dart';
import '../../../extras/components/files.dart';

final ImagePicker _imagePicker = ImagePicker();

final pickedImage = StateProvider<XFile?>((ref) {
  return;
});
final image = StateProvider<File?>((ref) {
  return;
});

final userDetails =
    FutureProvider.autoDispose<AspirantModelClass?>((ref) async {
  DecodedTokenResponse? response =
      await SharedPreferencesUtil.getModel<DecodedTokenResponse>(
          SharedPrefKeys.tokenResponse,
          (json) => DecodedTokenResponse.fromJson(json));
  return ref.read(apiServiceProvider).getUserData(response?.userId);
});

class ProfileScreen extends ConsumerStatefulWidget {
  static const String name = 'profile';
  static const String route = '/profile';
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  ProfilePictureResponse? profilePictureResponse;
  void getUserProfile() async {
    profilePictureResponse =
        await SharedPreferencesUtil.getModel<ProfilePictureResponse>(
            SharedPrefKeys.profileResponse,
            (json) => ProfilePictureResponse.fromJson(json));
  }

  @override
  void initState() {
    getUserProfile();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final aspirantData = ref.watch(userDetails);
    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: () async {
        final shouldPop = await popToHome(context);

        return shouldPop ?? false;
      },
      child: Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(44),
            child: AppBar(
              elevation: 0,
              backgroundColor: Colors.transparent,
              automaticallyImplyLeading: true,
              leading: InkWell(
                onTap: () async => await popToHome(context),
                child: const Icon(
                  Icons.arrow_back_outlined,
                  color: Colors.black,
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    context.go(EditProfile.route);
                  },
                  child: Text(
                    'Edit',
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
                                  height: 88,
                                  width: 80,
                                  fit: BoxFit.cover,
                                ),
                              )
                            else if (profilePictureResponse?.profilePicture !=
                                null)
                              CircleAvatar(
                                radius: 44,
                                backgroundImage: NetworkImage(
                                  profilePictureResponse!.profilePicture!,
                                ),
                                backgroundColor: Colors.grey,
                              )
                            else
                              CircleAvatar(
                                radius: 44,
                                backgroundImage: data?.profilePicture == null
                                    ? const AssetImage(
                                        'assets/placeholder-person.png',
                                      )
                                    : NetworkImage(
                                        data?.profilePicture,
                                      ) as ImageProvider<Object>?,
                                backgroundColor: Colors.grey,
                              ),
                            Positioned(
                              right: 0,
                              bottom: 0,
                              child: InkWell(
                                onTap: () async {
                                  DecodedTokenResponse? decodedToken =
                                      await SharedPreferencesUtil.getModel<
                                              DecodedTokenResponse>(
                                          SharedPrefKeys.tokenResponse,
                                          (json) =>
                                              DecodedTokenResponse.fromJson(
                                                  json));
                                  try {
                                    ref.read(pickedImage.notifier).state =
                                        await _imagePicker.pickImage(
                                            source: ImageSource.gallery);
                                    if (ref.watch(pickedImage) != null) {
                                      File imageFile =
                                          File(ref.watch(pickedImage)!.path);
                                      ref.read(image.notifier).state =
                                          imageFile;
                                      await ref
                                          .read(apiUploadProvider)
                                          .uploadImage(
                                              decodedToken!.userId!, imageFile);
                                    }
                                  } on PlatformException catch (e) {
                                    if (kDebugMode) {
                                      print('Failed to pick image: $e');
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
                            ProfileCardContent(
                              trackName: data!.track!.name!,
                            ),
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
                                border:
                                    Border.all(color: AppTheme.kHintTextColor),
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
                                border:
                                    Border.all(color: AppTheme.kHintTextColor),
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
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 12,
                              ),
                              height: 96,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                border:
                                    Border.all(color: AppTheme.kHintTextColor),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Text(
                                personalInfo['personalUserInfo'] != null
                                    ? personalInfo['personalUserInfo']['bio']
                                    : data.bio!,
                                textAlign: TextAlign.left,
                                style: GoogleFonts.raleway(
                                  color: const Color(0xFF6E6B6F),
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 32,
                      ),
                      InkWell(
                        onTap: () {
                          context.push(PasswordPage.route);
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 28.8,
                            vertical: 11,
                          ),
                          height: 56,
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
                                      fontSize: 13,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 4,
                                  ),
                                  Text(
                                    'Change password',
                                    style: GoogleFonts.raleway(
                                      color: const Color(0xFF6E6B6F),
                                      fontWeight: FontWeight.w500,
                                      fontSize: 10,
                                    ),
                                  ),
                                ],
                              ),
                              const Icon(
                                Icons.arrow_forward_ios,
                                size: 14,
                                color: Color(0xFF79717A),
                              )
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      InkWell(
                        onTap: () {
                          signOut(context);
                        },
                        child: Container(
                          padding: const EdgeInsets.only(
                            top: 19,
                            left: 29,
                          ),
                          height: 56,
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
                              fontSize: 13,
                              color: const Color(0xFF504D51),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 24,
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
              })),
    );
  }

  Future<bool?> popToHome(BuildContext context) async {
    Navigator.pop(context, true);
    context.go(HomeScreen.route);
    return null;
  }
}
