import 'package:flutter/material.dart';

class Info extends StatelessWidget {
  const Info({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tentang Aplikasi'),
      ),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Sistem Pakar Diagnosis DBD',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Versi Aplikasi: 1.0.0',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Aplikasi ini dirancang untuk membantu pengguna dalam '
              'mendiagnosis Demam Berdarah Dengue (DBD) menggunakan '
              'algoritma forward chaining. Dengan memasukkan gejala-gejala '
              'yang dialami, aplikasi ini akan memberikan diagnosis awal '
              'berdasarkan pengetahuan yang ada.',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Aplikasi ini diharapkan dapat memberikan panduan awal '
              'yang berguna bagi masyarakat untuk mendeteksi DBD secara dini.',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
