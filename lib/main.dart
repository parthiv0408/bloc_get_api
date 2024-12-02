import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:interview_test/block/post_block.dart';
import 'package:interview_test/block/post_event.dart';
import 'package:interview_test/screens/post_list_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Post List App',
      home: BlocProvider(
        create: (context) => PostBloc()..add(FetchPostsEvent()),
        child: PostListScreen(),
      ),
    );
  }
}
