import 'package:flutter/material.dart';
import 'dart:math';

class StudentTDistributionPage extends StatefulWidget {
  @override
  _StudentTDistributionPageState createState() =>
      _StudentTDistributionPageState();
}

class _StudentTDistributionPageState extends State<StudentTDistributionPage> {
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
        title: Text('Distribución T de Student'),
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
            Text('Varianza = v / (v - 2)'),
            Text('Esperanza = 0 si v > 1, indefinido si v <= 1'),
            Text('Probabilidad = P(X <= x)'),
          ],
        ),
      ),
    );
  }

  void calculateResults() {
    int v = int.tryParse(vController.text) ??
        0; // Proporciona valor predeterminado si la conversión falla
    double x = double.tryParse(xController.text) ??
        0.0; // Proporciona valor predeterminado si la conversión falla
    if (v <= 0 || x.isNaN) {
      // Manejar caso de valores no válidos
      return;
    }

    variance = v / (v - 2);
    expectation = v > 1 ? 0 : double.nan;

    if (_selectedCondition == 'Mayor o igual a') {
      probability = _studentTCDF(v, x);
    } else if (_selectedCondition == 'Menor o igual a') {
      probability = 1 - _studentTCDF(v, x);
    } else {
      // Puedes manejar este caso según tus necesidades.
    }

    setState(() {});
  }

  // Función para calcular la función de densidad de probabilidad acumulada de la distribución T de Student
  double _studentTCDF(int v, double x) {
    double integral =
        _simpsonIntegration((t) => _studentTPDF(v, t), 0, x, 1000);
    return 0.5 + integral / 2;
  }

  // Función para calcular la función de densidad de probabilidad de la distribución T de Student
  double _studentTPDF(int v, double x) {
    double numerator = _gamma((v + 1) / 2);
    double denominator =
        sqrt(v * pi) * _gamma(v / 2) * pow(1 + pow(x, 2) / v, -(v + 1) / 2);
    return numerator / denominator;
  }

  // Función gamma
  double _gamma(double x) {
    const List<double> p = [
      0.99999999999980993,
      676.5203681218851,
      -1259.1392167224028,
      771.32342877765313,
      -176.61502916214059,
      12.507343278686905,
      -0.13857109526572012,
      9.9843695780195716e-6,
      1.5056327351493116e-7
    ];

    if (x < 0.5) {
      return pi / (sin(pi * x) * _gamma(1 - x));
    }

    x -= 1;
    double y = p[0];
    for (int i = 1; i < p.length; i++) {
      y += p[i] / (x + i);
    }

    double t = x + p.length - 0.5;
    return sqrt(2 * pi) * pow(t, x + 0.5) * exp(-t) * y;
  }

  // Función de integración de Simpson
  double _simpsonIntegration(Function(double) f, double a, double b, int n) {
    double h = (b - a) / n;
    double sum = f(a) + f(b);
    for (int i = 1; i < n; i++) {
      double x = a + h * i;
      sum += 2 * (i.isEven ? 2 : 4) * f(x);
    }
    return sum * h / 3;
  }
}
