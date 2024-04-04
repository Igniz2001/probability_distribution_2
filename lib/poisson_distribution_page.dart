import 'package:flutter/material.dart';
import 'dart:math';

class PoissonDistributionPage extends StatefulWidget {
  @override
  _PoissonDistributionPageState createState() => _PoissonDistributionPageState();
}

class _PoissonDistributionPageState extends State<PoissonDistributionPage> {
  TextEditingController lambdaController = TextEditingController();
  TextEditingController xController = TextEditingController();
  String? _selectedCondition; // Cambiado a tipo nullable
  double variance = 0;
  double expectation = 0;
  double probability = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Distribución de Poisson'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              controller: lambdaController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Valor de Lambda'),
            ),
            TextFormField(
              controller: xController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Valor de x'),
            ),
            DropdownButton<String>(
              hint: Text('Seleccione la condición'),
              value: _selectedCondition,
              onChanged: (String? value) { // Cambiado a tipo nullable
                setState(() {
                  _selectedCondition = value;
                });
              },
              items: <String>['Mayor o igual a', 'Menor o igual a', 'Igual a'].map((String value) {
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
            Text('Varianza = lambda'),
            Text('Esperanza = lambda'),
            Text('Probabilidad = (lambda^x * e^(-lambda)) / x!'),
          ],
        ),
      ),
    );
  }

  void calculateResults() {
    double lambda = double.tryParse(lambdaController.text) ?? 0.0; // Proporciona valor predeterminado si la conversión falla
    int x = int.tryParse(xController.text) ?? 0; // Proporciona valor predeterminado si la conversión falla
    if (lambda <= 0 || x < 0) {
      // Manejar caso de valores no válidos
      return;
    }

    variance = lambda;
    expectation = lambda;

    if (_selectedCondition == 'Mayor o igual a') {
      probability = calculateProbabilityXGreaterThanOrEqual(lambda, x);
    } else if (_selectedCondition == 'Menor o igual a') {
      probability = calculateProbabilityLessThanOrEqual(lambda, x);
    } else {
      probability = _calculateProbability(lambda, x);
    }

    setState(() {});
  }

  double _calculateProbability(double lambda, int x) {
    double probability = (pow(lambda, x) * exp(-lambda)) / _factorial(x);
    return probability;
  }

  double calculateProbabilityXGreaterThanOrEqual(double lambda, int k) {
  double sum = 0;
  for (int i = k; i >= 0; i--) {
    sum += _calculateProbability(lambda, i);
  }
  return sum;
}


  double calculateProbabilityLessThanOrEqual(double lambda, int x) {
    double probability = 0;
    for (int i = 0; i <= x; i++) {
      probability += _calculateProbability(lambda, i);
    }
    return probability;
  }

  int _factorial(int n) {
    if (n <= 0) {
      return 1;
    }
    int result = 1;
    for (int i = 1; i <= n; i++) {
      result *= i;
    }
    return result;
  }
}
