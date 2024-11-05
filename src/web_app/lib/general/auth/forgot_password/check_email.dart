import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../extras/components/files.dart';
import '../../../main.dart';

class CheckEmailScreen extends StatefulWidget {
  static const String name = 'check-email-screen';
  static const String route = '/check-email-screen';
  const CheckEmailScreen({super.key});

  @override
  State<CheckEmailScreen> createState() => _CheckEmailScreenState();
}

class _CheckEmailScreenState extends State<CheckEmailScreen> {
  // Variable to store the calculated width
  double? screenWidthPercentage;

  @override
  void initState() {
    super.initState();

    screenWidthPercentage = screenWidth > 800
        ? screenWidth * 0.25 // Desktop view (25% of screen width)
        : screenWidth * 0.9; // Mobile view (90% of screen width)
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: true,
        leading: InkWell(
          onTap: context.pop,
          child: const Icon(
            Icons.arrow_back_outlined,
            color: Colors.black,
          ),
        ),
      ),
      body: screenWidthPercentage == null
          ? const Center(child: CircularProgressIndicator())
          : Center(
              child: SizedBox(
                width: screenWidthPercentage,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Center(
                      child: Container(
                        height: 168,
                        width: 168,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: const Color(0xFFF2EBF3).withOpacity(0.5),
                        ),
                        child: Center(
                          child: SvgPicture.asset(
                            'assets/email_svg.svg',
                            height: 54.54,
                            width: 60.96,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 34,
                    ),
                    Text(
                      'Check your Email',
                      style: GoogleFonts.raleway(
                        fontWeight: FontWeight.w700,
                        fontSize: 24,
                        color: const Color(0xFF383639),
                      ),
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    Text(
                      'A reset has been sent to your mail,\n'
                      'follow the instruction ',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.raleway(
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                        color: const Color(0xFF6E6B6F),
                        height: 1.75,
                      ),
                    ),
                    const SizedBox(
                      height: 138,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Didn\'t receive mail:',
                          style: GoogleFonts.raleway(
                            fontWeight: FontWeight.w500,
                            fontSize: 13,
                            color: const Color(0xFF383639),
                          ),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        InkWell(
                          onTap: () {},
                          child: Text(
                            'Resend',
                            style: GoogleFonts.raleway(
                              fontWeight: FontWeight.w600,
                              fontSize: 13,
                              color: AppTheme.kPurpleColor,
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
