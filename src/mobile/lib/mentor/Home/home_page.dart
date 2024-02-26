// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:milsat_project_app/extras/components/shared_prefs/keys.dart';
import 'package:milsat_project_app/extras/components/shared_prefs/utils.dart';
import 'package:milsat_project_app/extras/models/decoded_token.dart';
import 'package:milsat_project_app/extras/models/profile_picture_model.dart';
import 'package:milsat_project_app/mentor/more/blocker/reply_blocker.dart';
import 'package:milsat_project_app/mentor/profile/profile.dart';
import '../../../../extras/api/blockers_api.dart';
import '../../extras/components/files.dart';

final mentorDetails = FutureProvider<MentorData>((ref) async {
  DecodedTokenResponse? response =
      await SecureStorageUtils.getDataFromStorage<DecodedTokenResponse>(
          SharedPrefKeys.tokenResponse, DecodedTokenResponse.fromJsonString);
  return ref.read(apiServiceProvider).getMentorData(response?.userId);
});

final allBlockersMentor = FutureProvider.autoDispose((ref) async {
  MentorData? userData =
      await SecureStorageUtils.getDataFromStorage<MentorData>(
          SharedPrefKeys.userData, MentorData.fromJsonString);
  return ref
      .read(apiBlockerServiceProvider)
      .getRaisedBlockersById(userData?.track?.trackId ?? '');
});

class MentorHomePage extends ConsumerStatefulWidget {
  const MentorHomePage({super.key});

  @override
  ConsumerState<MentorHomePage> createState() => _MentorHomePageState();
}

class _MentorHomePageState extends ConsumerState<MentorHomePage> {
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
                    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                    expandedHeight: 320,
                    automaticallyImplyLeading: false,
                    flexibleSpace: FlexibleSpaceBar(
                      background: Container(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        padding: const EdgeInsets.only(
                          left: 16,
                          right: 16,
                          top: 20,
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Hi, ${mentorName.split(' ').elementAt(0)}',
                                  style: kAppBarTextStyle,
                                ),
                                ref.watch(mentorImage) != null
                                    ? CircleAvatar(
                                        radius: 24,
                                        backgroundColor: Colors.grey,
                                        child: ClipOval(
                                          child: Image.file(
                                            ref.watch(mentorImage)!,
                                            height: 48,
                                            width: 48,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      )
                                    : profilePictureResponse?.profilePicture !=
                                            null
                                        ? CircleAvatar(
                                            radius: 24,
                                            backgroundImage: NetworkImage(
                                              profilePictureResponse!
                                                  .profilePicture!,
                                            ),
                                            backgroundColor: Colors.grey,
                                          )
                                        : CircleAvatar(
                                            radius: 24,
                                            backgroundImage: data
                                                        .profilePicture ==
                                                    null
                                                ? const AssetImage(
                                                    'assets/placeholder-person.png',
                                                  )
                                                : NetworkImage(
                                                    data.profilePicture,
                                                  ) as ImageProvider<Object>?,
                                            backgroundColor: Colors.grey,
                                          ),
                              ],
                            ),
                            const SizedBox(
                              height: 36,
                            ),
                            Stack(
                              children: [
                                CohortCard(
                                  height: 180,
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
                                ),
                                MentorCardContent(
                                  count: count,
                                  isLessThanOrEqualTo5: isLessThanOrEqualTo5,
                                  cohortDuration: cohortDuration,
                                  trackName: data.track?.name ?? '',
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
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Recent activities',
                            style: GoogleFonts.raleway(
                              color: const Color(0xFF504D51),
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              AppNavigator.navigateTo(viewAllRoute);
                            },
                            child: Text(
                              'View all',
                              style: GoogleFonts.raleway(
                                color: const Color(0xFF803785),
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SliverPadding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 16,
                        horizontal: 16,
                      ),
                      sliver: SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            String time = cred['blockers'][index]['created_at'];
                            DateTime p = DateTime.parse(time);
                            DateTime now = DateTime.now();
                            final duration = now.difference(p);
                            final timeAgo = duration.inDays;
                            return allBlockersData.when(
                              data: (data) {
                                return GestureDetector(
                                  onTap: () async {
                                    final comments = await ref
                                        .read(apiBlockerServiceProvider)
                                        .getCommentsById(cred['blockers'][index]
                                            ['blocker_id']);
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (context) {
                                      return ReplyBlocker(
                                        description:
                                            '${cred['blockers'][index]['description']}',
                                        title:
                                            '${cred['blockers'][index]['title']}',
                                        userName:
                                            '${cred['blockers'][index]['user_name']}',
                                        blockerId:
                                            '${cred['blockers'][index]['blocker_id']}',
                                        time: '$timeAgo',
                                        trackId:
                                            '${cred['blockers'][index]['track']}',
                                        comments: comments,
                                      );
                                    }));
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(bottom: 24),
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 16,
                                        vertical: 16,
                                      ),
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: const Color(0xFFCBADCD),
                                        ),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          GestureDetector(
                                            onTap: () {},
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  '${cred['blockers'][index]['title']}',
                                                  style: const TextStyle(
                                                    fontSize: 15,
                                                    color: Color(0xFF504D51),
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                                Row(
                                                  children: [
                                                    cred['blockers'][index]
                                                                ['status'] ==
                                                            0
                                                        ? SvgPicture.asset(
                                                            'assets/double_mark.svg')
                                                        : const SizedBox
                                                            .shrink(),
                                                    Text(
                                                      cred['blockers'][index]
                                                                  ['status'] ==
                                                              0
                                                          ? status[0] as String
                                                          : status[1] as String,
                                                      style:
                                                          GoogleFonts.raleway(
                                                        color: const Color(
                                                            0xFF11A263),
                                                        fontSize: 10,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 4,
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                '${cred['blockers'][index]['user_name']}',
                                                style: kTrackTextStyle,
                                              ),
                                              const SizedBox(
                                                width: 8,
                                              ),
                                              Text(
                                                '$timeAgo days ago',
                                                style: kTimeTextStyle,
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            'Hi everyone,\n'
                                            '${cred['blockers'][index]['description']}',
                                            style: GoogleFonts.raleway(
                                              fontSize: 13,
                                              fontWeight: FontWeight.w500,
                                              color: const Color(0xFF504D51),
                                              height: 2,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                              error: ((error, stackTrace) => const Text('')),
                              loading: () => const Center(
                                child: CircularProgressIndicator(),
                              ),
                            );
                          },
                          childCount: cred['blockers'] == null
                              ? 0
                              : cred['blockers'].length,
                        ),
                      )),
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
