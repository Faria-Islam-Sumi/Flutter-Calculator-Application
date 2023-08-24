import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main(){
  runApp(Calculator());
}

class Calculator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calculator',
      home: calculator(),
    );
  }
}

class calculator extends StatefulWidget {
  @override
  _calculatorState createState() => _calculatorState();
}

class _calculatorState extends State<calculator> {

  String a = "0";//equation
  String r = "0";//result
  String z = "";//expression
  double aFontSize = 35.0;
  double rFontSize = 45.0;

  buttonPressed(String buttonText){
    setState(() {
      if(buttonText == "c"){
        a = "0";
        r = "0";
      }
      else if(buttonText == "DEL"){
        a = a.substring(0, a.length - 1);
        if(a == ""){
          a= "0";
        }
      }

      else if(buttonText == "="){
        z = a;
        z= z.replaceAll('×', '*');
        z = z.replaceAll('÷', '/');

        try{
          Parser p = Parser();
          Expression exp = p.parse(z);

          ContextModel cm = ContextModel();
          r = '${exp.evaluate(EvaluationType.REAL, cm)}';
        }catch(e){
          r = "Error";
        }
      }

      else{
        if(a == "0"){
          a = buttonText;
        }else {
          a = a + buttonText;
        }
      }
    });
  }

  Widget buildButton(String buttonText, double buttonHeight, Color buttonColor){
    return Container(
      height: MediaQuery.of(context).size.height * 0.1 * buttonHeight,
      color: buttonColor,
      child: TextButton(  // Replace FlatButton with TextButton
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(0.0),
            ),
          ),
        ),
        onPressed: () => buttonPressed(buttonText),
        child: Text(
          buttonText,
          style: const TextStyle(
            fontSize: 30.0,
            fontWeight: FontWeight.normal,
            color: Colors.white,
          ),
        ),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Calculator'),
        leading: IconButton(
          icon: const Icon(Icons.menu), // You can replace 'Icons.menu' with your desired icon
          onPressed: () {
            // Handle the navigation icon press here
            print("Navigation icon pressed");
          },
        ),
        backgroundColor: Colors.black,
        centerTitle: true,
      ),
      body: Container(
        color: Colors.black,
        child: Column(
        children: <Widget>[

          Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.fromLTRB(10, 40, 10, 10),
            child: Text(a, style: TextStyle(fontSize: aFontSize,
                color: Colors.white),),
          ),

          Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.fromLTRB(10, 50, 10, 0),
            child: Text(r, style: TextStyle(fontSize: rFontSize, color: Colors.white),),
          ),

          const Expanded(
            child: Divider(),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width * .75,
                child: Table(
                  children: [
                    TableRow(
                        children: [
                          buildButton("DEL", 1, Colors.black),
                          buildButton("c", 1, Colors.black),
                          buildButton("x", 1, Colors.black),
                        ]
                    ),

                    TableRow(
                        children: [
                          buildButton("(", 1, Colors.black),
                          buildButton(")", 1, Colors.black),
                          buildButton("%", 1, Colors.black),
                        ]
                    ),

                    TableRow(
                        children: [
                          buildButton("1", 1, Colors.black),
                          buildButton("2", 1, Colors.black),
                          buildButton("3", 1, Colors.black),
                        ]
                    ),

                    TableRow(
                        children: [
                          buildButton("4", 1, Colors.black),
                          buildButton("5", 1, Colors.black),
                          buildButton("6", 1, Colors.black),
                        ]
                    ),

                    TableRow(
                        children: [
                          buildButton("7", 1, Colors.black),
                          buildButton("8", 1, Colors.black),
                          buildButton("9", 1, Colors.black),
                        ]
                    ),

                    TableRow(
                        children: [
                          buildButton("0", 1, Colors.black),
                          buildButton("00", 1, Colors.black),
                          buildButton(".", 1, Colors.black),
                        ]
                    ),
                  ],
                ),
              ),

              Container(
                width: MediaQuery.of(context).size.width * 0.25,
                child: Table(
                  children: [
                    TableRow(
                        children: [
                          buildButton("/", 1, Colors.black),
                        ]
                    ),

                    TableRow(
                        children: [
                          buildButton("*", 1, Colors.black),
                        ]
                    ),

                    TableRow(
                        children: [
                          buildButton("-", 1, Colors.black),
                        ]
                    ),

                    TableRow(
                        children: [
                          buildButton("+", 1, Colors.black),
                        ]
                    ),

                    TableRow(
                        children: [
                          buildButton("=", 2, Colors.purple[600]!),
                        ]
                    ),
                  ],
                ),
              )
            ],
          ),

        ],
      ),
      )
    );
  }
}
