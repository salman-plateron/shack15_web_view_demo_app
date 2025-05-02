import 'package:flutter/material.dart';
import 'package:shack15_web_view_demo/webview_page.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _mobileController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF1E3C72), Color(0xFF2A5298)],
        ),
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                "Login",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 30),
              TextField(
                controller: _usernameController,
                decoration: InputDecoration(
                  hintText: "User Name",
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  filled: true,
                  fillColor: Colors.white.withOpacity(0.9),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _mobileController,
                keyboardType: TextInputType.phone,
                maxLength: 10,
                decoration: InputDecoration(
                  hintText: "Mobile number",
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  filled: true,
                  fillColor: Colors.white.withOpacity(0.9),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  counterText: "",
                ),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  backgroundColor: Colors.white,
                  foregroundColor: Color(0xFF1E3C72),
                  elevation: 5,
                ),
                onPressed: () {
                  if (_mobileController.text.length != 10) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Mobile number must be 10 digits"),
                        backgroundColor: Colors.red,
                      ),
                    );
                    return;
                  }
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => WebViewPage(
                        authtoken: "state.data['token']",
                        userRefid: "state.data['refId']",
                        sessionToken: "state.sessionToken",
                        webUrl:
                            'https://qa.onlineorders.novatab.com/#/menu/71b2f49c-bf91-40eb-87cf-5402581e1b21?orderType=&viewType=embeddedView&mobile=${_mobileController.text}&name=${_usernameController.text}',
                      ),
                    ),
                  );
                },
                child: const Text(
                  "Create Order",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  backgroundColor: Colors.white,
                  foregroundColor: Color(0xFF1E3C72),
                  elevation: 5,
                ),
                onPressed: () {
                  if (_mobileController.text.length != 10) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Mobile number must be 10 digits"),
                        backgroundColor: Colors.red,
                      ),
                    );
                    return;
                  }
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => WebViewPage(
                        authtoken: "state.data['token']",
                        userRefid: "state.data['refId']",
                        sessionToken: "state.sessionToken",
                        webUrl:
                            'https://qa.onlineorders.novatab.com/#/orderList/71b2f49c-bf91-40eb-87cf-5402581e1b21?orderType=&viewType=embeddedView&mobile=${_mobileController.text}&name=${_usernameController.text}',
                      ),
                    ),
                  );
                },
                child: const Text(
                  "Order List",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  backgroundColor: Colors.white,
                  foregroundColor: Color(0xFF1E3C72),
                  elevation: 5,
                ),
                onPressed: () {
                  if (_mobileController.text.length != 10) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Mobile number must be 10 digits"),
                        backgroundColor: Colors.red,
                      ),
                    );
                    return;
                  }
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => WebViewPage(
                        authtoken: "state.data['token']",
                        userRefid: "state.data['refId']",
                        sessionToken: "state.sessionToken",
                        webUrl:
                            "https://qa.onlineorders.novatab.com/#/cart/71b2f49c-bf91-40eb-87cf-5402581e1b21?repatOrder=115cdf10-8760-4d8b-be74-b4cf0a1b9c37&viewType=embeddedView&mobile=${_mobileController.text}&name=${_usernameController.text}",
                      ),
                    ),
                  );
                },
                child: const Text(
                  "Repeat the order",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
