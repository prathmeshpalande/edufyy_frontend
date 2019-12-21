import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Subjects"),
      ),
        body: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomeState();
  }
}

class HomeState extends State<HomeScreen> {
  getListOf(String label, int count) {
    int i = 0;
    List<String> list = new List(count);
    while(i < count) {
      list[i] = label + (i+1).toString();
      i++;
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    List<String> subjects = getListOf("Subject ", 25);
    return ListView.builder(
      itemCount: subjects.length,
      itemBuilder: (context, index) => Card(
        margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Container(
            padding: EdgeInsets.all(16.0),
            child: Text(subjects[index],
              style: TextStyle(
                  fontFamily: "monospace",
                  fontSize: 18.0,
                  color: Colors.black
              ),
            )
        ),
      )
    );
  }
}


