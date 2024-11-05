import 'package:flutter/material.dart';

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
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 72,
        width: double.infinity,
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
        decoration: BoxDecoration(
          border: border,
        ),
        child: Row(
          children: [
            if (image != null)
              CircleAvatar(
                radius: 20,
                backgroundColor: Colors.grey,
                backgroundImage: NetworkImage(image!),
              )
            else
              const CircleAvatar(
                radius: 20,
                backgroundColor: Colors.grey,
                backgroundImage: AssetImage('assets/placeholder-person.png'),
              ),
            const SizedBox(
              width: 16,
            ),
            column!,
          ],
        ),
      ),
    );
  }
}
