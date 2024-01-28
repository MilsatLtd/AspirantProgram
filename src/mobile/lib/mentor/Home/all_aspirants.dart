import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:milsat_project_app/extras/components/files.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../profile/user_profile.dart';

class AllAspirants extends ConsumerWidget {
  const AllAspirants({required this.d, super.key});

  final MentorData d;

  @override
  Widget build(BuildContext context, ref) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            AppNavigator.pop();
          },
          child: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0.5,
        title: Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: 'Mentee ',
                style: GoogleFonts.raleway(
                  color: const Color(0xFF423B43),
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              TextSpan(
                text: ' Total: ${d.mentees!.length}',
                style: GoogleFonts.raleway(
                  color: AppTheme.kHintTextColor,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          final apiService = ref.read(apiServiceProvider);
          apiService.getUserData(d.mentees!.elementAt(index).userId!);
          return AspirantsTile(
            image: d.mentees!.elementAt(index).profilePicture == null
                ? 'assets/defaultImage.jpg'
                : d.mentees!.elementAt(index).profilePicture!,
            column: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  d.mentees!.elementAt(index).fullName!,
                  style: GoogleFonts.raleway(
                    color: const Color(0xFF504D51),
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      'Learning progress: ',
                      style: GoogleFonts.raleway(
                        color: const Color(0xFF504D51),
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      '20% Completion',
                      style: GoogleFonts.raleway(
                        color: const Color(0xFF504D51),
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            border: const Border(
              bottom: BorderSide(
                color: Color(0xFFF2EBF3),
              ),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: ((context) {
                    return UserProfile(
                      userName: d.mentees!.elementAt(index).fullName!,
                      image: d.mentees!.elementAt(index).profilePicture ??
                          'assets/defaultImage.jpg',
                      userEmail: d.mentees!.elementAt(index).email!,
                      userBio: d.mentees!.elementAt(index).bio,
                    );
                  }),
                ),
              );
            },
          );
        },
        itemCount: d.mentees!.length,
      ),
      bottomNavigationBar: const CustomNavBar(),
    );
  }
}

class AspirantModel {
  final String aspirantImage;
  final String names;

  const AspirantModel(
    this.aspirantImage,
    this.names,
  );
}
