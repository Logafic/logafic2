import 'package:logafic/routing/router_names.dart';
import 'package:flutter/material.dart';
import 'package:logafic/controllers/authController.dart';
import 'package:logafic/widgets/background.dart';
import 'package:logafic/widgets/labelButton.dart';
import 'package:logafic/widgets/primaryButton.dart';
import 'package:logafic/widgets/formInputFieldWithIcon.dart';
import 'package:logafic/widgets/formVerticalSpacing.dart';

class LoginScreen extends StatefulWidget {
  _LoginScreenState createState() => _LoginScreenState();
}

Future<String>? success;

class _LoginScreenState extends State<LoginScreen> {
  //Form
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  //Validation
  final FocusNode _emailFocusNode = FocusNode();
  final AuthController authController = AuthController.to;
  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;
    final boyd = new Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Text(
            'LOGAFIC',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.w400,
              letterSpacing: 3,
            ),
          ),
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              );
            },
          ),
          actions: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: TextButton(
                child: Text(
                  'Kayıt Ol',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.w500),
                ),
                onPressed: () {
                  Navigator.pushNamed(context, RegisterRoute);
                },
              ),
            )
          ],
        ),
        body: Form(
          key: _formKey,
          child: Container(
            alignment: Alignment.center,
            child: SizedBox(
              width: 500,
              height: 400,
              child: Card(
                color: Theme.of(context).cardColor,
                clipBehavior: Clip.antiAlias,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(8),
                      child: SizedBox(
                        child: Text(
                          "Logafic'e giriş yap",
                          style: TextStyle(
                              color: Colors.black54,
                              fontSize: 23,
                              fontFamily: 'Montserrat'),
                        ),
                      ),
                    ),
                    FormInputFieldWithIcon(
                        controller: authController.emailController,
                        iconPrefix: Icons.email,
                        labelText: 'Email',
                        obscureText: false,
                        validator: _validateEmail,
                        keyboardType: TextInputType.emailAddress,
                        onChanged: (value) => null,
                        onSaved: (value) =>
                            authController.emailController.text != value),
                    FormVerticalSpace(),
                    FormInputFieldWithIcon(
                        controller: authController.passwordController,
                        iconPrefix: Icons.password,
                        labelText: 'Şifre',
                        validator: _validatePassword,
                        maxLines: 1,
                        obscureText: true,
                        onChanged: (value) => null,
                        onSaved: (value) =>
                            authController.passwordController.text != value),
                    FormVerticalSpace(),
                    PrimaryButton(
                        labelText: 'Giriş Yap',
                        onPressed: () {
                          // if (_formKey.currentState!.validate()) {
                          //   try {
                          //     authController
                          //         .signInWithEmailAndPassword(context);
                          //   } catch (err) {
                          //     print(err);
                          //   }
                          // }
                          authController.emailController.text =
                              'yunus@gmail.com';
                          authController.passwordController.text = 'Merhaba98';
                          authController.signInWithEmailAndPassword(context);
                        }),
                    FormVerticalSpace(),
                    LabelButton(
                        labelText: 'Şifreni mi Unuttun?',
                        onPressed: () {
                          Navigator.pushNamed(context, ResetRoute);
                        })
                  ],
                ),
              ),
            ),
          ),
        ));
    return new Container(
      decoration: new BoxDecoration(
        color: Colors.black26,
      ),
      child: new Stack(
        children: <Widget>[
          new CustomPaint(
            size: new Size(_width, _height),
            painter: new Background(),
          ),
          boyd,
        ],
      ),
    );
  }

  String? _validateEmail(String? email) {
    // 1
    RegExp regex = RegExp(r'\w+@\w+\.\w+');
    // Add the following line to set focus to the email field
    if (email!.isEmpty || !regex.hasMatch(email))
      _emailFocusNode.requestFocus();
    // 2
    if (email.isEmpty)
      return 'Bir e-posta adresine ihtiyacımız var';
    else if (!regex.hasMatch(email))
      // 3
      return "Bu bir e-posta adresine benzemiyor";
    else
      // 4
      return null;
  }

  String? _validatePassword(String? pass1) {
    if (!RegExp(r'.{8,}').hasMatch(pass1!))
      return 'Şifreler en az 8 karakter içermelidir';

    return null;
  }
}
