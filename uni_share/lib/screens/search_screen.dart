import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uni_share/controllers/search_controller.dart'
    as my_search_controller; // Alias the import
import 'package:uni_share/models/user_model.dart' as my_user_model;

class SearchScreen extends StatelessWidget {
  SearchScreen({super.key});

  final my_search_controller.SearchController searchController =
      Get.put(my_search_controller.SearchController());
  @override
  Widget build(BuildContext context) {
    return Obx((){
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red,
          title: TextFormField(
            decoration: const InputDecoration(
                filled: false,
                hintText: 'Search',
                hintStyle: TextStyle(fontSize: 18, color: Colors.white)),
            onFieldSubmitted: (value) => searchController.searchUser(value),
          ),
        ),
        body: Obx(() {
          return searchController.searchedUsers.isEmpty
              ? const Center(
                  child: Text('Search for users!',
                      style: TextStyle(
                        fontSize: 25,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      )),
                )
              : ListView.builder(
                  itemCount: searchController.searchedUsers.length,
                  itemBuilder: (context, index) {
                    my_user_model.User user = searchController.searchedUsers[index];
                    return InkWell(
                        onTap: () {},
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(user.profilePhoto),
                          ),
                          title: Text(user.name,
                              style: const TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                              )),
                        ));
                  },
                );
        }),
      );

    });
  }
}
