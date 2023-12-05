import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:milsat_project_app/extras/components/shared_prefs/keys.dart';
import 'package:milsat_project_app/extras/components/shared_prefs/utils.dart';
import 'package:milsat_project_app/extras/models/decoded_token.dart';
import '../../../../extras/api/blockers_api.dart';
import '../../extras/components/files.dart';

final mentorDetails = FutureProvider<MentorData>((ref) async {
  DecodedTokenResponse? response =
      await SecureStorageUtils.getTokenResponseFromStorage(
          SharedPrefKeys.tokenResponse);
  return ref.read(apiServiceProvider).getMentorData(response?.userId);
});

final allBlockersMentor = FutureProvider((ref) {
  return ref.read(blockerProvider).getRaisedBlockers();
});

class MentorHomePage extends ConsumerStatefulWidget {
  const MentorHomePage({super.key});

  @override
  ConsumerState<MentorHomePage> createState() => _MentorHomePageState();
}

class _MentorHomePageState extends ConsumerState<MentorHomePage> {
  @override
  Widget build(BuildContext context) {
    final mentorData = ref.watch(mentorDetails);
    final allBlockersData = ref.watch(allBlockersMentor);
    return Scaffold(
      body: SafeArea(
        child: mentorData.when(
            data: (data) {
              bool isLessThanOrEqualTo5 = data.mentees!.length <= 5;
              int count = data.mentees!.length;
              int cohortDuration = data.cohort!.cohortDuration!;
              String mentorName = data.fullName!;
              return CustomScrollView(
                slivers: [
                  SliverAppBar(
                    bottom: PreferredSize(
                      preferredSize: Size.fromHeight(-20.h),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 16.w,
                        ),
                        child: Container(
                          height: 30.h,
                          color: Theme.of(context).scaffoldBackgroundColor,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Recent Actvities',
                                style: GoogleFonts.raleway(
                                  color: const Color(0xFF504D51),
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  AppNavigator.navigateTo(viewAllRoute);
                                },
                                child: Text(
                                  'view all',
                                  style: GoogleFonts.raleway(
                                    color: AppTheme.kPurpleColor,
                                    fontSize: 10.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    pinned: true,
                    automaticallyImplyLeading: false,
                    elevation: 0,
                    expandedHeight: 320.h,
                    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                    flexibleSpace: FlexibleSpaceBar(
                      background: Container(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        padding: EdgeInsets.only(
                          left: 16.w,
                          right: 16.w,
                          top: 20.h,
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                    'Hi, ${mentorName.split(' ').elementAt(0)}',
                                    style: kAppBarTextStyle),
                                Row(
                                  children: [
                                    // SvgPicture.asset(
                                    //   'assets/bell_icon.svg',
                                    // ),
                                    SizedBox(
                                      width: 24.w,
                                    ),
                                    ref.watch(image) != null
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
                                        : personalInfo['personalUserInfo'] !=
                                                    null &&
                                                personalInfo['personalUserInfo']
                                                        ['profile_picture'] !=
                                                    null
                                            ? CircleAvatar(
                                                radius: 24.r,
                                                backgroundImage: NetworkImage(
                                                  personalInfo[
                                                          'personalUserInfo']
                                                      ['profile_picture'],
                                                ),
                                                backgroundColor: Colors.grey,
                                              )
                                            : CircleAvatar(
                                                radius: 24.r,
                                                backgroundImage:
                                                    data.profilePicture == null
                                                        ? const AssetImage(
                                                            'assets/defaultImage.jpg',
                                                          )
                                                        : NetworkImage(
                                                            data.profilePicture,
                                                          ) as ImageProvider<
                                                            Object>?,
                                                backgroundColor: Colors.grey,
                                              ),
                                  ],
                                )
                              ],
                            ),
                            SizedBox(
                              height: 36.h,
                            ),
                            Stack(
                              children: [
                                CohortCard(
                                  height: 180.h,
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
                                ),
                                MentorCardContent(
                                  count: count,
                                  isLessThanOrEqualTo5: isLessThanOrEqualTo5,
                                  cohortDuration: cohortDuration,
                                  trackName: data.track?.name,
                                  d: data,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.only(
                        left: 16.w,
                        right: 16.w,
                        top: 16.w,
                      ),
                      child: allBlockersData.when(
                          data: (data) {
                            getPendngAndResolvedList();
                            return SizedBox(
                              height: 500.h,
                              child: ListView.separated(
                                itemBuilder: ((context, index) {
                                  String time =
                                      cred['blockers'][index]['created_at'];
                                  DateTime p = DateTime.parse(time);
                                  DateTime now = DateTime.now();

                                  final duration = now.difference(p);
                                  final timeAgo = duration.inDays;
                                  return Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 16.w,
                                      vertical: 16.w,
                                    ),
                                    color: AppTheme.kAppWhiteScheme,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        GestureDetector(
                                          onTap: () {},
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                '${cred['blockers'][index]['title']}',
                                                style:
                                                    kOnboardingLightTextStyle,
                                              ),
                                              Row(
                                                children: [
                                                  cred['blockers'][index]
                                                              ['status'] ==
                                                          0
                                                      ? SvgPicture.asset(
                                                          'assets/double_mark.svg')
                                                      : const SizedBox.shrink(),
                                                  Text(
                                                    cred['blockers'][index]
                                                                ['status'] ==
                                                            0
                                                        ? status[0] as String
                                                        : status[1] as String,
                                                    style: GoogleFonts.raleway(
                                                      color: const Color(
                                                          0xFF11A263),
                                                      fontSize: 10.sp,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 4.h,
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              '${cred['blockers'][index]['user_name']}',
                                              style: kTrackTextStyle,
                                            ),
                                            SizedBox(
                                              width: 8.w,
                                            ),
                                            Text(
                                              '$timeAgo days ago',
                                              style: kTimeTextStyle,
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 10.h,
                                        ),
                                        Text(
                                          'Hi everyone,\n'
                                          '${cred['blockers'][index]['description']}',
                                          style: GoogleFonts.raleway(
                                            fontSize: 13.sp,
                                            fontWeight: FontWeight.w500,
                                            color: const Color(0xFF504D51),
                                            height: 2.h,
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }),
                                itemCount: cred['blockers'] == null
                                    ? 0
                                    : cred['blockers'].length,
                                separatorBuilder:
                                    (BuildContext context, int index) {
                                  return SizedBox(
                                    height: 16.h,
                                  );
                                },
                              ),
                            );
                          },
                          error: (((error, stackTrace) =>
                              Text(error.toString()))),
                          loading: () {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }),
                    ),
                  ),
                ],
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
            }),
      ),
    );
  }
}
