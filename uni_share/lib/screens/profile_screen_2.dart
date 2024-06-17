import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'dart:math' as math;

import 'package:uni_share/components/profile_background.dart';
import 'package:uni_share/components/stat.dart';
import 'package:uni_share/controllers/auth_controller.dart';
import 'package:uni_share/controllers/profile_controller.dart';

class ProfileScreen2 extends StatefulWidget {
  final String uid;

  const ProfileScreen2({Key? key, required this.uid}) : super(key: key);

  @override
  State<ProfileScreen2> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen2> {
  final ProfileController profileController = Get.put(ProfileController());
  final AuthController authController = Get.find();

  @override
  void initState() {
    super.initState();
    profileController.updateUserId(widget.uid);
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
      init: ProfileController(),
      builder: (controller) {
        if (controller.user.isEmpty) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return ProfileBackground(
          child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              automaticallyImplyLeading: false,
              centerTitle: true,
              title: const Text('Profile'),
              leading: Padding(
                padding: const EdgeInsets.all(8),
                child: InkWell(
                  onTap: () => Get.back(),
                  child: const Icon(Icons.arrow_back),
                ),
              ),
            ),
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Transform.rotate(
                        angle: math.pi / 4,
                        child: Container(
                          width: 140.0,
                          height: 140.0,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            border: Border.all(width: 1.0, color: Colors.black),
                            borderRadius: BorderRadius.circular(35.0),
                          ),
                        ),
                      ),
                      ClipPath(
                        clipper: ProfileImageClipper(),
                        child: Image.network(
                          controller.user['profilePhoto'],
                          width: 180.0,
                          height: 180.0,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    controller.user['name'],
                    style: Theme.of(context).textTheme.displaySmall!.copyWith(
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                        ),
                  ),
                  const SizedBox(height: 4.0),
                  Text(
                    '@${controller.user['username']}',
                    style: const TextStyle(color: Colors.black),
                  ),
                  const SizedBox(height: 80.0),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 50.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Stat(title: 'Posts', value: controller.user['posts']),
                        Stat(
                            title: 'Followers',
                            value: controller.user['followers']),
                        Stat(
                            title: 'Follows',
                            value: controller.user['following']),
                      ],
                    ),
                  ),
                  const SizedBox(height: 50.0),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: controller.user['thumbnails'].length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 1,
                      crossAxisSpacing: 5,
                      mainAxisSpacing: 5,
                    ),
                    itemBuilder: (context, index) {
                      String thumbnail = controller.user['thumbnails'][index];
                      return CachedNetworkImage(
                        imageUrl: thumbnail,
                        fit: BoxFit.cover,
                        placeholder: (context, url) =>
                            const CircularProgressIndicator(),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class ProfileImageClipper extends CustomClipper<Path> {
  double radius = 35;

  @override
  Path getClip(Size size) {
    Path path = Path()
      ..moveTo(size.width / 2 - radius, radius)
      ..quadraticBezierTo(size.width / 2, 0, size.width / 2 + radius, radius)
      ..lineTo(size.width - radius, size.height / 2 - radius)
      ..quadraticBezierTo(size.width, size.height / 2, size.width - radius,
          size.height / 2 + radius)
      ..lineTo(size.width / 2 + radius, size.height - radius)
      ..quadraticBezierTo(size.width / 2, size.height, size.width / 2 - radius,
          size.height - radius)
      ..lineTo(radius, size.height / 2 + radius)
      ..quadraticBezierTo(0, size.height / 2, radius, size.height / 2 - radius)
      ..close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
