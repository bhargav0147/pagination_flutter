// ignore_for_file: file_names

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pagination_flutter/Controller/Post_Controller.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({super.key});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  PostController controller = Get.put(PostController());
  ScrollController scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    scrollController.addListener(
      () {
        if (scrollController.position.maxScrollExtent ==
            scrollController.offset) {
          ++controller.page;
          controller.fetchData();
        }
      },
    );
    controller.fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.deepPurple,
              automaticallyImplyLeading: false,
              centerTitle: true,
              title: const Text(
                'Pagination',
                style: TextStyle(
                    letterSpacing: 2,
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                    color: Colors.white),
              ),
            ),
            body: Obx(
              () => controller.postList.isNotEmpty
                  ? ListView.builder(
                      controller:scrollController,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        if (index < controller.postList.length) {
                          return postCard(controller.postList[index], index);
                        } else {
                          return Center(
                              child: controller.haseMoreData
                                  ? const CupertinoActivityIndicator(
                                      color: Colors.deepPurple,
                                      radius: 15,
                                    )
                                  : const Text(
                                      'No More Data',
                                      style: TextStyle(
                                          letterSpacing: 1,
                                          fontSize: 18,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w400),
                                    ));
                        }
                      },
                      itemCount: controller.postList.length + 1,
                    )
                  : const Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Center(
                          child: CupertinoActivityIndicator(
                        color: Colors.deepPurple,
                        radius: 10,
                      )),
                    ),
            )));
  }

  Widget postCard(String text, int index) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: const [
              BoxShadow(
                color:
                    Color.fromRGBO(74, 58, 183, 10), // Grey color with opacity
                spreadRadius: 3,
                blurRadius: 5,
                offset: Offset(0, 0),
              )
            ]),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 30,
                  width: 30,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(2),
                      boxShadow: const [
                        BoxShadow(
                          color: Color.fromRGBO(
                              74, 58, 183, 10), // Grey color with opacity
                          spreadRadius: 1,
                          blurRadius: 2,
                          offset: Offset(0, 0),
                        )
                      ]),
                  child: Center(
                    child: Text(
                      '${index + 1}',
                      style: const TextStyle(
                          letterSpacing: 1,
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Text(
                    text,
                    style: const TextStyle(
                        letterSpacing: 1,
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w400),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
