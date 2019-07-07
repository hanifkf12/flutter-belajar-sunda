import 'package:flutter/material.dart';
import 'package:belajar_sunda/word_page.dart';

class MainPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _bottomNavCurrentIndex = 0;
  List<Widget> _container = [WordPage(), WordPage(), WordPage(), WordPage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _container[_bottomNavCurrentIndex],
      bottomNavigationBar: _buildBottomNavigation(),
    );
  }

  Widget _buildBottomNavigation() {
    return BottomNavigationBar(
        onTap: (index) {
          setState(() {
            _bottomNavCurrentIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        currentIndex: _bottomNavCurrentIndex,
        items: [
          BottomNavigationBarItem(
//              activeIcon: Icon(Icons.home, color: Colors.black26,),
              icon: Icon(Icons.home),
              title: Text('Beranda')),
          BottomNavigationBarItem(
//              activeIcon: Icon(Icons.group, color: Colors.black26,),
              icon: Icon(Icons.group),
              title: Text('Forum')),
          BottomNavigationBarItem(
//              activeIcon: Icon(Icons.notifications, color: Colors.black26,),
              icon: Icon(Icons.notifications),
              title: Text('Notifikasi')),
          BottomNavigationBarItem(
//              activeIcon: Icon(Icons.person, color: Colors.black26,),
              icon: Icon(Icons.person),
              title: Text('Profil'))
        ]);
//    return Theme(
//      data: Theme.of(context).copyWith(
//        canvasColor: Colors.blue,
//      ),
//      child: BottomNavigationBar(
//          onTap: (index) {
//            setState(() {
//              _bottomNavCurrentIndex = index;
//            });
//          },
//          type: BottomNavigationBarType.fixed,
//          backgroundColor: Colors.blue,
//          currentIndex: _bottomNavCurrentIndex,
//          items: [
//            BottomNavigationBarItem(
//              activeIcon: Icon(Icons.home, color: Colors.black26,),
//                icon: Icon(Icons.home, color: Colors.white,), title: Text('Beranda')),
//            BottomNavigationBarItem(
//                activeIcon: Icon(Icons.group, color: Colors.black26,),
//                icon: Icon(Icons.group, color: Colors.white), title: Text('Forum')),
//            BottomNavigationBarItem(
//                activeIcon: Icon(Icons.notifications, color: Colors.black26,),
//                icon: Icon(Icons.notifications, color: Colors.white), title: Text('Notifikasi')),
//            BottomNavigationBarItem(
//                activeIcon: Icon(Icons.person, color: Colors.black26,),
//                icon: Icon(Icons.person, color: Colors.white), title: Text('Profil'))
//          ]
//      ),
//    );
  }
}
