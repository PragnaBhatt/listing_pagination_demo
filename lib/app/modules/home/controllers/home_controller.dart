import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:listing_pagination_demo/app/modules/home/models/comment_model.dart';
import 'package:listing_pagination_demo/app/modules/home/models/post_model.dart';

class HomeController extends GetxController {
  //TODO: Implement HomeController

  final count = 0.obs;

  // RxList<PostModel> postList = RxList();

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;

  Future<List<PostModel>> getData(int pageKey, int pageSize) async {
    print("pg key....$pageKey");

    String url =
        "https://jsonplaceholder.typicode.com/posts?_page=$pageKey&_limit=$pageSize";
print("url $url");
    var response = await http.get(Uri.parse(url));

    var data = (json.decode(response.body) as List)
        .map((e) => PostModel.fromJson(e))
        .toList();

    // print(data.length);
    // postList.value.addAll(data);
    return data;
  }

  //get comment from post
  Future<List<CommentModel>> getComments(String postId) async {
    String url = "https://jsonplaceholder.typicode.com/comments?postId=$postId";
    var response = await http.get(Uri.parse(url));
    return (json.decode(response.body) as List)
        .map((e) => CommentModel.fromJson(e))
        .toList();
  }
}
