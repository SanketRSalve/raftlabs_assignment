import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:raftlabs_newsfeed/features%20/authentication/notifiers/authstate_notifier.dart';
import 'package:raftlabs_newsfeed/features%20/imagepick/screens/post_select.dart';

import '../../../constants/constants.dart';
import '../../../feeds/presentation/widgets/post_widget.dart';

final postNumberProvider = StateProvider<int>((ref) {
  return 0;
});

class AccountPage extends ConsumerWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userDetails = ref.watch(authStateProvider.notifier).getUserDetails();
    final userId = ref.watch(userIdProvider);
    return Scaffold(
      body: Column(
        children: [
          Stack(
            alignment: Alignment.topCenter,
            children: [
              Container(
                alignment: Alignment.topRight,
                color: AppConst.kPrimaryColor,
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.1,
                child: IconButton(
                  onPressed: () {
                    ref.read(authStateProvider.notifier).logOut();
                  },
                  icon: const Icon(
                    Icons.logout_sharp,
                    color: Colors.white,
                    size: 28.0,
                  ),
                ),
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
                    CircleAvatar(
                      foregroundImage: NetworkImage(userDetails.photoUrl),
                      radius: 36.0,
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    Text(
                      userDetails.displayName,
                      style: TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.normal),
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
                                ref.watch(postNumberProvider).toString(),
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
                                "1",
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
                                "2",
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
          Expanded(
            child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('posts')
                  .where('uid', isEqualTo: userId)
                  .snapshots(),
              builder: (context,
                  AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    return PostWidget(
                      snap: snapshot.data!.docs[index].data(),
                    );
                  },
                );
              },
            ),
          )
        ],
      ),
      floatingActionButton: Consumer(
        builder: (context, ref, child) {
          return FloatingActionButton(
            backgroundColor: AppConst.kPrimaryColor,
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
