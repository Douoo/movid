import 'package:flutter/material.dart';
import 'package:movid/core/styles/colors.dart';

class DrawerScreen extends StatefulWidget {
  const DrawerScreen({super.key});

  @override
  State<DrawerScreen> createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xff14141c),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 35,
                  backgroundColor: Colors.blueGrey,
                ),
                SizedBox(
                  width: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Movid",
                        style: TextStyle(
                          color: Colors.white,
                        )),
                    Text("user@gmail.com",
                        style: TextStyle(
                          color: Colors.white,
                        )),
                  ],
                )
              ],
            ),
            SizedBox(
              height: 20,
            ),
            MenuItem(
              name: "Movies",
              iconData: Icons.movie,
              isSelected: true,
            ),
            MenuItem(
              name: "Tv Series",
              iconData: Icons.tv,
              isSelected: false,
            ),
            MenuItem(
              name: "WatchList",
              iconData: Icons.watch_later,
              isSelected: false,
            ),
            MenuItem(
              name: "About",
              iconData: Icons.notifications,
              isSelected: false,
            ),
          ],
        ),
      ),
    );
  }
}

class MenuItem extends StatelessWidget {
  final String? name;
  final IconData? iconData;
  final Function()? onTap;
  final bool? isSelected;
  const MenuItem(
      {this.isSelected, this.name, this.iconData = Icons.home, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 50,
      ),
      child: Container(
        height: 55,
        decoration: BoxDecoration(
          color: isSelected! ? Color(0xfffc4f03) : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Icon(
                iconData,
                color: Colors.white,
              ),
              SizedBox(width: 10),
              Expanded(
                  child: Text(
                name!,
                style: TextStyle(color: Colors.white),
              )),
            ],
          ),
        ),
      ),
    );
  }
}
