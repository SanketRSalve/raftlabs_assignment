import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:raftlabs_newsfeed/features%20/authentication/notifiers/authstate_notifier.dart';
import 'package:raftlabs_newsfeed/features%20/imagepick/screens/post_select.dart';
import 'package:raftlabs_newsfeed/features%20/user/providers/user_info_provider.dart';

class AccountPage extends ConsumerWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userDetails = ref.watch(authStateProvider.notifier).getUserDetails();
    return Scaffold(
      body: Column(
        children: [
          Stack(
            alignment: Alignment.topCenter,
            children: [
              Container(
                color: Colors.amber,
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.1,
              ),
              Container(
                margin: const EdgeInsets.only(top: 50),
                height: 204.0,
                width: MediaQuery.of(context).size.width * 0.8,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.07),
                      blurRadius: 15,
                      spreadRadius: 0,
                      offset: const Offset(0, 13),
                    ),
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 15,
                      spreadRadius: 0,
                      offset: const Offset(0, 5.43),
                    ),
                    BoxShadow(
                      color: Colors.black.withOpacity(0.04),
                      blurRadius: 15,
                      spreadRadius: 0,
                      offset: const Offset(0, 2.9),
                    ),
                    BoxShadow(
                      color: Colors.black.withOpacity(0.03),
                      blurRadius: 15,
                      spreadRadius: 0,
                      offset: const Offset(0, 1.63),
                    ),
                    BoxShadow(
                      color: Colors.black.withOpacity(0.02),
                      blurRadius: 15,
                      spreadRadius: 0,
                      offset: const Offset(0, 0.86),
                    ),
                    BoxShadow(
                      color: Colors.black.withOpacity(0.01),
                      blurRadius: 15,
                      spreadRadius: 0,
                      offset: const Offset(0, 0.36),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const CircleAvatar(
                      foregroundImage: AssetImage('assets/images/avatar.jpg'),
                      radius: 32.0,
                    ),
                    Text(
                      userDetails.displayName,
                      style: TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.normal),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                          width: 56.0,
                          child: Column(
                            children: [
                              Text(
                                "Posts",
                                style: TextStyle(fontSize: 12.0),
                              ),
                              Text(
                                "18",
                                style: TextStyle(fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 56.0,
                          child: Column(
                            children: [
                              Text(
                                "Followers",
                                style: TextStyle(fontSize: 12.0),
                              ),
                              Text(
                                "259",
                                style: TextStyle(fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 56.0,
                          child: Column(
                            children: [
                              Text(
                                "Following",
                                style: TextStyle(fontSize: 12.0),
                              ),
                              Text(
                                "20",
                                style: TextStyle(fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      floatingActionButton: Consumer(
        builder: (context, ref, child) {
          return FloatingActionButton(
            child: const Icon(Icons.add),
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => AddPostScreen(),
              ),
            ),
          );
        },
      ),
    );
  }
}
