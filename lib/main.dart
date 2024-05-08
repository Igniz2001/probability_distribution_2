import 'package:flutter/material.dart';
import 'package:probability_distribution_2/binomial_distribution_page.dart';
import 'package:probability_distribution_2/chisquare_distribution.dart';
import 'package:probability_distribution_2/exponential_distribution.dart';
import 'package:probability_distribution_2/poisson_distribution_page.dart';
import 'package:probability_distribution_2/normal_distribution_page.dart';
import 'package:probability_distribution_2/tstudent_distribution.dart';

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
        '/exponential': (context) => ExponentialDistributionPage(),
        '/chisquare': (context) => ChiSquareDistributionPage(),
        '/tstudent': (context) => StudentTDistributionPage()
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
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/exponential');
              },
              child: Text('Distribución Exponencial'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/chisquare');
              },
              child: Text('Distribución Chi Cuadrada'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/tstudent');
              },
              child: Text('Distribución T-Student'),
            )
          ],
        ),
      ),
    );
  }
}
