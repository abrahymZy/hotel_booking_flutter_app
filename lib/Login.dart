import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  List<Map<String, String>> users = [
    {'name': 'yousef', 'password': 'y789'},
    {'name': 'waheeb', 'password': 'w123'},
    {'name': 'khaleel', 'password': 'k567'},
  ];
  String info = '';
  final txt1 = TextEditingController();
  final txt2 = TextEditingController();
  void f1() {
    if (txt1.text.isEmpty || txt2.text.isEmpty)
      info = 'input data';
    else {
      bool state = false;
      for (int i = 0; i < users.length; i++) {
        if (users[i]['name'] == txt1.text &&
            users[i]['password'] == txt2.text) {
          state = true;
          break;
        }
      }
      if (state == true) {
        info = 'Welcom:${txt1.text}';
        Navigator.pushNamed(context, 'Home');
      } else
        info = 'User not found';
    }

    setState(() {});
  }

  void f2() {
    txt1.clear();
    txt2.clear();
    info = '';
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      drawer: Drawer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [Icon(Icons.telegram), Icon(Icons.abc), Icon(Icons.phone)],
        ),
      ),
      body: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(30),
        // color: Colors.grey,
        child: Column(
          children: [
            SizedBox(height: 50),
            Image.asset(
              'images/User2.png',
              width: 100,
              height: 100,
              // color: Colors.deepPurple,
            ),
            SizedBox(height: 10),
            TextField(
              controller: txt1,
              style: TextStyle(fontSize: 18, color: Colors.blueAccent),
              decoration: InputDecoration(
                labelText: 'Full Name',
                hintText: 'User Name',
                prefixIcon: Icon(Icons.person, color: Colors.blueAccent),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),

            SizedBox(height: 10),
            TextField(
              controller: txt2,
              style: TextStyle(fontSize: 18, color: Colors.blueAccent),
              decoration: InputDecoration(
                labelText: 'Password',
                hintText: 'Password',
                prefixIcon: Icon(Icons.lock, color: Colors.blueAccent),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              obscureText: true,
            ),

            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MaterialButton(
                  onPressed: f1,
                  padding: EdgeInsets.all(15),
                  color: Colors.blueAccent,
                  child: Text(
                    'Login',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                  shape: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                    borderSide: BorderSide.none,
                  ),
                ),
                SizedBox(width: 10),
                MaterialButton(
                  onPressed: f2,
                  padding: EdgeInsets.all(15),
                  color: Colors.blueAccent,
                  child: Text(
                    'Clear',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                  shape: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                    borderSide: BorderSide.none,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Text(
              '${info}',
              style: TextStyle(fontSize: 18, color: Colors.blueAccent),
            ),
          ],
        ),
      ),
    );
  }
}
