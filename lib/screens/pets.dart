import 'package:flutter/material.dart';

import '../widgets/side_menu.dart';

class PetsPage extends StatelessWidget {
  PetsPage({super.key});

  Map<String, dynamic> mockedData = {
    "pets": [
      {
        "name": "Sierra",
        "age": "3 years",
        "status": "Well fed",
        "weight": "14.65Kg",
        "image":
            "https://cdn.arstechnica.net/wp-content/uploads/2022/04/GettyImages-997016774.jpg"
      },
      {
        "name": "Astro",
        "age": "3 months",
        "status": "Bad fed",
        "weight": "640g",
        "image":
            "https://www.princeton.edu/sites/default/files/styles/half_2x/public/images/2022/02/KOA_Nassau_2697x1517.jpg?itok=iQEwihUn"
      },
      {
        "name": "Sky",
        "age": "8 years",
        "status": "Well fed",
        "weight": "23.4Kg",
        "image":
            "https://cdn.britannica.com/49/161649-050-3F458ECF/Bernese-mountain-dog-grass.jpg"
      }
    ]
  };

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: const Text(
          'Your Pets',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.menu,
            color: Colors.blue,
          ),
          onPressed: () {
            _scaffoldKey.currentState?.openDrawer();
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.add,
              color: Colors.blue,
            ),
            onPressed: () {
              // TODO: Add pet
            },
          ),
        ],
        backgroundColor: Colors.transparent,
        centerTitle: true,
        elevation: 0,
      ),
      drawer: SideMenu(
        currentPath: "/pets",
      ),
      body: Column(
        children: [
          GridView.builder(
            padding: EdgeInsets.all(16.0),
            physics: ScrollPhysics(),
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16.0,
              mainAxisSpacing: 16.0,
            ),
            itemCount: mockedData["pets"].length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                width: MediaQuery.of(context).size.width * 0.4,
                height: MediaQuery.of(context).size.height * 0.2,
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushNamed(
                          "/pet-settings",
                          arguments: {
                            "name": mockedData["pets"][index]["name"],
                            "age": mockedData["pets"][index]["age"],
                            "status": mockedData["pets"][index]["status"],
                            "weight": mockedData["pets"][index]["weight"],
                            "image": mockedData["pets"][index]["image"],
                          },
                        );
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.4,
                        height: MediaQuery.of(context).size.height * 0.2,
                        child: ClipOval(
                          child: Image.network(
                            mockedData["pets"][index]["image"],
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    Text(mockedData["pets"][index]["name"]),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
