import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:raftlabs_newsfeed/features%20/authentication/notifiers/authstate_notifier.dart';
import 'package:raftlabs_newsfeed/features%20/discover/screens/discover_page.dart';
import 'package:raftlabs_newsfeed/features%20/feeds/presentation/screens/feeds_page.dart';
import 'package:raftlabs_newsfeed/features%20/imagepick/screens/post_select.dart';

import 'features /account/presentation/screens/account_page.dart';
import 'features /authentication/presentation/screens/onboarding_page.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.light().copyWith(
        textTheme: GoogleFonts.poppinsTextTheme(),
      ),
      home: Scaffold(
        body: SafeArea(
          child: Consumer(
            builder: (context, ref, child) {
              final isLoggedIn = ref.watch(isLoggedInProvider);
              if (isLoggedIn) {
                return IndexedStack(
                  index: ref.watch(indexProvider),
                  children: [
                    FeedsPage(),
                    DiscoverPage(),
                    AccountPage(),
                  ],
                );
              }
              return const OnboardingPage();
            },
          ),
        ),
        bottomNavigationBar: Consumer(
          builder: (context, ref, child) {
            return BottomNavigationBar(
              selectedItemColor: Color(0xFFFC5101),
              currentIndex: ref.watch(indexProvider),
              iconSize: 24.0,
              selectedLabelStyle: const TextStyle(
                fontSize: 12.0,
              ),
              unselectedLabelStyle: const TextStyle(
                fontSize: 12.0,
              ),
              onTap: (value) {
                ref.read(indexProvider.notifier).update((state) => value);
              },
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.bolt_sharp),
                  label: "Feed",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.explore_sharp),
                  label: "Discover",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.account_circle_outlined),
                  label: "Profile",
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

final indexProvider = StateProvider<int>((ref) {
  return 0;
});
