import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../extras/components/files.dart';

class ScheduleMeetUp extends StatefulWidget {
  static const String name = 'schedule-meetup';
  static const String route = '/schedule-meetup';
  const ScheduleMeetUp({super.key});

  @override
  State<ScheduleMeetUp> createState() => _ScheduleMeetUpState();
}

class _ScheduleMeetUpState extends State<ScheduleMeetUp> {
  String dateFormat = 'DD/MM/YYYY';
  String timeFormat = '0:00 AM';
  final meetController = TextEditingController();
  final titleController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final initialDate = DateTime.now();

  bool form1Completed = false;
  bool form2Completed = false;

  late DateTime date;

  @override
  Widget build(BuildContext context) {
    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: () async {
        final shouldPop = await goToMentorHomePage(context);
        return shouldPop ?? false;
      },
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(44),
          child: AppBar(
            title: Text(
              'Schedule meetup',
              style: GoogleFonts.raleway(
                color: const Color(0xFF423B43),
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            centerTitle: true,
            backgroundColor: AppTheme.kAppWhiteScheme,
            elevation: 0.5,
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
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 33,
                  ),
                  Text(
                    'Title',
                    style: GoogleFonts.raleway(
                      color: const Color(0xFF504D51),
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  MeetupFormField(
                    hintText: 'e.g First team call',
                    controller: titleController,
                    validator: (val) {
                      if (val!.isEmpty) {
                        return 'field cannot be empty';
                      }
                      return null;
                    },
                    onChanged: (val) {
                      setState(() {
                        form1Completed = true;
                      });
                    },
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      DateOrTimeHolder(
                        dateFormat: dateFormat,
                        heading: 'Date',
                        onTap: () async {
                          await showDatePicker(
                            context: context,
                            initialDate: initialDate,
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2035),
                          ).then((value) {
                            if (value == null) return;
                            setState(() {
                              dateFormat =
                                  DateFormat('MMM dd, yyyy').format(value);
                            });
                          });
                        },
                        textColor: dateFormat == 'DD/MM/YYYY'
                            ? AppTheme.kHintTextColor
                            : AppTheme.kBlackColor,
                      ),
                      DateOrTimeHolder(
                        dateFormat: timeFormat,
                        heading: 'Time',
                        onTap: () {
                          showTimePicker(
                            context: context,
                            initialTime: TimeOfDay(
                              hour: initialDate.hour,
                              minute: initialDate.minute,
                            ),
                          ).then((value) {
                            if (value == null) return;
                            setState(() {
                              timeFormat = value.format(context);
                            });
                          });
                        },
                        textColor: timeFormat == '0:00 AM'
                            ? AppTheme.kHintTextColor
                            : AppTheme.kBlackColor,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  Text(
                    'Meet link',
                    style: GoogleFonts.raleway(
                      color: const Color(0xFF504D51),
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  MeetupFormField(
                    hintText: 'https://meet.google.com/dhe-rgoj-riw',
                    controller: meetController,
                    validator: (value) {
                      final RegExp regex = RegExp(
                          r'^(http(s):\/\/.)[-a-zA-Z0-9@:%._\+~#=]{2,256}\.[a-z]{2,6}\b([-a-zA-Z0-9@:%_\+.~#?&//=]*)$');
                      if (value!.isEmpty) {
                        return 'field cannot be empty';
                      } else if (!regex.hasMatch(value)) {
                        return 'enter a valid url';
                      }
                      return null;
                    },
                    onChanged: (val) {
                      setState(() {
                        if (_formKey.currentState!.validate() &&
                            timeFormat != '0:00 AM' &&
                            dateFormat != 'DD/MM/YYYY') {
                          form2Completed = true;
                        } else {
                          form2Completed = false;
                        }
                      });
                    },
                  ),
                  const SizedBox(
                    height: 72,
                  ),
                  CustomButton(
                    height: 54,
                    pressed: () {
                      Future<void> launchUrlParsed() async {
                        if (!await launchUrl(Uri.parse(meetController.text))) {
                          throw Exception(
                            'Could not launch ${Uri.parse(meetController.text)}',
                          );
                        }
                      }

                      if (_formKey.currentState!.validate() &&
                          timeFormat != '0:00 AM' &&
                          dateFormat != 'DD/MM/YYYY') {
                        schedules.add(ScheduleStructure(
                          title: titleController.text,
                          scheduleTime: timeFormat,
                          scheduleDate: dateFormat,
                          onTap: () {
                            launchUrlParsed();
                          },
                          onTap1: () {
                            schedules.removeWhere(
                                (item) => item.title == titleController.text);
                            setState(() {});
                          },
                        ));
                        popUp(context);
                      }
                    },
                    color: form1Completed == true && form2Completed == true
                        ? AppTheme.kPurpleColor
                        : const Color(0xFFCBADCD),
                    width: double.infinity,
                    borderRadius: BorderRadius.circular(8),
                    elevation: 0,
                    child: Text(
                      'Send',
                      style: GoogleFonts.raleway(
                        color: const Color(0xFFF2EBF3),
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: const CustomNavBar(),
      ),
    );
  }
}

Future<bool?> goToMentorHomePage(context) async {
  context.go(MentorPageSkeleton.route);
  return null;
}

Future<dynamic> popUp(BuildContext demoContext) {
  return showDialog(
    context: demoContext,
    builder: (context) {
      return AlertDialog(
        content: Text(
          'Your Meetup has been \nsuccessfully scheduled.',
          textAlign: TextAlign.center,
          style: GoogleFonts.raleway(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF504D51),
          ),
        ),
        actions: [
          CustomButton(
            height: 54,
            pressed: () {
              context.push(MeetUpScreen.route);
            },
            color: AppTheme.kPurpleColor,
            width: 307,
            elevation: 0,
            borderRadius: BorderRadius.circular(8),
            child: Text(
              'Ok!',
              style: GoogleFonts.raleway(
                color: AppTheme.kAppWhiteScheme,
              ),
            ),
          )
        ],
      );
    },
  );
}
