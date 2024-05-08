import 'package:flutter/material.dart';
import 'dart:math';

class StudentTDistributionPage extends StatefulWidget {
  @override
  _StudentTDistributionPageState createState() =>
      _StudentTDistributionPageState();
}

class _StudentTDistributionPageState extends State<StudentTDistributionPage> {
  TextEditingController meanController = TextEditingController();
  TextEditingController stdDevController = TextEditingController();
  TextEditingController xController = TextEditingController();
  String? _selectedCondition; // Cambiado a tipo nullable
  double variance = 0;
  double expectation = 0;
  double probability = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Distribución t de Student'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              controller: meanController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Valor de Media'),
            ),
            TextFormField(
              controller: stdDevController,
              keyboardType: TextInputType.number,
              decoration:
                  InputDecoration(labelText: 'Valor de Desviación Estándar'),
            ),
            TextFormField(
              controller: xController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Valor de x'),
            ),
            DropdownButton<String>(
              hint: Text('Seleccione la condición'),
              value: _selectedCondition,
              onChanged: (String? value) {
                // Cambiado a tipo nullable
                setState(() {
                  _selectedCondition = value;
                });
              },
              items: <String>['P(X>x)', 'P(X<x)'].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            ElevatedButton(
              onPressed: () {
                calculateResults();
              },
              child: Text('Calcular'),
            ),
            SizedBox(height: 20),
            Text('Resultados:'),
            Text('Varianza: $variance'),
            Text('Esperanza: $expectation'),
            Text('Probabilidad: $probability'),
            SizedBox(height: 20),
            Text('Fórmulas:'),
            Text('Varianza = Desviación Estándar ^ 2'),
            Text('Esperanza = Media'),
            Text('Probabilidad = ... (fórmula de distribución t de Student)'),
          ],
        ),
      ),
    );
  }

  void calculateResults() {
    double mean = double.tryParse(meanController.text) ??
        0.0; // Proporciona valor predeterminado si la conversión falla
    double stdDev = double.tryParse(stdDevController.text) ??
        0.0; // Proporciona valor predeterminado si la conversión falla
    double x = double.tryParse(xController.text) ??
        0.0; // Proporciona valor predeterminado si la conversión falla
    if (stdDev <= 0) {
      // Manejar caso de valores no válidos
      return;
    }

    variance = stdDev * stdDev;
    expectation = mean;

    if (_selectedCondition == 'P(X>x)') {
      probability = calculateProbabilityXGreaterThan(mean, stdDev, x);
    } else if (_selectedCondition == 'P(X<x)') {
      probability = calculateProbabilityXLessThan(mean, stdDev, x);
    }

    setState(() {});
  }

  double calculateProbabilityXGreaterThan(
      double mean, double stdDev, double x) {
    // Aquí deberías calcular la probabilidad usando la distribución t de Student
    // Por favor, reemplaza esta línea con la fórmula correspondiente
    return 0.0;
  }

  double calculateProbabilityXLessThan(double mean, double stdDev, double x) {
    // Aquí deberías calcular la probabilidad usando la distribución t de Student
    // Por favor, reemplaza esta línea con la fórmula correspondiente
    return 0.0;
  }
}
