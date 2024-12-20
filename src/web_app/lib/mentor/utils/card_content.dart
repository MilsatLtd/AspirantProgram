import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:milsat_project_app/extras/components/files.dart';

class MentorCardContent extends StatelessWidget {
  const MentorCardContent(
      {super.key,
      required this.count,
      required this.isLessThanOrEqualTo5,
      required this.cohortDuration,
      required this.trackName,
      required this.d});

  final int count;
  final bool isLessThanOrEqualTo5;
  final int? cohortDuration;
  final String? trackName;
  final MentorData d;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        top: 18,
        bottom: 16,
      ),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Ongoing Track:',
                  style: kSmallTextStyle,
                ),
                cohortDuration == 1
                    ? Text(
                        'Cohort duration: $cohortDuration week',
                        style: kSmallTextStyle,
                      )
                    : Text(
                        'Cohort duration: $cohortDuration weeks',
                        style: kSmallTextStyle,
                      ),
              ],
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16),
            child: Text(
              trackName!,
              style: GoogleFonts.raleway(
                color: AppTheme.kAppWhiteScheme,
                fontSize: 16,
                fontWeight: FontWeight.w800,
                height: 1.75,
              ),
            ),
          ),
          const SizedBox(
            height: 32,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return AllAspirants(d: d);
                }));
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Mentee\'s',
                    style: kSmallTextStyle2,
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  Row(
                    children: [
                      Row(
                        children: [
                          for (int i = 0; i < d.mentees!.length; i++) ...{
                            if (i < 5) ...{
                              if (d.mentees!.isNotEmpty) ...{
                                Align(
                                  widthFactor: 0.5,
                                  child: CircleAvatar(
                                    radius: 14,
                                    backgroundColor:
                                        Theme.of(context).primaryColor,
                                    child: CircleAvatar(
                                      radius: 12,
                                      backgroundColor: Colors.grey,
                                      backgroundImage: d.mentees
                                                  ?.elementAt(i)
                                                  .profilePicture ==
                                              null
                                          ? const AssetImage(
                                              'assets/placeholder-person.png',
                                            )
                                          : NetworkImage(d.mentees!
                                                  .elementAt(i)
                                                  .profilePicture!)
                                              as ImageProvider,
                                    ),
                                  ),
                                ),
                              }
                            }
                          }
                        ],
                      ),
                      const SizedBox(width: 16),
                      if (d.mentees!.length >= 5) ...{
                        Text(
                          '+${d.mentees!.length - 5} more',
                          style: const TextStyle(color: Colors.white),
                        )
                      }
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
