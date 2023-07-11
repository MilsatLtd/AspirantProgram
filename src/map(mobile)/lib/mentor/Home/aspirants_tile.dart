import 'package:flutter/material.dart';
import 'package:milsat_project_app/extras/components/files.dart';

class AspirantsTile extends StatelessWidget {
  const AspirantsTile({
    super.key,
    this.image,
    this.column,
    this.onTap,
    this.border,
  });

  final String? image;
  final Widget? column;
  final Function()? onTap;
  final BoxBorder? border;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 72.h,
        width: double.infinity,
        padding: EdgeInsets.symmetric(
          horizontal: 16.w,
          vertical: 16.h,
        ),
        decoration: BoxDecoration(
          border: border,
        ),
        child: Row(
          children: [
            if (image != null)
              CircleAvatar(
                radius: 20.r,
                backgroundImage: NetworkImage(image!),
              )
            else
              CircleAvatar(
                radius: 20.r,
                backgroundImage: const AssetImage('assets/defaultImage.jpg'),
              ),
            SizedBox(
              width: 16.w,
            ),
            column!,
          ],
        ),
      ),
    );
  }
}
