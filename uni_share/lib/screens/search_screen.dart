import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uni_share/controllers/search_controller.dart';
class SearchScreen extends StatelessWidget {
  SearchScreen({super.key});

  final SearchController searchController = Get.put(SearchController());

  @override
  Widget build(BuildContext context) {
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
                  final user = searchController.searchedUsers[index];
                  return ListTile(
                    title: Text(user.name),
                    subtitle: Text(user.email),
                    // Add other user fields here
                  );
                },
              );
      }),
    );
  }
}
