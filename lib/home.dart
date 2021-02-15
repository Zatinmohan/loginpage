import 'package:LoginPage/model/authentication.dart';
import 'package:LoginPage/signup.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class Homepage extends StatelessWidget {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: ListView(shrinkWrap: true, children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 35.0, bottom: 25.0),
                child: SvgPicture.asset('assets/illustration/main.svg',
                    width: 180.0, height: 180.0),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 10.0,
                  bottom: 5.0,
                ),
                child: Text("Welcome!",
                    style: TextStyle(
                      fontSize: 40.0,
                      fontWeight: FontWeight.w400,
                    )),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 18.0),
                child: Text(
                  "Please sign in to continue",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 20.0,
                  ),
                ),
              ),
            ),
            EmailField(emailController: _emailController),
            PasswordField(passwordController: _passwordController),
            ForgetPassword(),
            LoginButton(
                emailController: _emailController,
                passwordController: _passwordController),
            Center(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 20.0),
                child: Text("or log in using",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 15.0,
                      fontWeight: FontWeight.w400,
                    )),
              ),
            ),
            IntrinsicHeight(
              child: Builder(
                builder: (context) => Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon:
                          SvgPicture.asset('assets/illustration/facebook.svg'),
                      onPressed: () {
                        Scaffold.of(context).showSnackBar(
                            SnackBar(content: Text("Comming Soon")));
                      },
                    ),
                    VerticalDivider(
                      color: Colors.grey,
                      thickness: 1,
                      width: 20.0,
                    ),
                    IconButton(
                        icon:
                            SvgPicture.asset('assets/illustration/google.svg'),
                        onPressed: () {
                          Scaffold.of(context).showSnackBar(
                              SnackBar(content: Text("Comming Soon")));
                        }),
                  ],
                ),
              ),
            ),
            SignupText(),
          ]),
        ),
      ),
    );
  }

  // void showFacebookBar(BuildContext context) {
  //   Scaffold.of(context).showSnackBar(SnackBar(
  //     content: Text("Comming Soon"),
  //   ));
  // }
}

class ForgetPassword extends StatelessWidget {
  const ForgetPassword({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(right: 22.0, bottom: 20.0),
      width: double.infinity,
      child: Text(
        "Forget password?",
        style: TextStyle(
            color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 14.0),
        textAlign: TextAlign.right,
      ),
    );
  }
}

class SignupText extends StatelessWidget {
  const SignupText({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20.0),
      child: Center(
        child: RichText(
          text: TextSpan(children: [
            TextSpan(
                text: "Don\'t have an account? ",
                style: TextStyle(color: Colors.black, fontSize: 16.0)),
            TextSpan(
                text: "Sign up",
                style: TextStyle(
                    color: Colors.blue,
                    fontSize: 16.5,
                    fontWeight: FontWeight.w400),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    Navigator.push(
                        context, MaterialPageRoute(builder: (_) => Signup()));
                  }),
          ]),
        ),
      ),
    );
  }
}

class LoginButton extends StatelessWidget {
  const LoginButton({
    Key key,
    @required TextEditingController emailController,
    @required TextEditingController passwordController,
  })  : _emailController = emailController,
        _passwordController = passwordController,
        super(key: key);

  final TextEditingController _emailController;
  final TextEditingController _passwordController;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 90.0),
      height: 55.0,
      child: RaisedButton(
        color: Color(0xff5486f5),
        textColor: Colors.white,
        onPressed: () {
          context.read<AuthenticationService>().signIn(
                email: _emailController.text.trim(),
                password: _passwordController.text.trim(),
              );
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25.0),
        ),
        child: Text(
          "Login",
          style: TextStyle(
            fontSize: 19.0,
          ),
        ),
      ),
    );
  }
}

class PasswordField extends StatelessWidget {
  const PasswordField({
    Key key,
    @required TextEditingController passwordController,
  })  : _passwordController = passwordController,
        super(key: key);

  final TextEditingController _passwordController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 18.0, vertical: 10.0),
      child: TextField(
        controller: _passwordController,
        decoration: InputDecoration(
          labelText: 'Password',
          fillColor: Colors.white,
          border: OutlineInputBorder(
              borderRadius: const BorderRadius.all(Radius.circular(20.0))),
          prefixIcon: Icon(Icons.vpn_key),
        ),
        obscureText: true,
      ),
    );
  }
}

class EmailField extends StatelessWidget {
  const EmailField({
    Key key,
    @required TextEditingController emailController,
  })  : _emailController = emailController,
        super(key: key);

  final TextEditingController _emailController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 18.0, vertical: 10.0),
      child: TextField(
          controller: _emailController,
          decoration: InputDecoration(
            labelText: 'Email',
            fillColor: Colors.white,
            border: OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(20.0))),
            prefixIcon: Icon(Icons.person_outlined),
          )),
    );
  }
}
