import 'package:flutter/material.dart';

import 'package:milsat_project_app/extras/components/files.dart';

class MentorSlip extends StatelessWidget {
  const MentorSlip({
    super.key,
    required this.mentorName,
    this.profileUrl,
    this.onTap,
  });

  final String mentorName;
  final String? profileUrl;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          if (profileUrl != null)
            CircleAvatar(
              radius: 12,
              backgroundImage: NetworkImage(
                profileUrl!,
              ),
            )
          else
            const CircleAvatar(
              radius: 12,
              backgroundColor: Colors.grey,
              backgroundImage: AssetImage(
                'assets/placeholder-person.png',
              ),
            ),
          const SizedBox(
            width: 8,
          ),
          Text(
            mentorName,
            style: kNameTextStyle,
          ),
        ],
      ),
    );
  }
}
