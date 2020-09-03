import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:flutter/services.dart';
void main() {

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.orange,
        secondaryHeaderColor: Colors.red,
      ),
      home: Home(),
    );
  }
}
class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown
    ]);
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.blueGrey[800],
        body: Column(
          children: [
            Container(
              alignment: Alignment.centerRight,
              height: MediaQuery
                  .of( context )
                  .size
                  .height *0.15,
              child: Text(equation,style: TextStyle(
                fontSize: equationFontSize,
                color: Colors.white
              ),),

            ),
              Container(
                alignment: Alignment.centerRight,
                height: MediaQuery
                    .of( context )
                    .size
                    .height * 0.15,
                child: Text(result,style: TextStyle(
                  fontSize: resultFontSize,
                  color: Colors.white,
                ),),

            ),
            Expanded(
              child: Container(
//                width: double.infinity,
              height:MediaQuery.of(context).size.height*0.70,
                child: Column(
                  children: [

                    Padding(
                      padding: EdgeInsets.all(5),
                      child: Row(
                        children: [
                          buttons( "AC",Colors.orange),
                          buttons( "⌫", Colors.orange),
                          buttons( "%" ,Colors.orange),
                          buttons( "÷",Colors.orange),
                        ],
                      ),
                    ),//
                    Padding(
                      padding: EdgeInsets.all(5),
                      child: Row(
                        children: [
                          buttons( "7",Colors.grey[400]),
                          buttons( "8" ,Colors.grey[400]),
                          buttons( "9" ,Colors.grey[400]),
                          buttons( "×" ,Colors.orange),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(5),
                     child: Row(
                        children: [
                          buttons( "4",Colors.grey[400]),
                          buttons( "5" ,Colors.grey[400]),
                          buttons( "6",Colors.grey[400]),
                          buttons( "-",Colors.orange ),
                        ],
                      ),
                    ),
//
                    Padding(
                      padding: EdgeInsets.all(5),
                      child: Row(
                        children: [
                          buttons( "1",Colors.grey[400] ),
                          buttons( "2",Colors.grey[400] ),
                          buttons( "3" ,Colors.grey[400]),
                          buttons( "+" ,Colors.orange),
                        ],
                      ),
                    ),
//
                    Padding(
                      padding: EdgeInsets.all(5),
                      child: Row(
                        children: [
                          buttons( "00",Colors.grey[400] ),
                          buttons( "0" ,Colors.grey[400]),
                          buttons( ".",Colors.grey[400] ),
                          buttons( "=" ,Colors.orange),
                        ],
                      ),
                    ),
                  ],
                ),

              ),
            )
          ],
        ),
      ),
    );
  }
  Widget buttons(String usertext,Color color) {
    return Expanded(
      child: RawMaterialButton(
        onPressed: () {
          btnclick(usertext);
        },
        fillColor: color,
        shape: CircleBorder( ),
        child: Container(
          padding: EdgeInsets.all(8.0),
          height: MediaQuery.of(context).size.height*0.1,
          child: Text( usertext, style: TextStyle(
            fontSize: 40.0,
            fontWeight: FontWeight.bold,
          ), ),
        ),
        padding: EdgeInsets.all( 3.0 ),
      ),
    );
  }
  String equation="0";
  String result="0";
  String expression ="";
  double equationFontSize= 48.0;
  double resultFontSize = 35.0;
  void btnclick(String t) {
    setState(() {
      if(t=="AC"){
          equation = "0";
          result = "0";
         equationFontSize= 48.0;
         resultFontSize = 32.0;
      }
      else if(t=="⌫"){
         equationFontSize= 48.0;
         resultFontSize = 32.0;
          equation = equation.substring(0,equation.length-1);
          if(equation == ""){
            equation = "0";
          }
      }
      else if(t=="="){
        equationFontSize= 32.0;
        resultFontSize = 48.0;
        expression = equation;
        expression = expression.replaceAll('÷', '/');
        expression = expression.replaceAll('×', '*');
        try{
          Parser p=new Parser();
          Expression exp=p.parse(expression);
          ContextModel cm= ContextModel();
          result = '${exp.evaluate(EvaluationType.REAL, cm)}';
        }
        catch (e){
          result = "Error";
        }

      }
      else{
        if(equation == "0"){
          equation = t;
        }
        else{
          equation = equation+t;
          equationFontSize= 48.0;
          resultFontSize = 32.0;
        }
      }
    });
  }

}