import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:milsat_project_app/extras/models/aspirant_model.dart';
import '../../../extras/components/files.dart';

late AspirantModelClass d;

homeWidget(BuildContext context, WidgetRef ref) {
  DateTime now = ref.watch(currentTimeProvider);
  String dayOfWeek = DateFormat('EEEE').format(now);
  if (kDebugMode) {
    print(now.day);
    print(dayOfWeek);
  }
  final aspirantData = ref.watch(aspirantDetails);
  return aspirantData.when(
      data: (data) {
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
                    padding: EdgeInsets.only(
                      // right: 12.w,
                      top: 4.h,
                    ),
                    child: GestureDetector(
                      onTap: () {
                        AppNavigator.navigateTo(profileRoute);
                      },
                      child: ref.watch(image) != null
                          ? CircleAvatar(
                              radius: 24.r,
                              backgroundColor: Colors.grey,
                              child: ClipOval(
                                child: Image.file(
                                  ref.watch(image)!,
                                  height: 48.h,
                                  width: 48.w,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            )
                          : personalInfo['personalUserInfo'] != null &&
                                  personalInfo['personalUserInfo']
                                          ['profile_picture'] !=
                                      null
                              ? CircleAvatar(
                                  radius: 44.r,
                                  backgroundImage: NetworkImage(
                                    personalInfo['personalUserInfo']
                                        ['profile_picture'],
                                  ),
                                  backgroundColor: Colors.grey,
                                )
                              : CircleAvatar(
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
                    ),
                  )
                ],
              ),
              body: Padding(
                padding: EdgeInsets.only(
                  top: 24.h,
                  left: 16.w,
                  right: 16.w,
                ),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 24.w),
                            child: CustomHolder(
                              color:
                                  AppTheme.kLightPurpleColor.withOpacity(0.4),
                              icon: SvgPicture.asset(
                                'assets/blocker_icon.svg',
                              ),
                              label: 'Blocker',
                              onTap: () {
                                AppNavigator.navigateTo(blockerRoute);
                              },
                            ),
                          ),
                          SizedBox(
                            width: 68.w,
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
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(16.r),
                                        topRight: Radius.circular(16.r),
                                      ),
                                    ),
                                    context: context,
                                    builder: (context) {
                                      return Container(
                                        padding: EdgeInsets.symmetric(
                                          vertical: 16.h,
                                          horizontal: 16.w,
                                        ),
                                        height: 256.h,
                                        decoration: BoxDecoration(
                                          color: AppTheme.kAppWhiteScheme,
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(16.r),
                                            topRight: Radius.circular(16.r),
                                          ),
                                        ),
                                        child: Column(
                                          children: [
                                            Container(
                                              height: 4.h,
                                              width: 42.w,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(4.r),
                                                color: Colors.black,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 27.h,
                                            ),
                                            Text(
                                              'Report submission currently\n unavailable, please check \nback later.',
                                              textAlign: TextAlign.center,
                                              style: GoogleFonts.raleway(
                                                height: 2.h,
                                                color: const Color(0xFF383639),
                                                fontSize: 18.sp,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 23.h,
                                            ),
                                            CustomButton(
                                              height: 54.h,
                                              pressed: () {
                                                AppNavigator.pop();
                                              },
                                              color: AppTheme.kPurpleColor,
                                              width: double.infinity,
                                              borderRadius:
                                                  BorderRadius.circular(8.r),
                                              child: Text(
                                                'Got it!',
                                                style: GoogleFonts.raleway(
                                                  color:
                                                      AppTheme.kAppWhiteScheme,
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 14.sp,
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
                            height: 316.h,
                            width: 343.w,
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
                          CardContent(
                            contentDuration: data.cohort?.cohortDuration,
                            numberEnrolled: data.track?.enrolledCount,
                            trackName: data.track?.name,
                            mentorName: data.mentor?.fullName,
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
                            error.toString(),
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
              fontSize: 15.sp,
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
                  fontSize: 15.sp,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context, true);
                AppNavigator.navigateTo(loginRoute);
              },
              child: Text(
                'Yes',
                style: GoogleFonts.raleway(
                  color: AppTheme.kPurpleColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 15.sp,
                ),
              ),
            ),
          ],
        );
      });
  return null;
}
