import 'package:flutter/material.dart';
import 'package:milsat_project_app/extras/components/files.dart';

class InternSlip extends StatelessWidget {
  const InternSlip({super.key, required this.count, required this.d});

  final int count;
  final MentorData d;

  @override
  Widget build(BuildContext context) {
    double imageDiameter = 24;
    double radiusDivisor = 2;
    double divisor = 2.5;
    return SizedBox(
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          d.mentees!.elementAt(0).profilePicture != null
              ? CircleAvatar(
                  radius: (imageDiameter / 2),
                  backgroundImage: NetworkImage(
                    d.mentees!.elementAt(0).profilePicture!,
                  ),
                )
              : CircleAvatar(
                  radius: (imageDiameter / 2),
                  backgroundImage: const AssetImage(
                    'assets/defaultImage.jpg',
                  ),
                ),
          if (count > 1)
            Positioned(
              right: -(imageDiameter / divisor),
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  d.mentees!.elementAt(1).profilePicture != null
                      ? CircleAvatar(
                          radius: (imageDiameter / 2),
                          backgroundImage: NetworkImage(
                            d.mentees!.elementAt(1).profilePicture!,
                          ),
                        )
                      : CircleAvatar(
                          radius: (imageDiameter / 2),
                          backgroundImage: const AssetImage(
                            'assets/defaultImage.jpg',
                          ),
                        ),
                  if (count > 2)
                    Positioned(
                      right: -(imageDiameter / divisor),
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          d.mentees!.elementAt(2).profilePicture != null
                              ? CircleAvatar(
                                  radius: (imageDiameter / radiusDivisor),
                                  backgroundImage: NetworkImage(
                                    d.mentees!.elementAt(2).profilePicture!,
                                  ),
                                )
                              : CircleAvatar(
                                  radius: (imageDiameter / radiusDivisor),
                                  backgroundImage: const AssetImage(
                                    'assets/defaultImage.jpg',
                                  ),
                                ),
                          if (count > 3)
                            Positioned(
                              right: -(imageDiameter / divisor),
                              child: Stack(
                                clipBehavior: Clip.none,
                                children: [
                                  d.mentees!.elementAt(3).profilePicture != null
                                      ? CircleAvatar(
                                          radius: (imageDiameter / 2),
                                          backgroundImage: NetworkImage(
                                            d.mentees!
                                                .elementAt(3)
                                                .profilePicture!,
                                          ),
                                        )
                                      : CircleAvatar(
                                          radius: (imageDiameter / 2),
                                          backgroundImage: const AssetImage(
                                            'assets/defaultImage.jpg',
                                          ),
                                        ),
                                  if (count > 4)
                                    Positioned(
                                      right: -(imageDiameter / divisor),
                                      child: d.mentees!
                                                  .elementAt(4)
                                                  .profilePicture !=
                                              null
                                          ? CircleAvatar(
                                              radius: (imageDiameter / 2),
                                              backgroundImage: NetworkImage(
                                                d.mentees!
                                                    .elementAt(4)
                                                    .profilePicture!,
                                              ),
                                            )
                                          : CircleAvatar(
                                              radius: (imageDiameter / 2),
                                              backgroundImage: const AssetImage(
                                                'assets/defaultImage.jpg',
                                              ),
                                            ),
                                    ),
                                ],
                              ),
                            )
                        ],
                      ),
                    )
                ],
              ),
            ),
        ],
      ),
    );
  }
}
