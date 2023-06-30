import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          iconTheme: IconThemeData(color: Colors.black, size: 25),
          color: Colors.white,
          titleTextStyle: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      home: const HomeView(),
    );
  }
}

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        child: const Icon(Icons.add),
        onPressed: () => showAddNotesBottomSheet(context),
      ),
      backgroundColor: Colors.white,
      drawer: const SafeArea(child: Drawer()),
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              showFilterColorDialog(context);
            },
            icon: const Icon(Icons.palette_outlined),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.grid_view_outlined),
          ),
        ],
        title: const Text("Mighty notes"),
      ),
    );
  }

  Future<void> showAddNotesBottomSheet(BuildContext context) async {
    await showModalBottomSheet(
      context: context,
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Align(
              alignment: Alignment.center,
              child: Container(
                padding: const EdgeInsets.all(10),
                child: const Text(
                  "New",
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
            const Divider(height: 0),
            ListTile(
              onTap: () async {
                Navigator.push(
                  context,
                  CupertinoPageRoute(
                    builder: (context) => const AddNoteView(),
                  ),
                ).then(
                  (value) => Navigator.pop(context),
                );
              },
              leading: const Icon(CupertinoIcons.pen, color: Colors.black),
              title: const Text("Add note"),
            ),
            const ListTile(
              leading: Icon(Icons.check_box_outlined, color: Colors.black),
              title: Text("Add todo"),
            ),
          ],
        );
      },
    );
  }

  Future<void> showFilterColorDialog(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (context) {
        return const FilterColorDialog();
      },
    );
  }
}

class FilterColorDialog extends StatelessWidget {
  const FilterColorDialog({super.key});

  @override
  Widget build(BuildContext context) {
    List<Color> colorList = [
      const Color(0xffFFFFFF),
      const Color(0xffFF6666),
      const Color(0xff394867),
      const Color(0xff5A96E3),
      const Color(0xffFF8551),
      const Color(0xffE4A5FF),
      const Color(0xffFFD95A),
      const Color(0xff99627A),
      const Color(0xff1B9C85),
      const Color(0xffC8B6A6),
    ];
    return AlertDialog(
      clipBehavior: Clip.hardEdge,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      title: Row(
        children: [
          const Text("Filter by color"),
          const Spacer(),
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.close),
          ),
        ],
      ),
      content: Wrap(
        children: List.generate(10, (index) {
          return Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                height: 50,
                width: (MediaQuery.of(context).size.width),
                child: Card(
                  elevation: 2,
                  shape: const CircleBorder(),
                  color: colorList[index],
                ),
              ),
              const Icon(
                size: 25,
                Icons.check,
                color: Colors.black,
              ),
            ],
          );
        }),
      ),
    );
  }
}

class AddNoteView extends StatelessWidget {
  const AddNoteView({super.key});

  @override
  Widget build(BuildContext context) {
    List<Color> colorList = [
      const Color(0xffFFFFFF),
      const Color(0xffFF6666),
      const Color(0xff394867),
      const Color(0xff5A96E3),
      const Color(0xffFF8551),
      const Color(0xffE4A5FF),
      const Color(0xffFFD95A),
      const Color(0xff99627A),
      const Color(0xff1B9C85),
      const Color(0xffC8B6A6),
    ];
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        title: const Text(
          "Add note",
          style: TextStyle(fontSize: 20),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.check),
          ),
          IconButton(
            onPressed: () {
              showSelectColorBottomSheet(context, colorList);
            },
            icon: const Icon(CupertinoIcons.ellipsis_vertical),
          ),
        ],
      ),
      body: Column(
        children: [
          TextField(
            cursorColor: Colors.black,
            style: Theme.of(context).textTheme.headlineSmall,
            decoration: InputDecoration(
              border: InputBorder.none,
              alignLabelWithHint: true,
              contentPadding: const EdgeInsets.all(15),
              hintText: "Title",
              hintStyle: Theme.of(context).textTheme.headlineSmall,
            ),
          ),
          const TextField(
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: "Write Notes Here",
              contentPadding: EdgeInsets.all(15),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> showSelectColorBottomSheet(BuildContext context, List<Color> colorList) async {
    await showModalBottomSheet(
      context: context,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 15),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const ListTile(
                title: Text("Delete Note"),
                leading: Icon(
                  Icons.delete,
                  color: Colors.black,
                ),
              ),
              const Divider(
                height: 0,
              ),
              const SizedBox(
                height: 15,
              ),
              const Align(
                alignment: Alignment.center,
                child: Text(
                  "Select Color",
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Wrap(
                children: List.generate(colorList.length, (index) {
                  return Stack(
                    alignment: Alignment.center,
                    children: [
                      SizedBox(
                        height: 50,
                        width: 50,
                        child: Card(
                          elevation: 2,
                          shape: const CircleBorder(),
                          color: colorList[index],
                        ),
                      ),
                      const Icon(
                        size: 25,
                        Icons.check,
                        color: Colors.black,
                      ),
                    ],
                  );
                }),
              )
            ],
          ),
        );
      },
    );
  }
}

/*
class SlideRightRoute extends PageRouteBuilder {
  final Widget page;

  SlideRightRoute({required this.page})
      : super(
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              page,
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) =>
              SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(-1, 0),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          ),
        );
}
*/
