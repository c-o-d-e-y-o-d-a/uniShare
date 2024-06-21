import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uni_share/controllers/search_controller.dart'
    as my_search_controller;
import 'package:uni_share/models/user_model.dart' as my_user_model;
import 'package:uni_share/screens/profile_screen.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({super.key});

  final my_search_controller.SearchController searchController =
      Get.put(my_search_controller.SearchController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow,
        title: TextFormField(
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
          decoration: const InputDecoration(
            prefixIcon: Icon(
              Icons.search,
              color: Colors.black,
            ),
            filled: false,
            hintText: 'Search',
            hintStyle: TextStyle(fontSize: 18, color: Colors.black),
          ),
          onFieldSubmitted: (value) {
            print('Search submitted: $value'); // Debugging statement
            searchController.searchUser(value);
          },
        ),
      ),
      body: Obx(() {
        print(
            'Rebuilding ListView with ${searchController.searchedUsers.length} users'); // Debugging statement
        if (searchController.searchedUsers.isEmpty) {
          return const Center(
            child: Text('Search for users!',
                style: TextStyle(
                  fontSize: 25,
                  color: Colors.yellow,
                  fontWeight: FontWeight.bold,
                )),
          );
        } else {
          return ListView.builder(
            itemCount: searchController.searchedUsers.length,
            itemBuilder: (context, index) {
              my_user_model.User user = searchController.searchedUsers[index];
              return InkWell(
                  onTap: () {
                    Get.to(ProfileScreen(uid: user.uid));
                  },
                  child: Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: ListTile(
                      leading: CircleAvatar(
                        foregroundColor: Colors.grey,
                        backgroundImage: NetworkImage(user.profilePhoto),
                      ),
                      title: Text(user.name,
                          style: const TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                          )),
                      trailing: Padding(
                        padding: EdgeInsets.all(7),
                        child: Icon(
                          Icons.arrow_forward_ios,
                          size: 16,
                        ),
                      ),
                    ),
                  ));
            },
          );
        }
      }),
    );
  }
}
