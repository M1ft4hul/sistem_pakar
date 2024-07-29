import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Riwayat extends StatefulWidget {
  const Riwayat({Key? key}) : super(key: key);

  @override
  _RiwayatState createState() => _RiwayatState();
}

class _RiwayatState extends State<Riwayat> {
  List<String> diagnosisHistory = [];
  String? currentUser;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _loadCurrentUser();
  }

  void _loadCurrentUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      currentUser = prefs.getString('nama_lengkap');
      _loadDiagnosisHistory();
    });
  }

  void _loadDiagnosisHistory() async {
    if (currentUser == null) return;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      diagnosisHistory =
          prefs.getStringList('diagnosis_history_$currentUser') ?? [];
    });
  }

  Color _getBackgroundColor(String diagnosis) {
    switch (diagnosis) {
      case 'Anda tidak terpapar DBD':
        return Colors.green;
      case 'Anda Mengalami DBD Klasik':
        return Colors.blue;
      case 'Anda Mengalami Dengue Hemorrhagic Fever (DHF)':
        return Colors.orange;
      case 'Anda Mengalami Shock Syndrome Stadium 3 DBD':
        return Colors.red;
      default:
        return Colors.grey; // Warna default jika diagnosis tidak dikenali
    }
  }

  String _getDiagnosisText(String diagnosis) {
    switch (diagnosis) {
      case 'Anda tidak terpapar DBD':
        return 'Tidak terinfeksi DBD';
      case 'Anda Mengalami DBD Klasik':
        return 'Stadium 1 DBD';
      case 'Anda Mengalami Dengue Hemorrhagic Fever (DHF)':
        return 'Stadium 2 DBD';
      case 'Anda Mengalami Shock Syndrome Stadium 3 DBD':
        return 'Stadium akhir DBD';
      default:
        return 'Diagnosis tidak dikenali'; // Teks default jika diagnosis tidak dikenali
    }
  }

  @override
  Widget build(BuildContext context) {
    return diagnosisHistory.isEmpty
        ? const Center(
            child: Text("Belum ada riwayat diagnosis"),
          )
        : ListView.builder(
            controller: _scrollController,
            itemCount: diagnosisHistory.length,
            itemBuilder: (context, index) {
              // Split diagnosis result from time
              List<String> diagnosisResult =
                  diagnosisHistory[index].split(' - ');
              String diagnosis = diagnosisResult[0];
              // String time = diagnosisResult[1];

              return Card(
                margin: const EdgeInsets.all(10.0),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      ListTile(
                        title: Text('Diagnosa: $diagnosis'),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              vertical: 22,
                              horizontal: 9,
                            ),
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.asset(
                                  'assets/diagnosa.png',
                                  width: 65,
                                ),
                              ),
                              const SizedBox(
                                width: 14,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 5),
                                    child: Text(
                                      currentUser ?? "Nama Pengguna",
                                      style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.purple[700],
                                      ),
                                    ),
                                  ),
                                  // Container(
                                  //   padding: const EdgeInsets.symmetric(
                                  //       vertical: 3, horizontal: 8.0),
                                  //   decoration: BoxDecoration(
                                  //     color: _getBackgroundColor(diagnosis),
                                  //     borderRadius: BorderRadius.circular(10),
                                  //   ),
                                  //   child: Row(
                                  //     children: [
                                  //       Padding(
                                  //         padding:
                                  //             const EdgeInsets.only(right: 8.0),
                                  //         child: Icon(
                                  //           Icons.access_time,
                                  //           size: 18,
                                  //           color: Colors.white,
                                  //         ),
                                  //       ),
                                  //       Text(
                                  //         time,
                                  //         style: TextStyle(
                                  //           color: Colors.white,
                                  //         ),
                                  //       ),
                                  //     ],
                                  //   ),
                                  // ),
                                  const SizedBox(height: 5),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 3,
                                      horizontal: 8.0,
                                    ),
                                    decoration: BoxDecoration(
                                      color: _getBackgroundColor(diagnosis),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Text(
                                      _getDiagnosisText(diagnosis),
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 18,
                      )
                    ],
                  ),
                ),
              );
            },
          );
  }
}
