import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BMIScreen(),
    ),
  );
}

class BMIScreen extends StatefulWidget {
  const BMIScreen({super.key});

  @override
  State<BMIScreen> createState() => _BMIScreenState();
}

class _BMIScreenState extends State<BMIScreen> {
  final _bbController = TextEditingController();
  final _tbController = TextEditingController();

  String? _jenisKelamin;
  double? _hasilBMI;
  String _keterangan = "Masukkan Data Anda!!!";

  void _hitungBMI() {
    final double? bb = double.tryParse(
      _bbController.text.replaceAll(',', '.').trim(),
    );

    final double? tbCm = double.tryParse(
      _tbController.text.replaceAll(',', '.').trim(),
    );

    setState(() {
      if (_jenisKelamin == null ||
          bb == null ||
          tbCm == null ||
          bb <= 0 ||
          tbCm <= 0) {
        _hasilBMI = null;
        _keterangan =
            "Pilih jenis kelamin dan masukkan data yang valid!!!";
        return;
      }

      final double tbM = tbCm / 100;
      final double hasil = bb / (tbM * tbM);

      _hasilBMI = hasil;

      if (hasil < 18.5) {
        _keterangan = "Kurus";
      } else if (hasil < 25) {
        _keterangan = "Rentang BMI normal";
      } else if (hasil < 30) {
        _keterangan = "Kelebihan Berat Badan";
      } else {
        _keterangan = "Obesitas";
      }
    });
  }

  // Fungsi untuk mengosongkan semua data
  void _reset() {
    setState(() {
      _bbController.clear();
      _tbController.clear();
      _jenisKelamin = null;
      _hasilBMI = null;
      _keterangan = "Masukkan Data Anda!!!";
    });
  }

  @override
  void dispose() {
    _bbController.dispose();
    _tbController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Kalkulator BMI',
          style: TextStyle(
            fontFamily: 'lobster',
            fontWeight: FontWeight.bold,
            letterSpacing: 5,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.lightBlue,
        foregroundColor: Colors.white,
        leading: const Icon(Icons.accessibility),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  icon: const Icon(
                    Icons.person,
                    size: 30,
                  ),
                  labelText: 'Jenis Kelamin',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                value: _jenisKelamin,
                items: const [
                  DropdownMenuItem(
                    value: 'Laki-laki',
                    child: Text('Laki-laki'),
                  ),
                  DropdownMenuItem(
                    value: 'Perempuan',
                    child: Text('Perempuan'),
                  ),
                ],
                onChanged: (value) {
                  setState(() {
                    _jenisKelamin = value;
                  });
                },
              ),
              const SizedBox(height: 15),
              TextField(
                controller: _bbController,
                keyboardType:
                    const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                decoration: InputDecoration(
                  icon: const Icon(
                    Icons.monitor_weight,
                    size: 30,
                  ),
                  labelText: 'Berat Badan (kg)',
                  labelStyle: const TextStyle(
                    letterSpacing: 2,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              TextField(
                controller: _tbController,
                keyboardType:
                    const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                decoration: InputDecoration(
                  icon: const Icon(
                    Icons.height,
                    size: 30,
                  ),
                  labelText: 'Tinggi Badan (cm)',
                  labelStyle: const TextStyle(
                    letterSpacing: 2,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 15),

              // Tombol Hitung BMI
              ElevatedButton(
                onPressed: _hitungBMI,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.lightBlue,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    vertical: 20,
                  ),
                ),
                child: const Text(
                  'Hitung BMI',
                  style: TextStyle(fontSize: 20),
                ),
              ),
              const SizedBox(height: 10),

              // Tombol Reset
              OutlinedButton(
                onPressed: _reset,
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.lightBlue,
                  padding: const EdgeInsets.symmetric(
                    vertical: 20,
                  ),
                  side: const BorderSide(
                    color: Colors.lightBlue,
                  ),
                ),
                child: const Text(
                  'Reset',
                  style: TextStyle(fontSize: 20),
                ),
              ),

              const SizedBox(height: 15),
              const Text(
                'Hasil:',
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 15),
              Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.lightBlue.shade300,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    Text(
                      'Jenis Kelamin: '
                      '${_jenisKelamin ?? "-"}',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      _hasilBMI?.toStringAsFixed(1) ??
                          'Nilai Kosong',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      _keterangan,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 20,
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}