import 'package:flutter/material.dart';
import 'dart:math';

class ChiSquareDistributionPage extends StatefulWidget {
  @override
  _ChiSquareDistributionPageState createState() =>
      _ChiSquareDistributionPageState();
}

class _ChiSquareDistributionPageState extends State<ChiSquareDistributionPage> {
  TextEditingController vController = TextEditingController();
  TextEditingController xController = TextEditingController();
  String? _selectedCondition; // Cambiado a tipo nullable
  double variance = 0;
  double expectation = 0;
  double probability = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Distribución Chi-Cuadrada'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              controller: vController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Grados de libertad (v)'),
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
              items: <String>['Mayor o igual a', 'Menor o igual a', 'Igual a']
                  .map((String value) {
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
            Text('Varianza = 2 * v'),
            Text('Esperanza = v'),
            Text('Probabilidad = P(X <= x)'),
          ],
        ),
      ),
    );
  }

  void calculateResults() {
    double v = double.tryParse(vController.text) ??
        0.0; // Proporciona valor predeterminado si la conversión falla
    double x = double.tryParse(xController.text) ??
        0.0; // Proporciona valor predeterminado si la conversión falla
    if (v <= 0 || x < 0) {
      // Manejar caso de valores no válidos
      return;
    }

    variance = 2 * v;
    expectation = v;

    if (_selectedCondition == 'Mayor o igual a') {
      probability = _chiSquaredCDF(v, x);
    } else if (_selectedCondition == 'Menor o igual a') {
      probability = 1 - _chiSquaredCDF(v, x);
    } else {
      // Puedes manejar este caso según tus necesidades.
    }

    setState(() {});
  }

  // Función para calcular la función de densidad de probabilidad acumulada de la distribución chi-cuadrada
  double _chiSquaredCDF(double v, double x) {
    double term;
    double sum = 0;
    double previous = 0;

    for (int k = 0; k <= v.toInt() / 2 - 1; k++) {
      term = pow(x / 2, k) * exp(-x / 2) / _factorial(k);
      sum += term;
      if ((sum - previous).abs() < 1e-15) break; // Converge
      previous = sum;
    }

    return 1 - sum;
  }

  // Función para calcular el factorial
  double _factorial(int n) {
    if (n <= 0) return 1;
    double result = 1;
    for (int i = 2; i <= n; i++) {
      result *= i;
    }
    return result;
  }
}
