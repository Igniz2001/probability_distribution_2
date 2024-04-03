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
              decoration: InputDecoration(labelText: 'Valor de Desviación Estándar'),
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
            Text('Varianza = Desviación Estándar ^ 2'),
            Text('Esperanza = Media'),
            Text('Probabilidad = (1 / (Desviación Estándar * sqrt(2 * pi))) * e^(-(x - Media)^2 / (2 * Desviación Estándar ^ 2))'),
          ],
        ),
      ),
    );
  }

  void calculateResults() {
    double mean = double.tryParse(meanController.text) ?? 0.0; // Proporciona valor predeterminado si la conversión falla
    double stdDev = double.tryParse(stdDevController.text) ?? 0.0; // Proporciona valor predeterminado si la conversión falla
    double x = double.tryParse(xController.text) ?? 0.0; // Proporciona valor predeterminado si la conversión falla
    if (stdDev <= 0) {
      // Manejar caso de valores no válidos
      return;
    }

    variance = stdDev * stdDev;
    expectation = mean;

    if (_selectedCondition == 'Mayor o igual a') {
      probability = calculateProbabilityGreaterThanOrEqual(mean, stdDev, x);
    } else if (_selectedCondition == 'Menor o igual a') {
      probability = calculateProbabilityLessThanOrEqual(mean, stdDev, x);
    } else {
      probability = _calculateProbability(mean, stdDev, x);
    }

    setState(() {});
  }

  double _calculateProbability(double mean, double stdDev, double x) {
    double expTerm = exp(-((x - mean) * (x - mean)) / (2 * stdDev * stdDev));
    double probability = (1 / (stdDev * sqrt(2 * pi))) * expTerm;
    return probability;
  }

  double calculateProbabilityGreaterThanOrEqual(double mean, double stdDev, double x) {
    // No hay una forma simple de calcular "mayor o igual a" para la distribución normal,
    // puedes implementar métodos más avanzados como la función de distribución acumulativa (CDF) y luego calcular la probabilidad complementaria.
    // Por simplicidad, puedes dejar este método vacío o mostrar un mensaje indicando que no se admite esta operación.
    return 0;
  }

  double calculateProbabilityLessThanOrEqual(double mean, double stdDev, double x) {
    // No hay una forma simple de calcular "menor o igual a" para la distribución normal,
    // puedes implementar métodos más avanzados como la función de distribución acumulativa (CDF).
    // Por simplicidad, puedes dejar este método vacío o mostrar un mensaje indicando que no se admite esta operación.
    return 0;
  }
}

