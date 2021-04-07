import 'package:flutter/material.dart';
import 'package:logafic/routing/router_names.dart';
import 'package:logafic/utils/authentication.dart';
import 'package:toast/toast.dart';

bool _sozlesme = false;

class RegisterScreen extends StatefulWidget {
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _emailController;
  TextEditingController _passController;
  TextEditingController _passConfirmationController;
  TextEditingController _eduMailController;
//Validation
  final FocusNode _emailFocusNode = FocusNode();
  bool _agree = false;

  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passController = TextEditingController();
    _passConfirmationController = TextEditingController();
    _eduMailController = TextEditingController();
  }

  void dispose() {
    _emailController.dispose();
    _passController.dispose();
    _passConfirmationController.dispose();
    _eduMailController.dispose();
    super.dispose();
  }

  void showToast(String msg, int duration, {int gravity}) {
    Toast.show(msg, context, duration: duration, gravity: gravity);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
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
                  'Giriş Yap',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 17,
                      fontWeight: FontWeight.w500),
                ),
                onPressed: () {
                  Navigator.pushNamed(context, LoginRoute);
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
              height: 800,
              child: Card(
                color: Colors.white,
                clipBehavior: Clip.antiAlias,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(8),
                      child: SizedBox(
                        child: Text(
                          "Logafic'e kayıt ol",
                          style: TextStyle(
                              color: Colors.grey[400],
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
                              hintText: ('Geçerli bir mail adresi giriniz.'),
                              labelText: ('*Email')),
                          autofocus: true,
                          validator: _validateEmail,
                          focusNode: _emailFocusNode,
                        ),
                      ),
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
                              hintText: ('Geçerli bir şifre giriniz.'),
                              labelText: ('*Şifre')),
                          validator: _validatePassword,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8),
                      child: SizedBox(
                        width: 400,
                        child: TextFormField(
                          controller: _passConfirmationController,
                          obscureText: true,
                          decoration: const InputDecoration(
                              icon: Icon(Icons.vpn_key_outlined),
                              hintText: ('Şifreyi tekrar giriniz.'),
                              labelText: ('*Tekrar Şifre')),
                          validator: _validatePasswordConfirmation,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8),
                      child: SizedBox(
                        width: 400,
                        child: TextFormField(
                          controller: _eduMailController,
                          decoration: const InputDecoration(
                              icon: Icon(Icons.mail_outline),
                              hintText: ('Email adresi .edu uzantılı'),
                              labelText: ('*Okul mail adresi')),
                          validator: _validateEmail,
                        ),
                      ),
                    ),
                    _buildAgreeToTermsField,
                    Padding(
                        padding: EdgeInsets.all(8),
                        child: SizedBox(
                          width: 200,
                          height: 50,
                          child: FlatButton(
                            color: Colors.lightGreen[200],
                            child: Text(
                              'Kayıt Ol',
                              style: TextStyle(
                                  fontSize: 25,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w400),
                            ),
                            onPressed: () {
                              try {
                                if (_formKey.currentState.validate()) {
                                  registerWithEmailPassword(
                                      _emailController.text,
                                      _passController.text);
                                  showToast("Logafic'e hoşgeldiniz :)", 1);
                                  Navigator.pushNamed(
                                      context, UserInformationRoute);
                                } else {
                                  print('Hata var!');
                                }
                              } catch (e) {
                                print(e);
                              }
                            },
                          ),
                        ))
                  ],
                ),
              ),
            ),
          ),
        ));
  }

  Widget get _buildAgreeToTermsField {
    // TODO 8: Wrap the Column with a FormField<bool>
    return FormField<bool>(
      // 1
      initialValue: _agree,
      builder: (FormFieldState<bool> state) {
        // 2
        return Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Checkbox(
                  // 3
                  value: state.value,
                  onChanged: (bool val) => setState(() {
                    // 4
                    _agree = val;
                    // 5
                    state.didChange(val);
                  }),
                ),
                const Text("Kullanıcı şözleşmesini  kabul ediyorum."),
              ],
            ),
            // 6
            state.errorText == null
                ? Text("")
                : Text(state.errorText, style: TextStyle(color: Colors.red)),
          ],
        );
      },
      // 7
      validator: (val) => _validateTerms(_agree),
    );
  }

  String _validateEmail(String email) {
    // 1
    RegExp regex = RegExp(r'\w+@\w+\.\w+');
    // Add the following line to set focus to the email field
    if (email.isEmpty || !regex.hasMatch(email)) _emailFocusNode.requestFocus();
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

  String _validatePassword(String pass1) {
    RegExp hasUpper = RegExp(r'[A-Z]');
    RegExp hasLower = RegExp(r'[a-z]');
    RegExp hasDigit = RegExp(r'\d');
    if (!RegExp(r'.{8,}').hasMatch(pass1))
      return 'Şifreler en az 8 karakter içermelidir';
    if (!hasUpper.hasMatch(pass1))
      return 'Parolalar en az bir büyük harf içermelidir';
    if (!hasLower.hasMatch(pass1))
      return 'Parolalar en az bir küçük harf içermelidir';
    if (!hasDigit.hasMatch(pass1))
      return 'Parolalar en az bir rakam içermelidir';
    return null;
  }

  String _validatePasswordConfirmation(String pass2) {
    return (_passController.value.text ==
            _passConfirmationController.value.text)
        ? null
        : "İki şifre eşleşmelidir";
    // Note that _pass1 is populated when a password is entered
  }

  String _validateTerms(bool agree) {
    return agree ? null : "Kullanıcı şözleşmesini kabul etmelisiniz !";
    // It's invalid if the user hasn't opted in by checking the box
  }
}
