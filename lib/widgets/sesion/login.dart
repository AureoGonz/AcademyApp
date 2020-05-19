import 'package:academyapp/services/form_validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreen createState() => _LoginScreen();
}

class _LoginScreen extends State<LoginScreen> {
  bool _obscurePW = true;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Inicio de sesión')),
      body: Padding(
        padding: EdgeInsets.all(32),
        child: Form(
          autovalidate: _autoValidate,
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextFormField(
                  validator: FormValidator.validateEmail,
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (value) => null,
                  decoration: InputDecoration(
                      hintText: 'ejemplo@unete.org',
                      labelText: 'Correo',
                      filled: true,
                      border: const UnderlineInputBorder())),
              SizedBox(
                height: 25,
              ),
              TextFormField(
                validator: FormValidator.validatePassword,
                autocorrect: false,
                obscureText: _obscurePW,
                onChanged: (value) => null,
                decoration: InputDecoration(
                    labelText: 'Contraseña',
                    hintText: "********",
                    filled: true,
                    border: const UnderlineInputBorder(),
                    suffix: GestureDetector(
                      dragStartBehavior: DragStartBehavior.down,
                      onTap: () {
                        setState(() {
                          _obscurePW = !_obscurePW;
                          print(_obscurePW);
                        });
                      },
                      child: Icon(
                          _obscurePW ? Icons.visibility : Icons.visibility_off),
                    )),
              ),
              SizedBox(
                height: 40,
              ),
              ButtonBar(
                alignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  FlatButton(onPressed: () {}, child: Text('Crear cuenta')),
                  RaisedButton(
                    onPressed: () {
                      _validateLogin();
                    },
                    child: Text('Iniciar sesión'),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  void _validateLogin(){
    if(_formKey.currentState.validate())
      print('inicio valido');
  }
}
