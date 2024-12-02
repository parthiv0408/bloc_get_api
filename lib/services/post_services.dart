import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:interview_test/model/post_model.dart';


class PostService {
  final String apiUrl = "https://jsonplaceholder.typicode.com/posts";

  Future<List<PostModel>> fetchPosts() async {
    final response = await http.get(Uri.parse(apiUrl));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => PostModel.fromJson(json)).toList();
    } else {
      throw Exception("Failed to load posts");
    }
  }

  Future<PostModel> fetchPostDetail(int postId) async {
    final response = await http.get(Uri.parse('$apiUrl/$postId'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return PostModel.fromJson(data);
    } else {
      throw Exception("Failed to load post detail");
    }
  }
}
