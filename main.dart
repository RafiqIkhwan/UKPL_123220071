import 'package:flutter/material.dart';
import 'package:decimal/decimal.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Math App',
      home: const MathPage(),
    );
  }
}

class MathPage extends StatefulWidget {
  const MathPage({super.key});

  @override
  _MathPageState createState() => _MathPageState();
}

class _MathPageState extends State<MathPage> {
  final TextEditingController num1Controller = TextEditingController();
  final TextEditingController num2Controller = TextEditingController();
  String? result;
  String errorMessage = '';

  void calculate(String operation) {
    setState(() {
      errorMessage = '';
      result = null;

      try {
        String num1Text = num1Controller.text.replaceAll(',', '.');
        String num2Text = num2Controller.text.replaceAll(',', '.');

        if (num1Text.contains('/')) {
          var parts = num1Text.split('/');
          double num1 = double.parse(parts[0]);
          double num2 = double.parse(parts[1]);
          num1Text = (num1 / num2).toString();
        }

        if (num2Text.contains('/')) {
          var parts = num2Text.split('/');
          double num1 = double.parse(parts[0]);
          double num2 = double.parse(parts[1]);
          num2Text = (num1 / num2).toString();
        }

        Decimal num1 = Decimal.parse(num1Text);
        Decimal num2 = Decimal.parse(num2Text);

        if (operation == '+') {
          result = (num1 + num2).toString();
        } else if (operation == '-') {
          result = (num1 - num2).toString();
        }
      } catch (e) {
        errorMessage = 'Error: Masukkan angka yang valid!';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Penjumlahan & Pengurangan',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Colors.indigo,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.white, Colors.indigo.shade100],
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Masukkan angka dan pilih operasi',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87),
            ),
            const SizedBox(height: 20),
            _buildTextField(num1Controller, 'Masukkan angka pertama'),
            const SizedBox(height: 15),
            _buildTextField(num2Controller, 'Masukkan angka kedua'),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildOperationButton(
                    '+', Colors.blue.shade400, Colors.blueAccent.shade100),
                _buildOperationButton(
                    '-', Colors.pink.shade400, Colors.red.shade300),
              ],
            ),
            const SizedBox(height: 30),
            if (errorMessage.isNotEmpty)
              Text(
                errorMessage,
                style: const TextStyle(
                    color: Colors.red, fontWeight: FontWeight.bold),
              ),
            Container(
              padding: const EdgeInsets.all(15),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.purple.shade300,
                borderRadius: BorderRadius.circular(15),
                boxShadow: const [
                  BoxShadow(
                      color: Colors.black26,
                      blurRadius: 4,
                      offset: Offset(2, 2)),
                ],
              ),
              child: Center(
                child: Text(
                  result != null
                      ? 'Hasil: $result'
                      : 'Hasil akan muncul di sini',
                  style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String hint) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.numberWithOptions(decimal: true),
      decoration: InputDecoration(
        labelText: hint,
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  Widget _buildOperationButton(String symbol, Color color1, Color color2) {
    return GestureDetector(
      onTap: () => calculate(symbol),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [color1, color2]),
          borderRadius: BorderRadius.circular(15),
          boxShadow: const [
            BoxShadow(color: Colors.black26, blurRadius: 4, offset: Offset(2, 2)),
          ],
        ),
        child: Text(
          symbol,
          style: const TextStyle(
              fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
    );
  }
}
