import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: PayCalculatorScreen(),
    );
  }
}

class PayCalculatorScreen extends StatefulWidget {
  const PayCalculatorScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _PayCalculatorScreenState createState() => _PayCalculatorScreenState();
}

class _PayCalculatorScreenState extends State<PayCalculatorScreen> {
  TextEditingController hoursController = TextEditingController();
  TextEditingController rateController = TextEditingController();
  double regularPay = 0.0;
  double overtimePay = 0.0;
  double totalPay = 0.0;
  double tax = 0.0;

  final String collegeID = '30136578';
  final String name = 'Saroj Kunwar';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pay Calculator'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: hoursController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Number of Hours Worked'),
            ),
            TextField(
              controller: rateController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Hourly Rate'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                calculatePay();
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.lightGreen, // Light green color
              ),
              child: const Text('Calculate'),
            ),
            const SizedBox(height: 20),
            const Text('Report', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            const SizedBox(height: 20),
            Text('Regular Pay: ${regularPay.toStringAsFixed(2)}', style: TextStyle(fontWeight: FontWeight.bold)),
            Text('Overtime Pay: ${overtimePay.toStringAsFixed(2)}', style: TextStyle(fontWeight: FontWeight.bold)),
            Text('Total Pay: ${totalPay.toStringAsFixed(2)}', style: TextStyle(fontWeight: FontWeight.bold)),
            Text('Tax: ${tax.toStringAsFixed(2)}', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 20), 
            Container(
              color: Color.fromARGB(255, 109, 108, 107), // You can customize the color
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('College ID: $collegeID', style: TextStyle(color: Colors.white)),
                  Text('Name: $name', style: TextStyle(color: Colors.white)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void calculatePay() {
    double hours = double.tryParse(hoursController.text) ?? 0.0;
    double rate = double.tryParse(rateController.text) ?? 0.0;

    if (hours <= 40) {
      regularPay = hours * rate;
      overtimePay = 0.0;
    } else {
      regularPay = 40 * rate;
      overtimePay = (hours - 40) * rate * 1.5;
    }

    totalPay = regularPay + overtimePay;
    tax = totalPay * 0.18;

    setState(() {});
  }
}
