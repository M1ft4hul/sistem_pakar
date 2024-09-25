import 'package:flutter/material.dart';
import 'package:sistem_pakar/Components/color.dart';
import 'package:sistem_pakar/page/login.dart';
import 'package:sistem_pakar/theme.dart';
import 'package:http/http.dart' as http;

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool _secureText = true;
  showHide() {
    setState(() {
      _secureText = !_secureText;
    });
  }

  final formKey = GlobalKey<FormState>();
  TextEditingController nama_lengkap = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController hp = TextEditingController();
  TextEditingController alamat = TextEditingController();
  TextEditingController password = TextEditingController();

  Future _daftar() async {
    final response = await http.post(
        Uri.parse('http://192.168.1.10/sistem_pakar_app/Register.php'),
        body: {
          "nama_lengkap": nama_lengkap.text,
          "email": email.text,
          "hp": hp.text,
          "alamat": alamat.text,
          "password": password.text,
        });
    if (response.statusCode == 200) {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          // children: [
          child: Container(
            padding: const EdgeInsets.all(24),
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
                  "REGISTER",
                  style: regulerTextStyle.copyWith(fontSize: 25),
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  "Daftar akun baru di sini",
                  style: regulerTextStyle.copyWith(
                      fontSize: 15, color: greyLightColor),
                ),
                const SizedBox(
                  height: 24,
                ),
                // note text filed

                TextFormField(
                  controller: nama_lengkap,
                  decoration: const InputDecoration(
                    icon: Icon(Icons.person),
                    border: UnderlineInputBorder(),
                    labelText: 'Nama Lengkap',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Nama Tidak boleh kosong";
                    }
                    return null;
                  },
                ),

                const SizedBox(
                  height: 20,
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
                  controller: hp,
                  decoration: const InputDecoration(
                    icon: Icon(Icons.phone),
                    border: UnderlineInputBorder(),
                    labelText: 'Nomor Hp',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "No HP Tidak boleh kosong";
                    }
                    return null;
                  },
                ),

                const SizedBox(
                  height: 20,
                ),

                TextFormField(
                  controller: alamat,
                  decoration: const InputDecoration(
                    icon: Icon(Icons.map),
                    border: UnderlineInputBorder(),
                    labelText: 'Alamat Rumah',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Alamat Tidak boleh kosong";
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

                // BIKIN TOMBOL TUH GINI
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(17),
                    color: primaryColor,
                  ),
                  width: MediaQuery.of(context).size.width,
                  child: TextButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        _daftar().then((value) {
                          if (value) {
                            final snackBar = SnackBar(
                              content: const Text('Register Berhasil'),
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);

                            // login jika berhasil
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Login()));
                          } else {
                            final snackBar = SnackBar(
                              content:
                                  const Text('This user is already registered'),
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          }
                        });
                      }
                    },
                    child: const Text(
                      "REGISTER",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),

                // buat tulisa sudah punya akun
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Anda sudah memiliki akun? ",
                      style: lightTextStyle.copyWith(
                          color: greyBoldColor, fontSize: 15),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context) => Login()));
                      },
                      child: Text(
                        "Login sekarang",
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
