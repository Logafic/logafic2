import 'package:flutter/material.dart';
import 'package:logafic/controllers/authController.dart';
import 'package:logafic/routing/router_names.dart';
import 'package:logafic/helpers/validate.dart';
import 'package:logafic/widgets/FormInputFieldWithIcon.dart';
import 'package:logafic/widgets/background.dart';
import 'package:logafic/widgets/formVerticalSpacing.dart';
import 'package:logafic/widgets/primaryButton.dart';

class RegisterScreen extends StatefulWidget {
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  AuthController authController = AuthController.to;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController? _emailController;
  TextEditingController? _passController;
  TextEditingController? _passConfirmationController;
  TextEditingController? _eduMailController;
//Validation
  bool _agree = false;

  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passController = TextEditingController();
    _passConfirmationController = TextEditingController();
    _eduMailController = TextEditingController();
  }

  void dispose() {
    _emailController!.dispose();
    _passController!.dispose();
    _passConfirmationController!.dispose();
    _eduMailController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;
    final body = new Scaffold(
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
                  'Giriş Yap',
                  style: TextStyle(
                      color: Colors.white,
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
              child: Card(
                clipBehavior: Clip.antiAlias,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(8),
                      child: Text(
                        "Logafic'e kayıt ol",
                        style: TextStyle(
                            color: Colors.black54,
                            fontSize: 23,
                            fontFamily: 'Montserrat'),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 20, right: 20),
                      child: FormInputFieldWithIcon(
                          controller: authController.emailController,
                          iconPrefix: Icons.email,
                          labelText: 'Email adresi',
                          validator: HelpersValidate().validateEmail,
                          obscureText: false,
                          onChanged: (value) => null,
                          onSaved: (value) {
                            authController.emailController.text = value!;
                          }),
                    ),
                    FormVerticalSpace(),
                    Padding(
                      padding: EdgeInsets.only(left: 20, right: 20),
                      child: FormInputFieldWithIcon(
                          controller: authController.passwordController,
                          iconPrefix: Icons.password,
                          labelText: 'Şifre',
                          validator: HelpersValidate().validatePassword,
                          obscureText: true,
                          maxLines: 1,
                          onChanged: (value) => null,
                          onSaved: (value) {
                            authController.emailController.text = value!;
                          }),
                    ),
                    FormVerticalSpace(),
                    Padding(
                      padding: EdgeInsets.only(left: 20, right: 20),
                      child: FormInputFieldWithIcon(
                          controller: _eduMailController!,
                          iconPrefix: Icons.cast_for_education,
                          labelText: 'Okul email',
                          validator: HelpersValidate().validateEmail,
                          obscureText: false,
                          onChanged: (value) => null,
                          onSaved: (value) {}),
                    ),
                    FormVerticalSpace(),
                    _buildAgreeToTermsField,
                    PrimaryButton(
                        labelText: 'Kayıt Ol',
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            try {
                              authController.newUser = true;
                              authController
                                  .registerWithEmailAndPassword(context);
                            } catch (err) {
                              print(err);
                            }
                          }
                        }),
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
            body,
          ],
        ));
  }

  Widget get _buildAgreeToTermsField {
    return FormField<bool>(
      // 1
      initialValue: _agree,
      builder: (FormFieldState<bool>? state) {
        // 2
        return Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Checkbox(
                  // 3
                  value: state!.value,
                  onChanged: (bool? val) => setState(() {
                    // 4
                    _agree = val!;
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
                : Text(state.errorText!, style: TextStyle(color: Colors.red)),
          ],
        );
      },
      // 7
      validator: (val) => HelpersValidate().validateTerms(_agree),
    );
  }
}
