import 'package:flutter/material.dart';
import 'dart:math';
import 'package:charts_flutter/flutter.dart' as charts;

class BinomialDistributionPage extends StatefulWidget {
  @override
  _BinomialDistributionPageState createState() =>
      _BinomialDistributionPageState();
}

class _BinomialDistributionPageState extends State<BinomialDistributionPage> {
  TextEditingController nController = TextEditingController();
  TextEditingController pController = TextEditingController();
  TextEditingController xController = TextEditingController();
  String? _selectedCondition; // Cambiado a tipo nullable
  double variance = 0;
  double expectation = 0;
  double probability = 0;

  List<Point<double>> getData() {
    int n = int.tryParse(nController.text) ?? 0;
    double p = double.tryParse(pController.text) ?? 0.0;
    List<Point<double>> data = [];
    for (int i = 0; i <= n; i++) {
      double probability = _calculateProbability(n, p, i);
      data.add(Point(i.toDouble(), probability));
    }
    return data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Distribución Binomial'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: nController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Valor de n'),
              ),
              TextFormField(
                controller: pController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Valor de p'),
              ),
              TextFormField(
                controller: xController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Valor de x'),
              ),
              DropdownButton<String>(
                hint: const Text('Seleccione la condición'),
                value: _selectedCondition,
                onChanged: (String? value) {
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
                child: const Text('Calcular'),
              ),
              const SizedBox(height: 20),
              const Text('Resultados:'),
              Text('Varianza: $variance'),
              Text('Esperanza: $expectation'),
              Text('Probabilidad: $probability'),
              const SizedBox(height: 20),
              Container(
                height: 300,  // Asegúrate de darle una altura a tu gráfico
                child: HistogramChart(data: getData()),
              ),
              const SizedBox(height: 20),
              const Text('Fórmulas:'),
              const Text('Varianza = n * p * (1 - p)'),
              const Text('Esperanza = n * p'),
              const Text('Probabilidad = (nCx) * p^x * (1 - p)^(n-x)'),
            ],
          ),
        ),
      ),
    );
  }

  void calculateResults() {
    int n = int.tryParse(nController.text) ??
        0; // Proporciona valor predeterminado si la conversión falla
    double p = double.tryParse(pController.text) ??
        0.0; // Proporciona valor predeterminado si la conversión falla
    int x = int.tryParse(xController.text) ??
        0; // Proporciona valor predeterminado si la conversión falla
    if (n <= 0 || p <= 0 || p >= 1 || x < 0 || x > n) {
      // Manejar caso de valores no válidos
      return;
    }

    variance = n * p * (1 - p);
    expectation = n * p;

    if (_selectedCondition == 'Mayor o igual a') {
      probability = calculateProbabilityGreaterThanOrEqual(n, p, x);
    } else if (_selectedCondition == 'Menor o igual a') {
      probability = calculateProbabilityLessThanOrEqual(n, p, x);
    } else {
      probability = _calculateProbability(n, p, x);
    }

    setState(() {});
  }

  double _calculateProbability(int n, double p, int x) {
    int nCx = _binomialCoefficient(n, x);
    double probability =
        nCx.toDouble() * pow(p, x) * pow(1 - p.toDouble(), n - x);
    return probability;
  }

  double calculateProbabilityGreaterThanOrEqual(int n, double p, int x) {
    double probability = 0;
    for (int i = x; i <= n; i++) {
      probability += _calculateProbability(n, p, i);
    }
    return probability;
  }

  double calculateProbabilityLessThanOrEqual(int n, double p, int x) {
    double probability = 0;
    for (int i = 0; i <= x; i++) {
      probability += _calculateProbability(n, p, i);
    }
    return probability;
  }

  int _binomialCoefficient(int n, int k) {
    int result = 1;
    for (int i = 1; i <= k; i++) {
      result *= (n - i + 1);
      result ~/= i;
    }
    return result;
  }
}

class HistogramChart extends StatelessWidget {
  final List<Point<double>> data;

  HistogramChart({required this.data});

  @override
  Widget build(BuildContext context) {
    List<charts.Series<Point<double>, String>> series = [
      charts.Series(
        id: 'Probability',
        domainFn: (Point<double> point, _) => point.x.toInt().toString(),
        measureFn: (Point<double> point, _) => point.y,
        data: data,
      ),
    ];

    return charts.BarChart(
      series,
      animate: true,
      vertical: false,  // Esto hace que el gráfico sea un histograma
    );
  }
}


