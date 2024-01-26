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

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pay Calculator'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: hoursController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Number of Hours Worked',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the number of hours worked';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: rateController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Hourly Rate',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the hourly rate';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    calculatePay();
                  }
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.blue, // Blue color
                  minimumSize: const Size(80, 50),
                ),
                child: const Text('Calculate'),
              ),
              SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Center(
                      child: Text(
                        'Report',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                    ),
                    SizedBox(height: 10),
                    Text('Regular Pay: ${regularPay.toStringAsFixed(2)}', style: const TextStyle(fontWeight: FontWeight.bold)),
                    Text('Overtime Pay: ${overtimePay.toStringAsFixed(2)}', style: TextStyle(fontWeight: FontWeight.bold)),
                    Text('Total Pay: ${totalPay.toStringAsFixed(2)}', style: const TextStyle(fontWeight: FontWeight.bold)),
                    Text('Tax: ${tax.toStringAsFixed(2)}', style: TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Container(
                color: Color.fromARGB(255, 109, 108, 107),
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
