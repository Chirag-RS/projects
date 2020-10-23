// ignore: avoid_web_libraries_in_flutter

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: "Simple Calculator",
    home: SI(),
    theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.brown,
        accentColor: Colors.yellow),
  ));
}

class SI extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SIstate();
  }
}

class _SIstate extends State<SI> {
  var _formKey = GlobalKey<FormState>();
  var currency = ["Rupees", "Dollars", "Pounds"];
  var _currencySelected = 'Rupees';
  TextEditingController principalController = TextEditingController();
  TextEditingController roiController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  var displayResult = '';

  @override
  Widget build(BuildContext context) {
    TextStyle textstyle = Theme.of(context).textTheme.title;

    return Scaffold(
        resizeToAvoidBottomPadding: false,
        appBar: AppBar(title: Text("SI CALCULATOR")),
        body: Form(
            key: _formKey,
            child: ListView(children: <Widget>[
              getImage(),
              Padding(
                  padding: EdgeInsets.only(top: 5.0, bottom: 5.0, left: 5.0),
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    style: textstyle,
                    controller: principalController,
                    validator: (String value) {
                      if (value.isEmpty) {
                        return 'Please Enter Principal Amount';
                      }
                    },
                    decoration: InputDecoration(
                        labelText: "Principal",
                        hintText: "Enter Pricipal. e.g 5000",
                        labelStyle: textstyle,
                        errorStyle: TextStyle(
                          color: Colors.amberAccent,
                          fontSize: 15.0
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        )),
                  )),
              Padding(
                  padding: EdgeInsets.only(top: 5.0, bottom: 5.0, left: 5.0),
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    style: textstyle,
                    controller: roiController,
                    validator: (String value)
                    {
                      if(value.isEmpty)
                        {
                          return 'Please Enter Rate';
                        }
                    },
                    decoration: InputDecoration(
                        labelText: "Rate of Interest",
                        hintText: "Rate in %",
                        labelStyle: textstyle,
                        errorStyle: TextStyle(
                            color: Colors.amberAccent,
                            fontSize: 15.0
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        )),
                  )),
              Padding(
                padding: EdgeInsets.only(top: 5.0, bottom: 5.0, left: 5.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                        child: TextFormField(
                      keyboardType: TextInputType.number,
                      style: textstyle,
                      controller: timeController,
                      validator: (String value) {
                        if (value.isEmpty) {
                          return 'Please enter TIme';
                        }
                      },
                      decoration: InputDecoration(
                          labelText: "Time",
                          hintText: "In Years",
                          labelStyle: textstyle,
                          errorStyle: TextStyle(
                              color: Colors.amberAccent,
                              fontSize: 15.0
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          )),
                    )),
                    Container(
                      width: 20.0,
                    ),
                    Expanded(
                        child: DropdownButton<String>(
                      items: currency.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      value: _currencySelected,
                      onChanged: (String newValue) {
                        _dropdownSelected(newValue);
                      },
                    ))
                  ],
                ),
              ),
              Padding(
                  padding: EdgeInsets.only(top: 5.0, bottom: 5.0, left: 5.0),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                          child: RaisedButton(
                        color: Theme.of(context).accentColor,
                        textColor: Theme.of(context).primaryColorLight,
                        child: Text("Calculate"),
                        onPressed: () {
                          setState(() {
                            if(_formKey.currentState.validate()) {
                              this.displayResult = _simpleInterest();
                            }
                          });
                        },
                      )),
                      Expanded(
                          child: RaisedButton(
                        color: Theme.of(context).primaryColorDark,
                        textColor: Theme.of(context).accentColor,
                        child: Text("Clear"),
                        onPressed: () {
                          setState(() {
                            _reset();
                          });
                        },
                      ))
                    ],
                  )),
              Padding(
                padding: EdgeInsets.all(10.0),
                child: Text(this.displayResult),
              )
            ])));
  }

  Widget getImage() {
    AssetImage assetImage = AssetImage("images/money.jpg");
    Image image = Image(
      image: assetImage,
      width: 125.0,
      height: 125.0,
    );
    return Center(
        child: Container(
      child: image,
    ));
  }

  void _dropdownSelected(String newValue) {
    setState(() {
      this._currencySelected = newValue;
    });
  }

  String _simpleInterest() {
    double principal = double.parse(principalController.text);
    double rate = double.parse(roiController.text);
    double time = double.parse(timeController.text);
    double amount = principal + (principal * rate * time) / 100;
    String result =
        "After $time years, the total amount payable is $amount $_currencySelected";
    return result;
  }

  void _reset() {
    principalController.text = '';
    roiController.text = '';
    timeController.text = '';
    displayResult = '';
    _currencySelected = currency[0];
  }
}
