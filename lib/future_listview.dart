import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:future_listview/post.dart';

import 'post_data.dart';

class FutureListView extends StatelessWidget {
  const FutureListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        title: const Text(
          'Future Listview',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: FutureBuilder<List<Post>>(
        future: getPosts(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text('에러가 발생했습니다'),
            );
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (!snapshot.hasData) {
            return const Center(
              child: Text('데이터가 없습니다'),
            );
          }

          final postData = snapshot.data!;

          if (postData.isEmpty) {
            return const Center(
              child: Text('데이터가 0개입니다'),
            );
          }

          return ListView.builder(
            itemCount: postData.length,
            itemBuilder: (context, int index) {
              Post item = postData[index];
              return ListTile(
                title: Text(item.title),
              );
            },
          );
        },
      ),
    );
  }

  Future<List<Post>> getPosts() async {
    await Future.delayed(const Duration(seconds: 2));

    String jsonString = postData;

    Map<String, dynamic> json = jsonDecode(jsonString);
    List title = json['title'];
    return title.map((e) => Post.fromJson(e)).toList();
  }
}
