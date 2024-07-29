import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sistem_pakar/Components/color.dart';
import 'package:sistem_pakar/page/diagnosis_page.dart';

class Diagnosa extends StatefulWidget {
  const Diagnosa({super.key});

  @override
  State<Diagnosa> createState() => _DiagnosaState();
}

class _DiagnosaState extends State<Diagnosa> {
  String namalengkap = '';
  String hp = '';
  String email = '';
  String alamat = '';
  final TextEditingController _namaLengkapController = TextEditingController();
  final TextEditingController _hpController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _alamatController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  _loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      namalengkap = (prefs.getString('nama_lengkap') ?? '');
      email = (prefs.getString('email') ?? '');
      hp = (prefs.getString('hp') ?? '');
      alamat = (prefs.getString('alamat') ?? '');
      _namaLengkapController.text = namalengkap;
      _emailController.text = email;
      _hpController.text = hp;
      _alamatController.text = alamat;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("DIAGNOSIS PENYAKIT DBD"),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          child: Container(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextFormField(
                  controller: _namaLengkapController,
                  decoration: const InputDecoration(
                    icon: Icon(Icons.people),
                    border: UnderlineInputBorder(),
                    labelText: 'Nama Lengka',
                  ),
                  enabled: false,
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    icon: Icon(Icons.mail),
                    border: UnderlineInputBorder(),
                    labelText: 'Email',
                  ),
                  enabled: false,
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: _hpController,
                  decoration: const InputDecoration(
                    icon: Icon(Icons.phone),
                    border: UnderlineInputBorder(),
                    labelText: 'Nomor Telepon',
                  ),
                  enabled: false,
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: _alamatController,
                  decoration: const InputDecoration(
                    icon: Icon(Icons.map_outlined),
                    border: UnderlineInputBorder(),
                    labelText: 'Alamat Rumah',
                  ),
                  enabled: false,
                ),
                const SizedBox(
                  height: 60,
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(17),
                    color: primaryColor,
                  ),
                  width: MediaQuery.of(context).size.width,
                  child: TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DiagnosisPage(),
                        ),
                      );
                    },
                    child: const Text(
                      "Diagnosis Diri",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
