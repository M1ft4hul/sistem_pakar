import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sistem_pakar/Components/color.dart';
import 'package:sistem_pakar/page/dashboard.dart';
import 'package:sistem_pakar/page/register.dart';
import 'package:sistem_pakar/theme.dart';
import 'package:http/http.dart' as http;

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool _secureText = true;
  showHide() {
    setState(() {
      _secureText = !_secureText;
    });
  }

  final formKey = GlobalKey<FormState>();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  Future _login() async {
    final response = await http.post(
        Uri.parse('http://192.168.43.37/sistem_pakar_app/Login.php'),
        body: {
          "email": email.text,
          "password": password.text,
        });
    if (response.statusCode == 200) {
      // SharedPreferences prefs = await SharedPreferences.getInstance();
      // await prefs.setString('email', email.text);
      // return true;
      final data = jsonDecode(response.body);

      if (data['status']) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('email', data['userData']['email']);
        await prefs.setString('nama_lengkap', data['userData']['nama_lengkap']);
        await prefs.setString('hp', data['userData']['hp']);
        await prefs.setString('alamat', data['userData']['alamat']);
        return true;
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Container(
            padding: EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 20,
                ),
                Image.asset(
                  "assets/login.gif",
                  width: 120,
                ),
                Text(
                  "LOGIN",
                  style: regulerTextStyle.copyWith(fontSize: 25),
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  "Login into your account",
                  style: regulerTextStyle.copyWith(
                      fontSize: 15, color: greyLightColor),
                ),
                const SizedBox(
                  height: 24,
                ),
                TextFormField(
                  controller: email,
                  decoration: const InputDecoration(
                    icon: Icon(Icons.email),
                    border: UnderlineInputBorder(),
                    labelText: 'Email',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Email Tidak boleh kosong";
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: password,
                  obscureText: _secureText,
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      onPressed: showHide,
                      icon: _secureText
                          ? const Icon(
                              Icons.visibility_off,
                              size: 20,
                            )
                          : const Icon(
                              Icons.visibility,
                              size: 20,
                            ),
                    ),
                    icon: Icon(Icons.password),
                    border: UnderlineInputBorder(),
                    labelText: 'Password',
                    hintStyle: lightTextStyle.copyWith(
                      fontSize: 15,
                      color: greyLightColor,
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Password Tidak boleh kosong";
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 30,
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(17),
                    color: primaryColor,
                  ),
                  width: MediaQuery.of(context).size.width,
                  child: TextButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        _login().then((value) {
                          if (value) {
                            final snackBar = SnackBar(
                              content: const Text('User Verified'),
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                            // login jika berhasil
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Home()));
                          } else {
                            final snackBar = SnackBar(
                              content:
                                  const Text('Opps!! Datanya masih salahh'),
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          }
                        });
                      }
                    },
                    child: const Text(
                      "SUBMIT",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account? ",
                      style: lightTextStyle.copyWith(
                          color: greyBoldColor, fontSize: 15),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => RegisterPage()));
                      },
                      child: Text(
                        "Register now",
                        style: boldTextStyle.copyWith(
                            color: purpleColor, fontSize: 15),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
