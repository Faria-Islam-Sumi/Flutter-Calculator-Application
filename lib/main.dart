import 'package:calculator/colors.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main(){
  runApp(const MaterialApp(
    home: CalculatorApp(),
    title: 'Calculator App',
  ));
}

class CalculatorApp extends StatefulWidget {
  const CalculatorApp({Key? key}) : super(key: key);

  @override
  State<CalculatorApp> createState() => _CalculatorAppState();
}

class _CalculatorAppState extends State<CalculatorApp> {

  //variables
  double firstNum = 0.0;
  double secondNum = 0.0;
  var input = '';
  var output = '';
  var operation = '';
  var hideInput = false;
  var outputSize = 40.0;

  onButtonClick(value) {
    //if value is AC
    if (value == "c") {
      input = '';
      output = '';
    }
    else if (value == "<") {
     if (input.isNotEmpty) {
        input = input.substring(0, input.length - 1);
      }
    }
    else if (value == "=") {
      if (input.isNotEmpty) {
        var userInput = input;
        // userInput = input.replaceAll("x", "*");
        Parser p = Parser();
        Expression expression = p.parse(userInput);
        ContextModel cm = ContextModel();
        var finalValue = expression.evaluate(EvaluationType.REAL, cm);
        output = finalValue.toString();
        //if (output.endsWith(".0")){
        // output = output.substring(0, output.length-2);
        // }
        //input=output;
        hideInput = true;
        outputSize = 52;
      }
    } else {
      input = input + value;
      hideInput = false;
      outputSize = 34;
    }
    setState(() {});
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: AppBar(
          backgroundColor: Colors.transparent, // Set background color to black
          title: const Center(child: Text('Calculator')), // Center-aligned title
          leading: IconButton(
            icon: Icon(Icons.menu), // You can replace 'Icons.menu' with your desired icon
            onPressed: () {
              // Handle the navigation icon press here
              // For example, you can open a drawer or navigate to another screen
              print("Navigation icon pressed");
            },
          ),
        ),
      ),
      backgroundColor: Colors.black,
      body: Column(
        children: [
          //input output area
          Expanded(child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  //hideInput ? '': input,
                  input,
                  style: const TextStyle(
                    fontSize: 34,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(
                  height: 70,
                ),
                Text(
                  output,
                  style: TextStyle(
                    fontSize: outputSize,
                    color: Colors.white.withOpacity(0.7),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
              ],
            ),
          ),
          ),

          //button area
          Row(
            children: [
              button(text: "<"),
              // button(icon: Icons.arrow_downward),
              button(text: "c"),
              button(text: "x"),
              button(text: "/"),
            ],
          ),
          Row(
            children: [
              button(text: "("),
              button(text: ")"),
              button(text: "%"),
              button(text: "*"),
            ],
          ),
          Row(
            children: [
              button(text: "1"),
              button(text: "2"),
              button(text: "3"),
              button(text: "-"),
            ],
          ),
          Row(
            children: [
              button(text: "4"),
              button(text: "5"),
              button(text: "6"),
              button(text: "+"),
            ],
          ),
          Row(
            children: [
              button(text: "7"),
              button(text: "8"),
              button(text: "9"),
              button(text: ""),
            ],
          ),
          Row(
            children: [
              button(text: "0"),
              button(text: "00"),
              button(text: "."),
              button(text: "="),
            ],
          ),
        ],
      ),
    );
  }

  Widget button({
    text, tColor = Colors.white, buttonBgColor = buttonColor
  }) {
    // ...
    // Replace the "<" button with the arrow-down icon
    if (text == "<") {
      return Expanded(
        child: Container(
          margin: const EdgeInsets.all(8),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              padding: const EdgeInsets.all(22),
              primary: buttonBgColor,
            ),
            onPressed: () => onButtonClick(text),
            child: Icon(Icons.keyboard_arrow_down, size: 24,
                color: tColor), // Use the arrow-down icon
          ),
        ),
      );
    } else {
      return Expanded(
          child: Container(
            margin: const EdgeInsets.all(8),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(

               shape: RoundedRectangleBorder(
                   borderRadius: BorderRadius.circular(12)),backgroundColor: buttonBgColor,

                padding: const EdgeInsets.all(22),
              ),
              onPressed: () => onButtonClick(text),
              child: Text(text, style: TextStyle(
                fontSize: 18,
                color: tColor,
                fontWeight: FontWeight.bold,
              ),
              ),
            ),
          )
      );
    }
  }
}