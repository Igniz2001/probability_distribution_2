import 'package:flutter/material.dart';
import 'dart:math';

class NormalDistributionPage extends StatefulWidget {
  @override
  _NormalDistributionPageState createState() => _NormalDistributionPageState();
}

class _NormalDistributionPageState extends State<NormalDistributionPage> {
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
        title: Text('Distribución Normal'),
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
            Text(
                'Probabilidad = (1 / (Desviación Estándar * sqrt(2 * pi))) * e^(-(x - Media)^2 / (2 * Desviación Estándar ^ 2))'),
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
    double z = (x - mean) / stdDev;
    double probability = 0.5 * (1 - erf(z / sqrt(2)));
    return probability;
  }

  double calculateProbabilityXLessThan(double mean, double stdDev, double x) {
    double z = (x - mean) / stdDev;
    double probability = 0.5 * (1 + erf(z / sqrt(2)));
    return probability;
  }

  double erf(double z) {
    double t = 1.0 / (1.0 + 0.5 * z.abs());
    double ans = 1 -
        t *
            exp(-z * z -
                1.26551223 +
                t *
                    (1.00002368 +
                        t *
                            (0.37409196 +
                                t *
                                    (0.09678418 +
                                        t *
                                            (-0.18628806 +
                                                t *
                                                    (0.27886807 +
                                                        t *
                                                            (-1.13520398 +
                                                                t *
                                                                    (1.48851587 +
                                                                        t *
                                                                            (-0.82215223 +
                                                                                t * (0.17087277))))))))));
    return z >= 0 ? ans : -ans;
  }
}
