import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone_flutter/features/posts/widgets/post_like_tile.dart';
import 'package:instagram_clone_flutter/repos/auth_repo.dart';

import '../../../constants/constants.dart';

class LikesScreen extends StatelessWidget {
  static const routeName = '/likes-screen';

  const LikesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> likes = [];
    dynamic routeData = ModalRoute.of(context)?.settings.arguments;
    if (routeData != null) {
      likes = routeData as List<String>;
    }
    return Scaffold(
      backgroundColor: MyColors.primaryColor,
      appBar: AppBar(
        backgroundColor: MyColors.primaryColor,
        iconTheme: IconThemeData(color: MyColors.secondaryColor),
        title: Text(
          'Likes',
          style: MyFonts.firaSans(
            fontColor: MyColors.secondaryColor,
          ),
        ),
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('users').snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(
                  backgroundColor: MyColors.buttonColor1,
                ),
              );
            }

            final likeDocs = snapshot.data!.docs;
            final userLikesData = likeDocs.where((user) {
              return likes.contains(user.id);
            }).toList();

            userLikesData.sort((a, b) {
              if (a.id == AuthRepo.currentUser!.uid) {
                return -1;
              } else if (b.id == AuthRepo.currentUser!.uid) {
                return 1;
              } else {
                return a.id.compareTo(b.id);
              }
            });

            if (likes.isEmpty) {
              return Center(
                child: Text(
                  'No Likes!',
                  style: MyFonts.firaSans(
                    fontColor: MyColors.secondaryColor,
                  ),
                ),
              );
            } else {
              return ListView.builder(
                itemCount: userLikesData.length,
                itemBuilder: (context, index) {
                  bool isYou =
                      userLikesData[index].id == AuthRepo.currentUser!.uid;
                  final userName =
                      isYou ? 'You' : userLikesData[index]['username'];
                  final imageUrl = userLikesData[index]['userImageUrl'];
                  return PostLikeTile(
                    userImageUrl: imageUrl,
                    userName: userName,
                    isYou: isYou,
                  );
                },
              );
            }
          }),
    );
  }
}