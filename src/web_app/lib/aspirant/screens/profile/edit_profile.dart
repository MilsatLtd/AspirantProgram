import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:milsat_project_app/extras/components/shared_prefs/keys.dart';
import 'package:milsat_project_app/extras/components/shared_prefs/utils.dart';
import 'package:milsat_project_app/extras/models/decoded_token.dart';
import 'package:milsat_project_app/extras/models/profile_picture_model.dart';
import '../../../extras/api/file_upload.dart';
import '../../../extras/components/files.dart';

final ImagePicker _imagePicker = ImagePicker();

class EditProfile extends ConsumerStatefulWidget {
  static const String name = 'edit-profile';
  static const String route = '/edit-profile';
  const EditProfile({super.key});

  @override
  ConsumerState<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends ConsumerState<EditProfile> {
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
    final bioController = TextEditingController();
    final aspirantData = ref.watch(aspirantDetails);
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          automaticallyImplyLeading: false,
          leading: TextButton(
            onPressed: () {
              context.canPop()
                  ? context.pop()
                  : context.pushReplacement(HomeScreen.route);
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
                DecodedTokenResponse? decodedToken =
                    await SharedPreferencesUtil.getModel<DecodedTokenResponse>(
                        SharedPrefKeys.tokenResponse,
                        (json) => DecodedTokenResponse.fromJson(json));
                ref
                    .read(apiUploadProvider)
                    .updateStatus(decodedToken!.userId!, bioController.text);
                dialog();
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
        body: aspirantData.when(
            data: (data) {
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Stack(
                        children: [
                          if (ref.watch(image) != null) ...{
                            ClipOval(
                              child: Image.file(
                                ref.watch(image)!,
                                height: 88,
                                width: 80,
                                fit: BoxFit.cover,
                              ),
                            )
                          } else if (profilePictureResponse?.profilePicture !=
                              null) ...{
                            CircleAvatar(
                              radius: 44,
                              backgroundImage: NetworkImage(
                                profilePictureResponse!.profilePicture!,
                              ),
                              backgroundColor: Colors.grey,
                            )
                          } else ...{
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
                            )
                          },
                          Positioned(
                            right: 0,
                            bottom: 0,
                            child: Container(
                              height: 26.07,
                              width: 26.07,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppTheme.kAppWhiteScheme,
                              ),
                              child: Center(
                                child: GestureDetector(
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
                          TextField(
                            maxLines: 3,
                            controller: bioController,
                            decoration: InputDecoration(
                              border: const OutlineInputBorder(),
                              hintText: 'Write Something about yourself',
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
            }));
  }

  Future<dynamic> dialog() {
    return showDialog(
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
                child: ElevatedButton(
                  onPressed: () {
                    context.go(ProfileScreen.route);
                  },
                  child: const Text('Ok'),
                ),
              )
            ],
          );
        });
  }
}
