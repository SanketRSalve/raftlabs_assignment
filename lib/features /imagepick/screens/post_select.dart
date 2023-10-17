import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:raftlabs_newsfeed/features%20/authentication/notifiers/authstate_notifier.dart';
import 'package:raftlabs_newsfeed/features%20/imagepick/widgets/utils/image_pick.dart';
import 'package:raftlabs_newsfeed/features%20/posts/repositories/firestore_methods.dart';

class AddPostScreen extends ConsumerStatefulWidget {
  const AddPostScreen({super.key});

  @override
  ConsumerState<AddPostScreen> createState() => _AddPostScreenState();
}

final imageFileProvider = StateProvider<Uint8List?>((ref) {
  return null;
});

final TextEditingController textEditingController = TextEditingController();

class _AddPostScreenState extends ConsumerState<AddPostScreen> {
  _selectImage(BuildContext parentContext) async {
    return showDialog(
        context: parentContext,
        builder: (context) {
          return SimpleDialog(
            children: [
              SimpleDialogOption(
                padding: const EdgeInsets.all(20),
                onPressed: () async {
                  Navigator.pop(context);
                  Uint8List file = await pickImage(ImageSource.gallery);
                  ref.read(imageFileProvider.notifier).update((state) => file);
                },
                child: const Text("Choose From Gallery"),
              )
            ],
          );
        });
  }

//Post to firebase storage
  void postImage(String uid, String username, String userImg) async {
    try {
      await FirestoreMethods().uploadPost(ref.watch(imageFileProvider),
          textEditingController.text, uid, username, userImg);
    } catch (e) {
      throw e;
    }
  }

  @override
  void dispose() {
    super.dispose();
    textEditingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var image = ref.watch(imageFileProvider);
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            image == null
                ? ElevatedButton(
                    onPressed: () => _selectImage(context),
                    child: const Text("Choose an Image"),
                  )
                : Image(
                    image: MemoryImage(image),
                  ),
            const Text("OR"),
            TextField(
              controller: textEditingController,
            ),
            ElevatedButton(
              onPressed: () {
                final userDetails =
                    ref.watch(authStateProvider.notifier).getUserDetails();
                postImage(userDetails.userId, userDetails.displayName,
                    userDetails.photoUrl);
                Navigator.pop(context);
              },
              child: const Text("Post"),
            ),
          ],
        ),
      ),
    );
  }
}
