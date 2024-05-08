import 'package:flutter/material.dart';
import 'package:probability_distribution_2/binomial_distribution_page.dart';
import 'package:probability_distribution_2/poisson_distribution_page.dart';
import 'package:probability_distribution_2/normal_distribution_page.dart';

void main() {
  runApp(DistributionApp());
}

class DistributionApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Distribuciones de Probabilidad',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => DistributionSelectionPage(),
        '/binomial': (context) => BinomialDistributionPage(),
        '/poisson': (context) => PoissonDistributionPage(),
        '/normal': (context) => NormalDistributionPage(),
      },
    );
  }
}

class DistributionSelectionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Seleccionar Distribución'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/binomial');
              },
              child: const Text('Distribución Binomial'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/poisson');
              },
              child: const Text('Distribución de Poisson'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/normal');
              },
              child: const Text('Distribución Normal'),
            ),
          ],
        ),
      ),
    );
  }
}
