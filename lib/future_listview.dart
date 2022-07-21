import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:future_listview/post.dart';
import 'customers.dart';

class FutureListView extends StatefulWidget {
  const FutureListView({Key? key}) : super(key: key);

  @override
  State<FutureListView> createState() => _FutureListViewState();
}

class _FutureListViewState extends State<FutureListView> {
  List<Post> customers = [];

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
          future: getCustomers(),
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

            final images = snapshot.data!;

            if (images.isEmpty) {
              return const Center(
                child: Text('데이터가 0개입니다'),
              );
            }

            return ListView()
          }
      ),
    );
  }
}


Future<List<Post>> getCustomers() async {
  await Future.delayed(const Duration(seconds: 2));

  String jsonString = customers;

  Map<String, dynamic> json = jsonDecode(jsonString);
  List title = json['title'];
  return title.map((e) => Post.fromJson(e)).toList();
}}
