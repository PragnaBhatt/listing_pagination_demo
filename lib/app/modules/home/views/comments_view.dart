import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:listing_pagination_demo/app/modules/home/controllers/home_controller.dart';

class CommentsView extends GetView<HomeController> {
  CommentsView();

  @override
  Widget build(BuildContext context) {
    final id = Get.arguments["id"];
    print("ID :: $id");
    //  controller.getComments(id.toString());
    return Scaffold(
      appBar: AppBar(
        title: const Text('CommentsView'),
        centerTitle: true,
      ),
      body: Center(
        child: FutureBuilder(
            future: controller.getComments(id.toString()),
            builder: (context, snapShot) {
              if (snapShot.hasError) return Text(snapShot.error.toString());
              if (snapShot.connectionState == ConnectionState.waiting)
                return CircularProgressIndicator();
              if (snapShot.data!.isEmpty)
                return Text("No comments!");
              else
                return ListView.builder(
                    itemCount: snapShot.data!.length,

                    itemBuilder: (ctx, index) {
                  return Card(
                    elevation: 2,
                    child: ListTile(


                      title: Text(snapShot.data![index].name!),
                      subtitle: Text(snapShot.data![index].body!),


                    ),
                  );
                });
            }),
      ),
    );
  }
}
