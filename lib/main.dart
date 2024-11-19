import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() => runApp(CalculatorApp());

class CalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CalculatorHome(),
    );
  }
}

class CalculatorHome extends StatefulWidget {
  @override
  _CalculatorHomeState createState() => _CalculatorHomeState();
}

class _CalculatorHomeState extends State<CalculatorHome> {
  String expression = '';
  String result = '';

  void _onButtonPressed(String value) {
    setState(() {
      if (value == 'C') {
        _clear();
      } else if (value == '=') {
        try {
          Parser p = Parser();
          Expression exp = p.parse(expression);
          ContextModel cm = ContextModel();
          result = exp.evaluate(EvaluationType.REAL, cm).toString();
        } catch (e) {
          result = 'Erro';
        }
      } else {
        if (expression.isEmpty && '+-*/'.contains(value)) {
          return;
        }
        expression += value;
      }
    });
  }

  void _clear() {
    setState(() {
      expression = '';
      result = '';
    });
  }

  Widget _buildButton(String value) {
    Color? buttonColor;
    Color textColor = Colors.white; 

    if (value == 'C') {
      buttonColor = Colors.grey[300]; 
      textColor = Colors.grey[800]!; 
    } else if ('+-*/='.contains(value)) {
      buttonColor = Colors.cyan; 
    } else {
      buttonColor = Colors.grey[800]; 
    }

    return Expanded(
      child: Container(
        margin: EdgeInsets.all(4), 
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: buttonColor, 
          ),
          onPressed: () => _onButtonPressed(value),
          child: Text(
            value,
            style: TextStyle(fontSize: 24, color: textColor), 
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Fundo do Scaffold
      appBar: AppBar(
        title: Text('Calculadora'),
        backgroundColor: Colors.grey[900], 
        titleTextStyle: TextStyle(
          color: Colors.white, 
          fontSize: 20,        
        ),
      ),

      body: Padding(
        padding: EdgeInsets.all(16), 
        child: Column(
          children: [
            Expanded(
              child: Container(
                color: Colors.black, 
                padding: EdgeInsets.all(16),
                alignment: Alignment.bottomRight,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      expression,
                      style: TextStyle(fontSize: 32, color: Colors.white),
                    ),
                    SizedBox(height: 16),
                    Text(
                      result,
                      style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold, color: Colors.white), // Cor do resultado
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16), 
            Column(
              children: [
                Row(
                  children: [
                    _buildButton('7'),
                    _buildButton('8'),
                    _buildButton('9'),
                    _buildButton('/'),
                  ],
                ),
                Row(
                  children: [
                    _buildButton('4'),
                    _buildButton('5'),
                    _buildButton('6'),
                    _buildButton('*'),
                  ],
                ),
                Row(
                  children: [
                    _buildButton('1'),
                    _buildButton('2'),
                    _buildButton('3'),
                    _buildButton('-'),
                  ],
                ),
                Row(
                  children: [
                    _buildButton('0'),
                    _buildButton('C'),
                    _buildButton('='),
                    _buildButton('+'),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
