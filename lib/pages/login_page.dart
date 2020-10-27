import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_chat/blocs/auth_bloc/auth_bloc.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Login Page",
                style: TextStyle(fontSize: 20),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                decoration: InputDecoration(
                    labelText: "Email address",
                    labelStyle: TextStyle(color: Colors.black54),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black54, width: 1),
                        borderRadius: BorderRadius.circular(10)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black87, width: 1),
                        borderRadius: BorderRadius.circular(10))),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                decoration: InputDecoration(
                    labelText: "Password",
                    labelStyle: TextStyle(color: Colors.black54),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black54, width: 1),
                        borderRadius: BorderRadius.circular(10)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black87, width: 1),
                        borderRadius: BorderRadius.circular(10))),
              ),
              const SizedBox(
                height: 20,
              ),
              FlatButton(
                  onPressed: () {},
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  color: Colors.blue,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  child: const Text(
                    "Log In",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  )),
              const SizedBox(
                height: 10,
              ),
              Container(
                height: 20,
                child: Row(
                  children: const <Widget>[
                    Expanded(
                      child: Divider(
                        color: Colors.black54,
                        thickness: 0.8,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 18),
                      child: Text(
                        "or",
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        color: Colors.black54,
                        thickness: 0.8,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              FlatButton(
                  onPressed: () {
                    context.bloc<AuthBloc>().add(GoogleLoginAuthEvent());
                  },
                  padding:
                      const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                  color: Colors.green,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  child: const Text(
                    "Login with Google",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
