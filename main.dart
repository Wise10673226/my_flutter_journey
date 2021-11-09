import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(Calculator());
}

class Calculator extends StatelessWidget {
  const Calculator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Wises Calculator',
      theme: ThemeData(primarySwatch: Colors.blueGrey),
      home: SimpleCalculator(),
    );
  }
}

class SimpleCalculator extends StatefulWidget {
  const SimpleCalculator({Key? key}) : super(key: key);

  @override
  _SimpleCalculatorState createState() => _SimpleCalculatorState();
}

class _SimpleCalculatorState extends State<SimpleCalculator> {
  String equation = "0";
  String result = "0";
  String expression = "";
  double equationFontSize = 28.0;
  double resultFontSize = 38.0;

  buttonPressed(String buttonText) {
    setState(() {
      if (buttonText == "C") {
        equation = "0";
        result = "0";
        equationFontSize = 28.0;
        resultFontSize = 38.0;
      } else if (buttonText == "<-") {
        equationFontSize = 38.0;
        resultFontSize = 28.0;
        equation = equation.substring(0, equation.length - 1);
        if (equation == "0") {
          equation = "0";
        }
      } else if (buttonText == "=") {
        equationFontSize = 28.0;
        resultFontSize = 38.0;

        expression = equation;
        expression = expression.replaceAll('×', '*');
        expression = expression.replaceAll('÷', '/');

        try {
          Parser p = Parser();
          Expression exp = p.parse(expression);

          ContextModel cm = ContextModel();
          result = '${exp.evaluate(EvaluationType.REAL, cm)}';
        } catch (e) {
          result = "Error";
        }
      } else {
        equationFontSize = 38.0;
        resultFontSize = 28.0;
        if (equation == "0") {
          equation = buttonText;
        } else {
          equation = equation + buttonText;
        }
      }
    });
  }

  Widget biuldButton(
    String buttonText,
    double buttonHeight,
    Color buttoncolor,
  ) {
    return Container(
        height: MediaQuery.of(context).size.height * 0.1 * buttonHeight,
        color: buttoncolor,
        child: FlatButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(0.0),
              side: BorderSide(
                  color: Colors.white, width: 1, style: BorderStyle.solid),
            ),
            padding: EdgeInsets.all(16.0),
            onPressed: () => buttonPressed(buttonText),
            child: Text(
              buttonText,
              style: TextStyle(
                  fontSize: 30.0,
                  fontWeight: FontWeight.normal,
                  color: Colors.white),
            )));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Wises Calculator')),
      body: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
            child: Text(
              equation,
              style: TextStyle(fontSize: equationFontSize),
            ),
          ),
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.fromLTRB(10, 30, 10, 0),
            child: Text(
              result,
              style: TextStyle(fontSize: resultFontSize),
            ),
          ),
          Expanded(
            child: Divider(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                  width: MediaQuery.of(context).size.width * .75,
                  child: Table(
                    children: [
                      //first table row
                      TableRow(children: [
                        biuldButton("C", 1.2, Colors.red),
                        biuldButton("<-", 1.2, Colors.blueGrey),
                        biuldButton("÷", 1.2, Colors.red),
                      ]),
                      //second table row
                      TableRow(children: [
                        biuldButton("7", 1.2, Colors.black54),
                        biuldButton("8", 1.2, Colors.black54),
                        biuldButton("9", 1.2, Colors.black54),
                      ]),
                      TableRow(children: [
                        biuldButton("4", 1.2, Colors.black54),
                        biuldButton("5", 1.2, Colors.black54),
                        biuldButton("6", 1.2, Colors.black54),
                      ]),
                      TableRow(children: [
                        biuldButton("1", 1.2, Colors.black54),
                        biuldButton("2", 1.2, Colors.black54),
                        biuldButton("3", 1.2, Colors.black54),
                      ]),
                      TableRow(children: [
                        biuldButton(".", 1.2, Colors.black54),
                        biuldButton("0", 1.2, Colors.black54),
                        biuldButton("00", 1.2, Colors.black54),
                      ]),
                    ],
                  )),
              Container(
                width: MediaQuery.of(context).size.width * 0.25,
                child: Table(
                  children: [
                    TableRow(children: [
                      biuldButton("×", 1.2, Colors.blueGrey),
                    ]),
                    TableRow(children: [
                      biuldButton("-", 1.2, Colors.blueGrey),
                    ]),
                    TableRow(children: [
                      biuldButton("+", 1.2, Colors.blueGrey),
                    ]),
                    TableRow(children: [
                      biuldButton("=", 2.4, Colors.red),
                    ])
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
