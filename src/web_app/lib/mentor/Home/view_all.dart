import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:milsat_project_app/extras/components/files.dart';

class ViewAllPage extends StatelessWidget {
  static const String name = 'view-all';
  static const String route = '/view-all';
  const ViewAllPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(44),
        child: AppBar(
          title: Text(
            'View recent activities',
            style: GoogleFonts.raleway(
              color: const Color(0xFF423B43),
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          backgroundColor: AppTheme.kAppWhiteScheme,
          elevation: 0.5,
          centerTitle: true,
          leading: IconButton(
            onPressed: () {
              context.canPop()
                  ? context.pop()
                  : context.pushReplacement(HomeScreen.route);
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
        ),
        child: cred['blockers'] == []
            ? ListView.separated(
                padding: const EdgeInsets.symmetric(
                  vertical: 16,
                ),
                physics: const AlwaysScrollableScrollPhysics(
                  parent: BouncingScrollPhysics(),
                ),
                itemBuilder: (BuildContext context, int index) {
                  String time = cred['blockers'][index]['created_at'];
                  DateTime p = DateTime.parse(time);
                  DateTime now = DateTime.now();

                  final duration = now.difference(p);
                  final timeAgo = duration.inDays;
                  return Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 16,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      color: AppTheme.kAppWhiteScheme,
                      border: Border.all(
                        color: const Color(0xFFCBADCD),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${cred['blockers'][index]['title']}',
                          style: kOnboardingLightTextStyle,
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
                          overflow: TextOverflow.ellipsis,
                          maxLines: 8,
                          style: GoogleFonts.raleway(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            color: const Color(0xFF504D51),
                            height: 1.75,
                          ),
                        ),
                      ],
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) =>
                    const SizedBox(
                  height: 16,
                ),
                itemCount: cred['blockers'].length,
              )
            : const Center(
                child: Text('No Blocker Raised'),
              ),
      ),
      bottomNavigationBar: const CustomNavBar(),
    );
  }
}
