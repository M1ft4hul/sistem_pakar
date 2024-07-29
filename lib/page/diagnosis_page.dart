import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sistem_pakar/Components/color.dart';
import 'package:sistem_pakar/page/dashboard.dart';
import 'package:sistem_pakar/page/diagnosa.dart';
import 'package:sistem_pakar/page/pola_hidup.dart';

class DiagnosisPage extends StatefulWidget {
  @override
  _DiagnosisPageState createState() => _DiagnosisPageState();
}

class _DiagnosisPageState extends State<DiagnosisPage> {
  int currentQuestionIndex = 0;
  Map<String, bool> symptoms = {
    "Demam tinggi 40 derajat (2-7 hari)": false,
    "Linu seluruh badan": false,
    "Sakit tenggorokan": false,
    "Sakit kepala": false,
    "Mual dan muntah": false,
    "Ruam dikulit (muncul setelah 4 hari)": false,
    "Kerusakan pembuluh darah (muncul darah dalam muntah)": false,
    "Pendarahan hidung (mimisan)": false,
    "Pendarahan gusi": false,
    "Fases berwarna hitam": false,
    "Kebocoran diluar pembuluh darah": false,
    "Pendarahan parah": false,
    "Shock (Tekanan darah sangat rendah)": false,
  };

  List<String> questions = [
    "Demam tinggi 40 derajat (2-7 hari)",
    "Linu seluruh badan",
    "Sakit tenggorokan",
    "Sakit kepala",
    "Mual dan muntah",
    "Ruam dikulit (muncul setelah 4 hari)",
    "Kerusakan pembuluh darah (muncul darah dalam muntah)",
    "Pendarahan hidung (mimisan)",
    "Pendarahan gusi",
    "Fases berwarna hitam",
    "Kebocoran diluar pembuluh darah",
    "Pendarahan parah",
    "Shock (Tekanan darah sangat rendah)",
  ];

  String? selectedAnswer;

  void _nextQuestion() {
    if (selectedAnswer != null) {
      symptoms[questions[currentQuestionIndex]] = selectedAnswer == "Iya";

      if (currentQuestionIndex == questions.length - 1) {
        _showDiagnosisResult();
      } else {
        setState(() {
          currentQuestionIndex++;
          selectedAnswer = null;
        });
      }
    }
  }

  void _previousQuestion() {
    if (currentQuestionIndex > 0) {
      setState(() {
        currentQuestionIndex--;
      });
    }
  }

  void _showDiagnosisResult() async {
    String diagnosis = _diagnose();

    String advice = "";

    bool showAdviceButton = false;

    if (diagnosis == "Anda Mengalami DBD Klasik") {
      advice =
          "Perbanyak cairan dengan mengkonsumsi air mineral dan istirahat yang cukup";
      showAdviceButton = true;
    } else if (diagnosis == "Anda tidak terpapar DBD") {
      advice =
          "Silahkan berobat secara alami atau bisa mengkonsumsi antibiotik";
      showAdviceButton = false;
    } else {
      advice =
          "Silahkan mengunjungi faskes/ fasilitas kesehatan terdekat untuk mendapatkan pertolongan dokter";
      showAdviceButton = false;
    }

    // Simpan hasil diagnosis ke SharedPreferences
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // await prefs.setString('diagnosis_result', diagnosis);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? currentUser = prefs.getString('nama_lengkap');
    if (currentUser == null) return;

    List<String> diagnosisHistory =
        prefs.getStringList('diagnosis_history_$currentUser') ?? [];
    diagnosisHistory.add(diagnosis);
    await prefs.setStringList(
        'diagnosis_history_$currentUser', diagnosisHistory);
    // List<String> diagnosisHistory =
    //     prefs.getStringList('diagnosis_history') ?? [];
    // diagnosisHistory.add(diagnosis);
    // await prefs.setStringList('diagnosis_history', diagnosisHistory);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Hasil Diagnosis"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(diagnosis),
              const SizedBox(
                height: 10,
              ),
              Text(
                "Keterangan",
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(
                height: 10,
              ),
              Text(advice),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: const Text("Selesai"),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const Home()),
                  (Route<dynamic> route) => false,
                );
              },
            ),
            if (showAdviceButton)
              TextButton(
                child: const Text("Atur Pola Hidup"),
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Pola(),
                    ),
                  );
                },
              ),
          ],
        );
      },
    );
  }

  String _diagnose() {
    if (symptoms["Demam tinggi 40 derajat (2-7 hari)"]! &&
        symptoms["Linu seluruh badan"]! &&
        symptoms["Sakit tenggorokan"]! &&
        symptoms["Sakit kepala"]! &&
        symptoms["Mual dan muntah"]! &&
        symptoms["Ruam dikulit (muncul setelah 4 hari)"]! &&
        !symptoms["Kerusakan pembuluh darah (muncul darah dalam muntah)"]! &&
        !symptoms["Pendarahan hidung (mimisan)"]! &&
        !symptoms["Pendarahan gusi"]! &&
        !symptoms["Fases berwarna hitam"]! &&
        !symptoms["Kebocoran diluar pembuluh darah"]! &&
        !symptoms["Pendarahan parah"]! &&
        !symptoms["Shock (Tekanan darah sangat rendah)"]!) {
      return "Anda Mengalami DBD Klasik";
    } else if (symptoms["Demam tinggi 40 derajat (2-7 hari)"]! &&
        symptoms["Linu seluruh badan"]! &&
        symptoms["Sakit tenggorokan"]! &&
        symptoms["Sakit kepala"]! &&
        symptoms["Mual dan muntah"]! &&
        symptoms["Ruam dikulit (muncul setelah 4 hari)"]! &&
        symptoms["Kerusakan pembuluh darah (muncul darah dalam muntah)"]! &&
        symptoms["Pendarahan hidung (mimisan)"]! &&
        symptoms["Pendarahan gusi"]! &&
        symptoms["Fases berwarna hitam"]! &&
        !symptoms["Kebocoran diluar pembuluh darah"]! &&
        !symptoms["Pendarahan parah"]! &&
        !symptoms["Shock (Tekanan darah sangat rendah)"]!) {
      return "Anda Mengalami Dengue Hemorrhagic Fever (DHF)";
    } else if (symptoms["Demam tinggi 40 derajat (2-7 hari)"]! &&
        symptoms["Linu seluruh badan"]! &&
        symptoms["Sakit tenggorokan"]! &&
        symptoms["Sakit kepala"]! &&
        symptoms["Mual dan muntah"]! &&
        symptoms["Ruam dikulit (muncul setelah 4 hari)"]! &&
        symptoms["Kerusakan pembuluh darah (muncul darah dalam muntah)"]! &&
        symptoms["Pendarahan hidung (mimisan)"]! &&
        symptoms["Pendarahan gusi"]! &&
        symptoms["Fases berwarna hitam"]! &&
        symptoms["Kebocoran diluar pembuluh darah"]! &&
        symptoms["Pendarahan parah"]! &&
        symptoms["Shock (Tekanan darah sangat rendah)"]!) {
      return "Anda Mengalami Shock Syndrome Stadium 3 DBD";
    } else {
      return "Anda tidak terpapar DBD";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/bg.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: const EdgeInsets.all(26.0),
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Diagnosa(),
                    ),
                  );
                },
                icon: const Icon(
                  Icons.close,
                  color: Colors.white,
                ),
                label: const Text(
                  "Batalkan",
                  style: TextStyle(color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(backgroundColor: redColor),
              ),
            ),
          ),
          Center(
            child: Card(
              elevation: 4,
              margin: const EdgeInsets.all(16),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      questions[currentQuestionIndex],
                      style: const TextStyle(fontSize: 20),
                    ),
                    const SizedBox(height: 20),
                    ListTile(
                      title: const Text("Iya"),
                      leading: Radio<String>(
                        value: "Iya",
                        groupValue: selectedAnswer,
                        onChanged: (String? value) {
                          setState(() {
                            selectedAnswer = value;
                          });
                        },
                      ),
                    ),
                    ListTile(
                      title: const Text("Tidak"),
                      leading: Radio<String>(
                        value: "Tidak",
                        groupValue: selectedAnswer,
                        onChanged: (String? value) {
                          setState(() {
                            selectedAnswer = value;
                          });
                        },
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (currentQuestionIndex >
                            0) // Menampilkan tombol Kembali jika bukan pertanyaan pertama
                          ElevatedButton(
                            onPressed: _previousQuestion,
                            child: const Text("Kembali"),
                          ),
                        const SizedBox(width: 16), // Spasi antara tombol
                        ElevatedButton(
                          onPressed:
                              selectedAnswer != null ? _nextQuestion : null,
                          child: const Text("Selanjutnya"),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
