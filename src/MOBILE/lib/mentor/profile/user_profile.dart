import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../extras/components/files.dart';

class UserProfile extends StatelessWidget {
  const UserProfile({
    super.key,
    required this.userName,
    required this.image,
    required this.userEmail,
    this.userBio,
  });
  final String userName;
  final String image;
  final String userEmail;
  final String? userBio;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            AppNavigator.pop();
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (image != 'assets/defaultImage.jpg')
              Center(
                child: CircleAvatar(
                  radius: 44.r,
                  backgroundImage: NetworkImage(
                    image,
                  ),
                ),
              )
            else
              Center(
                child: CircleAvatar(
                  radius: 44.r,
                  backgroundImage: AssetImage(
                    image,
                  ),
                ),
              ),
            SizedBox(
              height: 34.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 16.w,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Name',
                    style: GoogleFonts.raleway(
                      color: const Color(0xFF504D51),
                      fontWeight: FontWeight.w500,
                      fontSize: 16.sp,
                    ),
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 12.h,
                    ),
                    height: 48.h,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: Border.all(color: AppTheme.kHintTextColor),
                      borderRadius: BorderRadius.circular(6.r),
                    ),
                    child: Text(
                      userName,
                      style: GoogleFonts.raleway(
                        color: const Color(0xFF6E6B6F),
                        fontWeight: FontWeight.w500,
                        fontSize: 16.sp,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 24.h,
                  ),
                  Text(
                    'Email',
                    style: GoogleFonts.raleway(
                      color: const Color(0xFF504D51),
                      fontWeight: FontWeight.w500,
                      fontSize: 16.sp,
                    ),
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 12.h,
                    ),
                    height: 48.h,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: Border.all(color: AppTheme.kHintTextColor),
                      borderRadius: BorderRadius.circular(6.r),
                    ),
                    child: Text(
                      userEmail,
                      textAlign: TextAlign.left,
                      style: GoogleFonts.raleway(
                        color: const Color(0xFF6E6B6F),
                        fontWeight: FontWeight.w500,
                        fontSize: 16.sp,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 24.h,
                  ),
                  Text(
                    'Bio',
                    style: GoogleFonts.raleway(
                      color: const Color(0xFF504D51),
                      fontWeight: FontWeight.w500,
                      fontSize: 16.sp,
                    ),
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                  Container(
                    padding: const EdgeInsets.all(8),
                    height: 100.h,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6.r),
                      border: Border.all(
                        color: const Color(0xFF6E6B6F),
                      ),
                    ),
                    child: Text(userBio!),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const CustomNavBar(),
    );
  }
}
