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
        title: const Text('Future Listview'),
      ),
      body: FutureBuilder<List<Post>>(
        future: fetch(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text('에러가 발생했습니다'),
              //에러가 발생하면 어떻게 해결해야 하나?
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

          final recentData = snapshot.data!;
          //이 snapshot 데이터는 뭐지?
          // getPosts()함수의 리턴값인 posts가 리스트화 된건가?

          if (recentData.isEmpty) {
            return const Center(
              child: Text('데이터가 0개입니다'),
            );
          }

          return ListView.builder(
            itemCount: recentData.length,
            itemBuilder: (context, index) {
              Post item = recentData[index];
              //여기에 index는 1,2,3, 등의 숫자인가?
              //굳이 item을 선언해서 담아줘야 하나?
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  child: ListTile(
                    leading: const Icon(Icons.wb_incandescent_outlined),
                    title: Text(item.title),
                    subtitle: Text(item.body),
                    trailing: const Icon(Icons.menu),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Future<List<Post>> fetch() async {
    await Future.delayed(const Duration(seconds: 2));

    String jsonString = postData;

    Map<String, dynamic> json = jsonDecode(jsonString);
    Iterable posts = json['posts'];
    //데이터에 posts의 한 단계를 두지 않고 있는 그대로 가져올 방법은 없나?
    return posts.map((e) => Post.fromJson(e)).toList();
  }
}
