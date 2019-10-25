import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:gasapp/widgets/logo.widget.dart';
import 'package:gasapp/widgets/submit-form.widget.dart';
import 'package:gasapp/widgets/sucess.widget.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Color _color = Colors.deepPurple;
  var _gasCtrl = new MoneyMaskedTextController();
  var _alcCtrl = new MoneyMaskedTextController();
  var _busy = false;
  var _completed = false;
  var _resultText = "Compensa utilizar Etanol";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: AnimatedContainer(
          duration: Duration(milliseconds: 1200),
          color: _color,
          child: ListView(
            children: <Widget>[
              Logo(),
              _completed
                  ? Success(
                      reset: reset,
                      result: _resultText,
                    )
                  : SubmitForm(
                      alcCtrl: _alcCtrl,
                      gasCtrl: _gasCtrl,
                      busy: _busy,
                      submitFunc: calculate,
                    ),
            ],
          ),
        ));
  }

  Future calculate() {
    double alc =
        double.parse(_alcCtrl.text.replaceAll(new RegExp(r'[,.]'), '')) / 100;
    double gas =
        double.parse(_gasCtrl.text.replaceAll(new RegExp(r'[,.]'), '')) / 100;
    double res = alc / gas;

    // if (gas == 0 || alc == 0) {
    //   return new Future.delayed(const Duration(milliseconds: 50), () {
    //     setState(() {
    //       _completed = true;
    //       _busy = false;
    //     });
    //   });
    // }

    setState(() {
      _completed = false;
      _busy = true;
      _color = Colors.deepPurpleAccent;
    });

    return new Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        if (res >= 0.7) {
          _resultText = "Compensa utilizar Gasolina";
        } else {
          _resultText = "Compensa utilizar Etanol";
        }

        _completed = true;
        _busy = false;
      });
    });
  }

  reset() {
    setState(() {
      _alcCtrl = new MoneyMaskedTextController();
      _gasCtrl = new MoneyMaskedTextController();
      _completed = false;
      _busy = false;
      _color = Theme.of(context).primaryColor;
    });
  }
}
