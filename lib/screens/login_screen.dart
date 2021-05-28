import 'package:logafic/routing/router_names.dart';
import 'package:toast/toast.dart';
import 'package:flutter/material.dart';
import 'package:logafic/utils/authentication.dart';
import 'package:logafic/widgets/background.dart';

class LoginScreen extends StatefulWidget {
  _LoginScreenState createState() => _LoginScreenState();
}

Future<String> success;

class _LoginScreenState extends State<LoginScreen> {
  //Form
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _emailController;
  TextEditingController _passController;

  //Validation
  final FocusNode _emailFocusNode = FocusNode();

  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passController = TextEditingController();
  }

  void dispose() {
    _emailController.dispose();
    _passController.dispose();
    super.dispose();
  }

  void showToast(String msg, int duration, {int gravity}) {
    Toast.show(msg, context, duration: duration, gravity: gravity);
  }

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
              color: Colors.black,
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
                  color: Colors.black,
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
              child: FlatButton(
                child: Text(
                  'Kayıt Ol',
                  style: TextStyle(
                      color: Colors.black,
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
              height: 300,
              child: Card(
                color: Theme.of(context).cardColor,
                clipBehavior: Clip.antiAlias,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
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
                    Padding(
                      padding: EdgeInsets.all(8),
                      child: SizedBox(
                          width: 400,
                          child: TextFormField(
                            controller: _emailController,
                            decoration: const InputDecoration(
                                icon: Icon(Icons.mail),
                                hintText: ('Mail adresi'),
                                labelText: ('Email')),
                            validator: _validateEmail,
                            autofocus: true,
                            focusNode: _emailFocusNode,
                          )),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8),
                      child: SizedBox(
                        width: 400,
                        child: TextFormField(
                          controller: _passController,
                          obscureText: true,
                          decoration: const InputDecoration(
                              icon: Icon(Icons.vpn_key),
                              hintText: ('Şifre'),
                              labelText: ('Şifre')),
                          validator: _validatePassword,
                        ),
                      ),
                    ),
                    Padding(
                        padding: EdgeInsets.all(8),
                        child: SizedBox(
                          width: 200,
                          height: 50,
                          child: FlatButton(
                              color: Colors.blue[300],
                              child: Text(
                                'Giriş Yap',
                                style: TextStyle(
                                    fontSize: 25,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400),
                              ),
                              onPressed: () async {
                                if (_formKey.currentState.validate()) {
                                  try {
                                    signInWithEmailPassword(
                                            _emailController.text,
                                            _passController.text)
                                        .then(
                                      (value) {
                                        value == null
                                            ? showToast(
                                                'E-mail veya şifre yanlış.', 1)
                                            : {
                                                Navigator.pushNamed(
                                                    context, HomeRoute),
                                                showToast('Giriş Yapıldı', 1)
                                              };
                                      },
                                    );
                                  } catch (e) {
                                    showToast(e.toString(), 3);
                                  }
                                }
                              }),
                        ))
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

  String _validateEmail(String email) {
    RegExp regex = RegExp(r'\w+@\w+\.\w+');
    if (email.isEmpty || !regex.hasMatch(email)) _emailFocusNode.requestFocus();
    if (email.isEmpty)
      return 'Bir e-posta adresine ihtiyacımız var';
    else if (!regex.hasMatch(email))
      return "Bu bir e-posta adresine benzemiyor";
    else
      return null;
  }

  String _validatePassword(String pass1) {
    if (!RegExp(r'.{8,}').hasMatch(pass1))
      return 'Şifreler en az 8 karakter içermelidir';
    return null;
  }
}
