import 'package:flutter/material.dart';
import 'package:uni_share/components/custom_icon.dart';
import 'package:uni_share/components/sideMenu.dart';
import 'package:uni_share/constants.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int pageIndx = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   leading:InkWell(
      //     onTap: (){firebaseAuth.signOut();},
      //     child:  Icon(
      //       Icons.logout,
      //     ),),
      // ),
      drawer: MySideMenu(),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (indx){
          setState(() {
            pageIndx = indx;
          }); 
        },
        type: BottomNavigationBarType.fixed,
        backgroundColor: backgroundColor,
        selectedItemColor: Colors.yellow,
        unselectedItemColor: Colors.white,
        currentIndex: pageIndx,

        items: const [
          BottomNavigationBarItem(
            
            icon: Icon(Icons.home,
                size: 30), // Correctly wrap the icon in an Icon widget
            label:"Home"
               
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search,size: 30), 
            label: "Search",
          ),

           BottomNavigationBarItem(
            icon:CustomIcon(),
            label: "",
          ),

           BottomNavigationBarItem(
            icon: Icon(Icons.message, size: 30),
            label: "Message",
          ),

           BottomNavigationBarItem(
            icon: Icon(Icons.person, size: 30),
            label: "Profile",
          ),
        ],
      ),
      body: pages[pageIndx] ,
    );
  }
}
