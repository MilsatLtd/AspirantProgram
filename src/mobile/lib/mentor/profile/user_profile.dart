import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../extras/components/files.dart';

class UserProfile extends StatelessWidget {
  const UserProfile({
    super.key,
    required this.userName,
    required this.image,
    required this.userEmail,
    this.userBio = '',
  });
  final String userName;
  final String image;
  final String userEmail;
  final String userBio;

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
            if (image.isEmpty)
              Center(
                child: CircleAvatar(
                  radius: 44,
                  backgroundColor: Colors.grey,
                  backgroundImage: NetworkImage(
                    image,
                  ),
                ),
              )
            else
              Center(
                child: CircleAvatar(
                  radius: 44,
                  backgroundColor: Colors.grey,
                  backgroundImage: AssetImage(
                    image,
                  ),
                ),
              ),
            const SizedBox(
              height: 34,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Name',
                    style: GoogleFonts.raleway(
                      color: const Color(0xFF504D51),
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    height: 48,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: Border.all(color: AppTheme.kHintTextColor),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      userName,
                      style: GoogleFonts.raleway(
                        color: const Color(0xFF6E6B6F),
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  Text(
                    'Email',
                    style: GoogleFonts.raleway(
                      color: const Color(0xFF504D51),
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    height: 48,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: Border.all(color: AppTheme.kHintTextColor),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      userEmail,
                      textAlign: TextAlign.left,
                      style: GoogleFonts.raleway(
                        color: const Color(0xFF6E6B6F),
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  Text(
                    'Bio',
                    style: GoogleFonts.raleway(
                      color: const Color(0xFF504D51),
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Container(
                    padding: const EdgeInsets.all(8),
                    height: 100,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(
                        color: const Color(0xFF6E6B6F),
                      ),
                    ),
                    child: Text(userBio),
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
