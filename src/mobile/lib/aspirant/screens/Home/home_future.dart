import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:milsat_project_app/extras/components/shared_prefs/keys.dart';
import 'package:milsat_project_app/extras/components/shared_prefs/utils.dart';
import 'package:milsat_project_app/extras/models/aspirant_model.dart';
import 'package:milsat_project_app/extras/models/profile_picture_model.dart';
import '../../../extras/components/files.dart';

late AspirantModelClass d;

homeWidget(BuildContext context, WidgetRef ref,
    ProfilePictureResponse? profilePictureResponse) {
  DateTime now = ref.watch(currentTimeProvider);
  String dayOfWeek = DateFormat('EEEE').format(now);
  final aspirantData = ref.watch(aspirantDetails);
  return aspirantData.when(data: (data) {
    if (data != null) {
      String userName = data.fullName ?? 'Stranger';
      d = data;
      return WillPopScope(
        onWillPop: () async {
          final shouldPop = await showWarning(context);
          return shouldPop ?? false;
        },
        child: Scaffold(
          appBar: AppBar(
            title: Text('Hi, ${userName.split(' ').elementAt(0)}',
                style: kAppBarTextStyle),
            automaticallyImplyLeading: false,
            backgroundColor: Colors.transparent,
            elevation: 0,
            actions: [
              Padding(
                padding: const EdgeInsets.only(
                  right: 12,
                  top: 4,
                ),
                child: GestureDetector(
                  onTap: () {
                    AppNavigator.navigateTo(profileRoute);
                  },
                  child: ref.watch(image) != null
                      ? CircleAvatar(
                          radius: 24,
                          backgroundColor: Colors.grey,
                          child: ClipOval(
                            child: Image.file(
                              ref.watch(image)!,
                              height: 48,
                              width: 48,
                              fit: BoxFit.cover,
                            ),
                          ),
                        )
                      : profilePictureResponse?.profilePicture != null
                          ? CircleAvatar(
                              radius: 44,
                              backgroundImage: NetworkImage(
                                profilePictureResponse!.profilePicture!,
                              ),
                              backgroundColor: Colors.grey,
                            )
                          : CircleAvatar(
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
                ),
              )
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.only(
              top: 24,
              left: 16,
              right: 16,
            ),
            child: RefreshIndicator(
              onRefresh: () => ref.refresh(aspirantDetails.future),
              child: ListView(
                padding: const EdgeInsets.only(left: 6),
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 24),
                        child: CustomHolder(
                          color: AppTheme.kLightPurpleColor.withOpacity(0.4),
                          icon: SvgPicture.asset(
                            'assets/blocker_icon.svg',
                          ),
                          label: 'Blocker',
                          onTap: () {
                            AppNavigator.navigateTo(blockerRoute);
                          },
                        ),
                      ),
                      const SizedBox(
                        width: 68,
                      ),
                      CustomHolder(
                        color: AppTheme.kLightGreenColor,
                        icon: SvgPicture.asset(
                          'assets/report_icon.svg',
                        ),
                        label: 'Report',
                        onTap: () {
                          if (dayOfWeek != 'Saturday' ||
                              dayOfWeek != 'Sunday') {
                            AppNavigator.navigateTo(reportRoute);
                          } else {
                            showModalBottomSheet(
                                enableDrag: false,
                                isDismissible: false,
                                elevation: 1,
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(16),
                                    topRight: Radius.circular(16),
                                  ),
                                ),
                                context: context,
                                builder: (context) {
                                  return Container(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 16,
                                      horizontal: 16,
                                    ),
                                    height: 256,
                                    decoration: const BoxDecoration(
                                      color: AppTheme.kAppWhiteScheme,
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(16),
                                        topRight: Radius.circular(16),
                                      ),
                                    ),
                                    child: Column(
                                      children: [
                                        Container(
                                          height: 4,
                                          width: 42,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(4),
                                            color: Colors.black,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 27,
                                        ),
                                        Text(
                                          'Report submission currently\n unavailable, please check \nback later.',
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.raleway(
                                            height: 2,
                                            color: const Color(0xFF383639),
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 23,
                                        ),
                                        CustomButton(
                                          height: 54,
                                          pressed: () {
                                            AppNavigator.pop();
                                          },
                                          color: AppTheme.kPurpleColor,
                                          width: double.infinity,
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          child: Text(
                                            'Got it!',
                                            style: GoogleFonts.raleway(
                                              color: AppTheme.kAppWhiteScheme,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 14,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  );
                                });
                          }
                        },
                      ),
                    ],
                  ),
                  Stack(
                    children: [
                      CohortCard(
                        height: MediaQuery.of(context).size.height * 0.393,
                        width: MediaQuery.of(context).size.width - 41,
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
                      ),
                      CardContent(
                        contentDuration: data.cohort?.cohortDuration ?? 0,
                        numberEnrolled: data.track?.enrolledCount ?? 0,
                        trackName: data.track?.name ?? '',
                        mentorName: data.mentor?.fullName ?? '',
                        d: data,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }
  }, error: (((error, stackTrace) {
    Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            children: [
              CohortCard(
                width: double.infinity,
                height: 212,
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
              ),
              Column(
                children: [
                  SvgPicture.asset(
                    'assets/error_image.svg',
                    height: 100,
                    width: 100,
                  ),
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      error.toString(),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Theme.of(context).cardColor,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  })), loading: () {
    return const Center(
      child: CircularProgressIndicator(),
    );
  });
}

Future<bool?> showWarning(BuildContext context) async {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            'Do you want to sign out of the app?',
            style: GoogleFonts.raleway(
              color: const Color(0xFF423B43),
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context, false);
              },
              child: Text(
                'No',
                style: GoogleFonts.raleway(
                  color: AppTheme.kPurpleColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context, true);
                SecureStorageUtils.deleteAnyDataFromStorage(
                    SharedPrefKeys.accessToken);
                SecureStorageUtils.deleteAnyDataFromStorage(
                    SharedPrefKeys.tokenResponse);
                SecureStorageUtils.deleteAnyDataFromStorage(
                    SharedPrefKeys.profileResponse);
                SecureStorageUtils.deleteAnyDataFromStorage(
                    SharedPrefKeys.refreshToken);
                AppNavigator.navigateToAndClear(loginRoute);
              },
              child: Text(
                'Yes',
                style: GoogleFonts.raleway(
                  color: AppTheme.kPurpleColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                ),
              ),
            ),
          ],
        );
      });
  return null;
}
