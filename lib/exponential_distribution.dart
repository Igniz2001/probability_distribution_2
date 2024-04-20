import 'package:flutter/material.dart';
import 'dart:math';

class ExponentialDistributionPage extends StatefulWidget {
  @override
  _ExponentialDistributionPageState createState() =>
      _ExponentialDistributionPageState();
}

class _ExponentialDistributionPageState
    extends State<ExponentialDistributionPage> {
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
        title: Text('Distribución Exponencial'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              controller: lambdaController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Valor de lambda'),
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
            Text('Varianza = 1 / lambda^2'),
            Text('Esperanza = 1 / lambda'),
            Text('Probabilidad = 1 - e^(-lambda * x)'),
          ],
        ),
      ),
    );
  }

  void calculateResults() {
    double lambda = double.tryParse(lambdaController.text) ??
        0.0; // Proporciona valor predeterminado si la conversión falla
    double x = double.tryParse(xController.text) ??
        0.0; // Proporciona valor predeterminado si la conversión falla
    if (lambda <= 0 || x < 0) {
      // Manejar caso de valores no válidos
      return;
    }

    variance = 1 / (lambda * lambda);
    expectation = 1 / lambda;

    if (_selectedCondition == 'Mayor o igual a') {
      probability = 1 - exp(-lambda * x);
    } else if (_selectedCondition == 'Menor o igual a') {
      probability = exp(-lambda * x);
    } else {
      // Calcular probabilidad para igual a x no tiene sentido en una distribución exponencial,
      // ya que la probabilidad de que una variable continua sea exactamente igual a un valor específico es casi siempre cero.
      // Puedes manejar este caso según tus necesidades.
    }

    setState(() {});
  }
}
