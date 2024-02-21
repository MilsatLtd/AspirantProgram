// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:milsat_project_app/extras/components/shared_prefs/keys.dart';
import 'package:milsat_project_app/extras/components/shared_prefs/utils.dart';
import 'package:milsat_project_app/extras/models/decoded_token.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../extras/components/files.dart';
import '../../../../extras/models/aspirant_model.dart';

String courseContent = '';

final coursesDetails = FutureProvider.autoDispose<CourseModel>((ref) async {
  DecodedTokenResponse? decodedToken =
      await SecureStorageUtils.getDataFromStorage<DecodedTokenResponse>(
          SharedPrefKeys.tokenResponse, DecodedTokenResponse.fromJsonString);
  return ref
      .read(apiServiceProvider)
      .getTrackCourses(decodedToken!.userId!, d.track!.trackId!);
});

final tapped = StateProvider<bool>((ref) {
  return false;
});

class TrackDetails extends ConsumerStatefulWidget {
  const TrackDetails({required this.d, super.key});

  final AspirantModelClass d;

  @override
  ConsumerState<TrackDetails> createState() => _TrackDetailsConsumerState();
}

class _TrackDetailsConsumerState extends ConsumerState<TrackDetails> {
  @override
  Widget build(BuildContext context) {
    final courseData = ref.watch(coursesDetails);
    return WillPopScope(
        onWillPop: () async {
          final shouldPop = await popToHome(context);

          return shouldPop ?? false;
        },
        child: Scaffold(
            body: courseData.when(
                data: (data) {
                  courseContent = data.description!;
                  List<String> wordCount = courseContent.split(' ');
                  double height = ((wordCount.length * 2.075) + 1.55);
                  Future<void> launchUrl_(int index) async {
                    final Uri url =
                        Uri.parse(data.courses!.elementAt(index).accessLink!);
                    if (!await launchUrl(url)) {
                      throw Exception('Could not launch $url');
                    }
                  }

                  return SafeArea(
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            CohortCard(
                              height: ref.watch(tapped) &&
                                      courseContent.length > 250
                                  ? height + 150
                                  : 244,
                              radius: const BorderRadius.only(
                                bottomLeft: Radius.circular(24),
                                bottomRight: Radius.circular(24),
                              ),
                              width: double.infinity,
                              first: -10.5,
                              second_1: 0,
                              second_2: 22.77,
                              third: 83.53,
                              forth_1: -18.43,
                              forth_2: -37.95,
                              forthHeight: 144.16,
                              thirdHeight: 211.42,
                              secondHeight: 124.11,
                            ),
                            TrackContent(
                              maxLines: ref.watch(tapped) ? null : 4,
                              overflow: ref.watch(tapped)
                                  ? null
                                  : TextOverflow.ellipsis,
                              onTap: () {
                                ref.read(tapped.notifier).state =
                                    !ref.watch(tapped);
                              },
                              courseContent: courseContent,
                              text: wordCount.length <= 30
                                  ? ''
                                  : ref.watch(tapped)
                                      ? 'Read Less'
                                      : 'Read More',
                              height: wordCount.length <= 46 ||
                                      ref.watch(tapped) == false
                                  ? 97
                                  : 180,
                              d: data,
                            ),
                          ],
                        ),
                        Expanded(
                          child: RefreshIndicator(
                            onRefresh: () => ref.refresh(coursesDetails.future),
                            child: ListView.separated(
                              itemBuilder: (BuildContext context, int index) {
                                bool canView =
                                    data.courses!.elementAt(index).canView!;
                                return TrackDetailsCard(
                                  itemPosition: !canView
                                      ? SvgPicture.asset(
                                          'assets/lock_icon.svg',
                                          color: const Color(0xFF79717A),
                                        )
                                      : Container(
                                          height: 24,
                                          width: 24,
                                          decoration: BoxDecoration(
                                            color: const Color(0xFFF2EBF3),
                                            borderRadius:
                                                BorderRadius.circular(4),
                                          ),
                                          child: Center(
                                            child: Text(
                                              '${index + 1}',
                                              style: GoogleFonts.raleway(
                                                fontSize: 13,
                                                fontWeight: FontWeight.w500,
                                                color: const Color(0xFF6E6B6F),
                                              ),
                                            ),
                                          ),
                                        ),
                                  trackName:
                                      data.courses!.elementAt(index).name!,
                                  color: !canView
                                      ? AppTheme.kLightPurpleColor
                                      : AppTheme.kPurpleColor,
                                  textColor: const Color(0xFF504D51),
                                  submittedCertificate: () {
                                    canView == false
                                        ? null
                                        : Navigator.pushReplacement(context,
                                            MaterialPageRoute(
                                                builder: (context) {
                                            return CourseDetails(
                                              courseTitle: data.courses!
                                                  .elementAt(index)
                                                  .name!,
                                              courseDescription: data.courses!
                                                  .elementAt(index)
                                                  .description!,
                                              courseRequirementTitle:
                                                  'Course Requirement',
                                              courseRequirement: data.courses!
                                                  .elementAt(index)
                                                  .requirements!,
                                              pressed: () {
                                                launchUrl_(index);
                                              },
                                              courseId: data.courses!
                                                  .elementAt(index)
                                                  .courseId!,
                                            );
                                          }));
                                  },
                                  borderColor: !canView
                                      ? AppTheme.kPurpleColor.withOpacity(0.5)
                                      : AppTheme.kPurpleColor,
                                  buttonTextColor: !canView
                                      ? AppTheme.kPurpleColor.withOpacity(0.5)
                                      : AppTheme.kAppWhiteScheme,
                                  backGroundColor: canView
                                      ? AppTheme.kPurpleColor
                                      : AppTheme.kAppWhiteScheme,
                                );
                              },
                              itemCount: data.courses!.length,
                              separatorBuilder:
                                  (BuildContext context, int index) {
                                return const SizedBox(
                                  height: 24,
                                );
                              },
                            ),
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
                })));
  }

  Future<bool?> popToHome(BuildContext context) async {
    Navigator.pop(context, true);
    AppNavigator.navigateToAndReplace(homeRoute);
    return null;
  }
}
