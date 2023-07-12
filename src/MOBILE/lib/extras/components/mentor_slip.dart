import 'package:flutter/material.dart';

import 'package:milsat_project_app/extras/components/files.dart';

class MentorSlip extends StatelessWidget {
  const MentorSlip({
    super.key,
    required this.mentorName,
    this.profileUrl,
  });

  final String mentorName;
  final String? profileUrl;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (profileUrl != null)
          CircleAvatar(
            radius: 12.r,
            backgroundImage: NetworkImage(
              profileUrl!,
            ),
          )
        else
          CircleAvatar(
            radius: 12.r,
            backgroundImage: const AssetImage(
              'assets/defaultImage.jpg',
            ),
          ),
        SizedBox(
          width: 8.w,
        ),
        Text(
          mentorName,
          style: kNameTextStyle,
        ),
      ],
    );
  }
}
