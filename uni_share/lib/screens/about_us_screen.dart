import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:readmore/readmore.dart';

class AboutUsScreen extends StatelessWidget {
  AboutUsScreen({super.key});

  final List<Widget> iconList = [Icon(Icons.video_call)];

  @override
  Widget build(BuildContext context) {
    final String content =
        'Uni-Share is an innovative video-sharing app designed specifically for college students, providing a unique platform for them to document and share their daily lives and struggles. This app enables students to post videos that capture their experiences, from the highs of campus life to the challenges they face, fostering a sense of community and solidarity. Uni-Share is more than just a social media tool; it is a vibrant space where students can connect, empathize, and support each other through the shared journey of higher education. With its user-friendly interface and engaging features, Uni-Share empowers students to express themselves creatively and authentically, making every story heard and every moment shared.';
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Container(
          height: 1000,
          child: Padding(
            padding: const EdgeInsets.all(14.0),
            child: Column(
              children: [
                Container(
                  alignment: Alignment.topLeft,
                  child: InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: ListTile(
                          leading: Icon(Icons.arrow_back),
                        )),
                  ),
                ),
                Container(
                  child: Image.asset('assets/logo.png'),
                  width: 300,
                  height: 300,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(16)),
                      color: Colors.yellow),
                ),
                Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: Text(
                    'Abous Us',
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                ),

                Row(
                  children: [
                    Icon(
                      Icons.star,
                      color: Colors.yellow[900],
                    ),
                    Text(
                      '4.8/5 (2k reviews)',
                      style: TextStyle(color: Colors.white),
                    )
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                ReadMoreText(
                  content,
                  preDataTextStyle: TextStyle(color: Colors.black),
                  trimLines: 3,
                  textAlign: TextAlign.justify,
                  trimMode: TrimMode.Line,
                  trimCollapsedText: " Show More ",
                  trimExpandedText: ' Show Less ',
                  lessStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.green[700],
                  ),
                  moreStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.yellow,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  'Features',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
                // Ensure the ListView has a constrained height
                Expanded(
                  child: ListView.builder(
                    itemCount: iconList.length,
                    itemBuilder: (context, index) {
                      return Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          border: Border.all(width: 2, color: Colors.white),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: iconList[index],
                        ),
                      );
                    },
                  ),
                ),

                InkWell(
                  onTap: () {},
                  child: Container(
                    child: Center(
                      child: Text('sodijf'),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
