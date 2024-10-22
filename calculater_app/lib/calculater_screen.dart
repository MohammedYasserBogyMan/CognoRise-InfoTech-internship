import 'package:calculater_app/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> symbols = [
    'C',
    'Del',
    '%',
    '/',
    '9',
    '8',
    '7',
    '*',
    '6',
    '5',
    '4',
    '+',
    '3',
    '2',
    '1',
    '-',
    '.',
    '0',
    'Ans',
    '=',
  ];
  String input = '';
  String output = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text('Calculator'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              margin: const EdgeInsets.all(5),
              width: double.infinity,
              child: Text(
                input,
                textAlign: TextAlign.left,
                style: const TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.w400,
                    color: Colors.black),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              margin: const EdgeInsets.all(5),
              width: double.infinity,
              child: Text(
                output,
                textAlign: TextAlign.right,
                style: TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.w400,
                    color: Colors.redAccent.shade100),
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: GridView.builder(
              itemCount: symbols.length,
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
              ),
              itemBuilder: (context, index) {
                return CustomButton(
                  symbol: symbols[index],
                  backgroundColor: myBackgroundColor(symbols[index]),
                  textColor: myTextColor(symbols[index]),
                  onTap: () => handleTap(symbols[index]),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void handleTap(String symbol) {
    setState(() {
      if (symbol == 'C') {
        input = '';
        output = '';
      } else if (symbol == 'Del') {
        input = input.isNotEmpty ? input.substring(0, input.length - 1) : '';
      } else if (symbol == 'Ans') {
        input = output;
        output = '';
      } else if (['%', '/', '*', '+', '-'].contains(symbol)) {
        if (!input.endsWith(symbol)) {
          input += symbol;
        }
      } else if (symbol == '=') {
        try {
          Expression exp = Parser().parse(input);
          double result = exp.evaluate(EvaluationType.REAL, ContextModel());
          output = result.toString();
        } catch (e) {
          output = 'Error';
        }
      } else {
        input += symbol;
      }
    });
  }

  Color myBackgroundColor(String x) {
    if (x == 'C') {
      return Colors.teal.shade300;
    } else if (x == 'Del') {
      return Colors.redAccent.shade100;
    } else if (['%', '/', '+', '*', '-', '='].contains(x)) {
      return Colors.blue.shade400;
    } else {
      return Colors.grey.shade300;
    }
  }

  Color myTextColor(String x) {
    if (['C', '%', 'Del', '/', '+', '*', '-', '='].contains(x)) {
      return Colors.white;
    } else {
      return Colors.black;
    }
  }
}
