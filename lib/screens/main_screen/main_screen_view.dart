import 'dart:ffi';
import 'package:flutter/material.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => MainViewState();
}

class MainViewState extends State<MainView> {
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  double result = 0;
  String obesityLevel = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.all(15),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const Text("BMI Calculator"),
              TextFormField(
                controller: _heightController,
                validator: (value) {
                  return heightValidate(value);
                },
                decoration: const InputDecoration(
                  labelText: "Height (CM)",
                  hintText: "Enter your height",
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: _weightController,
                validator: (value) {
                  return weightValidate(value);
                },
                decoration: const InputDecoration(
                  labelText: "Weight",
                  hintText: "Enter your weight",
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      calculateBMI();
                    }
                  },
                  child: const Text("Calculate"),
                ),
              ),
              const SizedBox(height: 25),
              result != 0 ? Text("Your BMI is $result") : const Text(""),
              const SizedBox(height: 10),
              result != 0 ? Text("You are $obesityLevel") : const Text(""),
            ],
          ),
        ),
      ),
    );
  }

  String? heightValidate(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your height';
    }
    return null;
  }

  void calculateBMI() {
    double height = double.parse(_heightController.text);
    double weight = double.parse(_weightController.text);
    double bmi = weight / (height * height) * 10000;
    setState(() {
      result = bmi;
    });
    measuringObesity();
  }

  measuringObesity() {
    String newMeasuringObesity = "";
    if (result < 18.5) {
      newMeasuringObesity = "Underweight";
    } else if (result >= 18.5 && result <= 24.9) {
      newMeasuringObesity = "Normal";
    } else if (result >= 25 && result <= 29.9) {
      newMeasuringObesity = "Overweight";
    } else if (result >= 30 && result <= 39.9) {
      newMeasuringObesity = "Obesity";
    } else if (result >= 40) {
      newMeasuringObesity = "Very obesity";
    }
    setState(() {
      obesityLevel = newMeasuringObesity;
    });
  }

  String? weightValidate(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your height';
    }
    return null;
  }
}
