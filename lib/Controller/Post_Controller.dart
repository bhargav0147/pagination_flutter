import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:get/get.dart';

class PostController extends GetxController {
  RxList postList = [].obs;
  RxInt page = 1.obs;
  bool haseMoreData = true;
  

  Future<void> fetchData() async {
    int limit = 10;
    final url = Uri.parse(
        'https://jsonplaceholder.typicode.com/posts?_page=$page&_limit=$limit');
    final response = await http.get(url);
    
    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);
      if (data.length < limit) {
        haseMoreData = false;
      }
      postList.addAll(data.map((e) => e['body']));
    
    }
  }
}
