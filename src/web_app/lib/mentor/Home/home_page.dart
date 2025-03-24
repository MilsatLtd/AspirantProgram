// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:milsat_project_app/extras/components/shared_prefs/keys.dart';
import 'package:milsat_project_app/extras/components/shared_prefs/utils.dart';
import 'package:milsat_project_app/extras/models/decoded_token.dart';
import 'package:milsat_project_app/extras/models/profile_picture_model.dart';
import 'package:milsat_project_app/mentor/more/blocker/reply_blocker.dart';
import 'package:milsat_project_app/mentor/profile/profile.dart';
import '../../../../extras/api/blockers_api.dart';
import '../../extras/components/files.dart';

final mentorDetails = FutureProvider.autoDispose<MentorData>((ref) async {
  DecodedTokenResponse? response =
      await SharedPreferencesUtil.getModel<DecodedTokenResponse>(
          SharedPrefKeys.tokenResponse,
          (json) => DecodedTokenResponse.fromJson(json));
  final mentorsDetailss =
      await ref.read(apiServiceProvider).getMentorData(response?.userId);
  await ref
      .read(apiBlockerServiceProvider)
      .getRaisedBlockersById(mentorsDetailss.track?.trackId ?? "");
  return mentorsDetailss;
});

class MentorHomePage extends ConsumerStatefulWidget {
  const MentorHomePage({super.key});

  @override
  ConsumerState<MentorHomePage> createState() => _MentorHomePageState();
}

class _MentorHomePageState extends ConsumerState<MentorHomePage> {
  ProfilePictureResponse? _profilePicture;
  bool _sortAscending = false; // false means latest first
  late final allBlockersMentorProvider =
      FutureProvider.autoDispose((ref) async {
    final userData = await SharedPreferencesUtil.getModel<MentorData>(
      SharedPrefKeys.userData,
      MentorData.fromJson,
    );
    return ref
        .read(apiBlockerServiceProvider)
        .getRaisedBlockersById(userData?.track?.trackId ?? '');
  });

  @override
  void initState() {
    super.initState();
    _loadUserProfile();
  }

  Future<void> _loadUserProfile() async {
    _profilePicture =
        await SharedPreferencesUtil.getModel<ProfilePictureResponse>(
      SharedPrefKeys.profileResponse,
      ProfilePictureResponse.fromJson,
    );
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final mentorData = ref.watch(mentorDetails);
    final blockersData = ref.watch(allBlockersMentorProvider);

    return Scaffold(
      body: SafeArea(
        child: mentorData.when(
          data: (mentorInfo) {
            return CustomScrollView(
              slivers: [
                _buildAppBar(mentorInfo),
                _buildRecentActivitiesHeader(),
                _buildBlockersList(blockersData),
              ],
            );
          },
          error: (error, _) => _buildErrorState(error, context),
          loading: () => const Center(child: CircularProgressIndicator()),
        ),
      ),
    );
  }

  Widget _buildAppBar(MentorData data) {
    return SliverAppBar(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      expandedHeight: 320,
      automaticallyImplyLeading: false,
      flexibleSpace: FlexibleSpaceBar(
        background: _buildAppBarContent(data),
      ),
    );
  }

  Widget _buildAppBarContent(MentorData data) {
    final firstName = data.fullName?.split(' ').first ?? '';
    final isSmallCohort = (data.mentees?.length ?? 0) <= 5;

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 0),
      child: Column(
        children: [
          _buildHeader(firstName),
          const SizedBox(height: 36),
          _buildCohortCard(data, isSmallCohort),
        ],
      ),
    );
  }

  Widget _buildHeader(String firstName) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('Hi, $firstName', style: kAppBarTextStyle),
        _buildProfileImage(),
      ],
    );
  }

  Widget _buildProfileImage() {
    final mentorImageFile = ref.watch(mentorImage);

    if (mentorImageFile != null) {
      return CircleAvatar(
        radius: 24,
        backgroundColor: Colors.grey,
        child: ClipOval(
          child: Image.file(
            mentorImageFile,
            height: 48,
            width: 48,
            fit: BoxFit.cover,
          ),
        ),
      );
    }

    if (_profilePicture?.profilePicture != null) {
      return CircleAvatar(
        radius: 24,
        backgroundImage: NetworkImage(_profilePicture!.profilePicture!),
        backgroundColor: Colors.grey,
      );
    }

    return const CircleAvatar(
      radius: 24,
      backgroundImage: AssetImage('assets/placeholder-person.png'),
      backgroundColor: Colors.grey,
    );
  }

  Widget _buildRecentActivitiesHeader() {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
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
            Row(
              children: [
                IconButton(
                  icon: Icon(
                    _sortAscending ? Icons.arrow_upward : Icons.arrow_downward,
                    size: 20,
                    color: const Color(0xFF803785),
                  ),
                  onPressed: () {
                    setState(() {
                      _sortAscending = !_sortAscending;
                    });
                  },
                ),
                TextButton(
                  onPressed: () => context.push(ViewAllPage.route),
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
          ],
        ),
      ),
    );
  }

  Widget _buildBlockersList(AsyncValue<dynamic> blockersData) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      sliver: blockersData.when(
        data: (data) {
          if (cred['blockers'] == null || cred['blockers'].isEmpty) {
            return const SliverToBoxAdapter(
              child: Center(
                child: Text('No blockers found'),
              ),
            );
          }

          final sortedBlockers =
              List<Map<String, dynamic>>.from(cred['blockers'])
                ..sort((a, b) {
                  final DateTime dateA = DateTime.parse(a['created_at']);
                  final DateTime dateB = DateTime.parse(b['created_at']);
                  return _sortAscending
                      ? dateA.compareTo(dateB) // Oldest first
                      : dateB.compareTo(dateA); // Latest first
                });

          return SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final blocker = sortedBlockers[index];
                final timeAgo = _calculateTimeAgo(blocker['created_at']);

                return _buildBlockerItem(blocker, timeAgo);
              },
              childCount: sortedBlockers.length,
            ),
          );
        },
        error: (error, _) => SliverToBoxAdapter(
          child: Center(
            child: Text('Error loading blockers: $error'),
          ),
        ),
        loading: () => const SliverToBoxAdapter(
          child: Center(child: CircularProgressIndicator()),
        ),
      ),
    );
  }

  int _calculateTimeAgo(String createdAt) {
    final created = DateTime.parse(createdAt);
    return DateTime.now().difference(created).inDays;
  }

  Widget _buildBlockerItem(Map<String, dynamic> blocker, int timeAgo) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: InkWell(
        onTap: () => _handleBlockerTap(blocker, timeAgo),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            border: Border.all(color: const Color(0xFFCBADCD)),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildBlockerHeader(blocker),
              const SizedBox(height: 4),
              _buildBlockerSubHeader(blocker, timeAgo),
              const SizedBox(height: 10),
              _buildBlockerDescription(blocker),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBlockerHeader(Map<String, dynamic> blocker) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          blocker['title'],
          style: const TextStyle(
            fontSize: 15,
            color: Color(0xFF504D51),
            fontWeight: FontWeight.w600,
          ),
        ),
        _buildBlockerStatus(blocker['status']),
      ],
    );
  }

  Widget _buildBlockerStatus(int status) {
    final isResolving = status == 0;
    return Row(
      children: [
        if (isResolving) SvgPicture.asset('assets/double_mark.svg'),
        Text(
          status == 0 ? 'Pending' : 'Resolved',
          style: GoogleFonts.raleway(
            color: const Color(0xFF11A263),
            fontSize: 10,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildBlockerSubHeader(Map<String, dynamic> blocker, int timeAgo) {
    return Row(
      children: [
        Text(blocker['user_name'], style: kTrackTextStyle),
        const SizedBox(width: 8),
        Text('$timeAgo days ago', style: kTimeTextStyle),
      ],
    );
  }

  Widget _buildBlockerDescription(Map<String, dynamic> blocker) {
    return Text(
      'Hi everyone,\n${blocker['description']}',
      style: GoogleFonts.raleway(
        fontSize: 13,
        fontWeight: FontWeight.w500,
        color: const Color(0xFF504D51),
        height: 2,
      ),
    );
  }

  Future<void> _handleBlockerTap(
      Map<String, dynamic> blocker, int timeAgo) async {
    final comments = await ref
        .read(apiBlockerServiceProvider)
        .getCommentsById(blocker['blocker_id']);

    if (!mounted) return;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ReplyBlocker(
          mentorName: mentorDetails.name ?? "",
          description: blocker['description'],
          title: blocker['title'],
          userName: blocker['user_name'],
          blockerId: blocker['blocker_id'],
          time: timeAgo.toString(),
          trackId: blocker['track'],
          comments: comments,
        ),
      ),
    );
  }

  Widget _buildCohortCard(MentorData data, bool isSmallCohort) {
    return Stack(
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
          count: data.mentees?.length ?? 0,
          isLessThanOrEqualTo5: isSmallCohort,
          cohortDuration: data.cohort?.cohortDuration ?? 0,
          trackName: data.track?.name ?? '',
          d: data,
        ),
      ],
    );
  }

  Widget _buildErrorState(Object error, BuildContext context) {
    return Padding(
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
                      style: TextStyle(color: Theme.of(context).cardColor),
                    ),
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
