import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:raftlabs_newsfeed/features%20/authentication/notifiers/authstate_notifier.dart';

import '../components/sign_in_button.dart';

const String logoSvg = 'assets/images/raft_logo.png';

class OnboardingPage extends ConsumerWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.only(right: 10),
            height: 60,
            width: 240,
            child: Image.asset(logoSvg),
          ),
          const SizedBox(
            height: 80,
          ),
          Container(
            alignment: Alignment.center,
            child: Column(
              children: [
                const SizedBox(
                  width: 328,
                  child: Text(
                    "Sign in effortlessly using your Google account.\nNo extra passwords needed.",
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(
                  height: 16.0,
                ),
                SignInButton(
                  onTap: () {
                    ref.read(authStateProvider.notifier).loginWithGoogle();
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
