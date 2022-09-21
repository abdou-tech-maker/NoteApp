import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController bacidController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController familynameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  bool hidePassword;
  void hideMyPass() {
    if (hidePassword) {
      setState(() {
        hidePassword = false;
      });
    } else {
      setState(() {
        hidePassword = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(' login'),
        centerTitle: true,
      ),
      resizeToAvoidBottomInset: true,
      body: Padding(
        padding: EdgeInsets.only(left: 15, right: 15, bottom: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                Image.asset(
                  'assets/images/login.png',
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                ),
                Container(
                    padding: EdgeInsets.only(left: 5, right: 5),
                    child: Text('New Bachelors Registration App',
                        style: TextStyle(fontSize: 20))),
              ],
            ),
            SizedBox(
              width: 30,
            ),
            Container(
              child: Column(
                children: [
                  Container(
                    child: TextField(
                      controller: bacidController,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          suffixIcon: IconButton(
                            icon: hidePassword
                                ? Icon(Icons.visibility)
                                : Icon(Icons.visibility_off),
                            onPressed: hideMyPass,
                          ),
                          labelText: 'Bac_Id'),
                      obscureText: hidePassword ? true : false,
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(
                          width: 3,
                          color: Colors.white38,
                        ),
                        borderRadius: BorderRadius.circular(10)),
                    child: TextField(
                      controller: nameController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Name',
                      ),
                    ),
                  ),
                  Container(
                    child: TextField(
                      controller: familynameController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'FamilyName',
                      ),
                    ),
                  ),
                  Container(
                    child: TextField(
                      controller: emailController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Email',
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {},
                  child: Text(
                    'Enter',
                    style: TextStyle(fontSize: 20),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
