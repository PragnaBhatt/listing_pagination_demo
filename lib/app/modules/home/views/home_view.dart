import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../controllers/home_controller.dart';
import 'dart:math' as math show Random;

import '../models/post_model.dart';

class HomeView extends StatefulWidget {
  HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  static const _pageSize = 20;
  HomeController homeController = Get.find<HomeController>();

  final PagingController<int, PostModel> _paginationController =
      PagingController(firstPageKey: 0);

  @override
  void dispose() {
    _paginationController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _paginationController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    super.initState();
  }

  _fetchPage(int pageKey) {
    homeController.getData(pageKey, _pageSize).then((value) {
      final isLast = value.length < _pageSize;
      try {
        if (isLast) {
          _paginationController.appendLastPage(value);
        } else {
          // final nextPageKey = pageKey + value.length;
          final nextPageKey = pageKey + 1;
          _paginationController.appendPage(value, nextPageKey);
        }
      } on Exception catch (e) {
        _paginationController.error = e;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          AppBar(title: const Text("Demo for List Pagination"), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: PagedListView(
            pagingController: _paginationController,
            builderDelegate: PagedChildBuilderDelegate<PostModel>(
                itemBuilder: (ctx, item, index) {
              final color =
                  Color((math.Random().nextDouble() * 0xFFFFFF).toInt())
                      .withOpacity(0.9);
              return Card(
                  elevation: 2,
                  child: ListTile(
                    leading: CircleAvatar(
                        backgroundColor: color,
                        radius: 40,
                        child: Text((index + 1).toString())),
                    title: Text(item.title!),
                    subtitle: Text(item.body!),
                  ));
            })),
      ),
    );
  }
}
