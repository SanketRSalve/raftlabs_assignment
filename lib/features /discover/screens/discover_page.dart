import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';

import '../../constants/constants.dart';

class DiscoverPage extends StatefulWidget {
  const DiscoverPage({super.key});

  @override
  State<DiscoverPage> createState() => _DiscoverPageState();
}

class _DiscoverPageState extends State<DiscoverPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('users').snapshots(),
          builder: (context,
              AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return ListView.separated(
              itemCount: snapshot.data!.docs.length,
              separatorBuilder: (context, index) => Divider(
                color: Colors.grey[300],
              ),
              itemBuilder: (context, index) {
                return UserTile(
                  snap: snapshot.data!.docs[index].data(),
                );
              },
            );
          },
        ),
      ),
    );
  }
}

class UserTile extends StatelessWidget {
  final snap;
  const UserTile({
    super.key,
    required this.snap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        radius: 24,
        backgroundImage: NetworkImage(snap['photo_url']),
      ),
      title: Text(
        snap['display_name'],
        style: TextStyle(fontSize: 20.0),
      ),
      trailing: ElevatedButton(
        onPressed: () {},
        child: Text("Follow"),
        style: ElevatedButton.styleFrom(
          backgroundColor: AppConst.kPrimaryColor,
        ),
      ),
    );
  }
}
