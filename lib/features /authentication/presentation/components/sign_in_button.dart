import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SignInButton extends StatelessWidget {
  final VoidCallback? onTap;
  const SignInButton({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 56,
        width: 328,
        decoration: BoxDecoration(
          color: const Color(0xFFF0F0F0),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 24.0,
              width: 24.0,
              child: SvgPicture.asset('assets/images/google.svg'),
            ),
            const SizedBox(
              width: 12.0,
            ),
            const Text("Continue with Google"),
          ],
        ),
      ),
    );
  }
}
