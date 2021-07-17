import 'package:logafic/controllers/authController.dart';
import 'package:logafic/data_model/user_profile_model.dart';
import 'package:logafic/widgets/background.dart';
import 'dart:async';
import 'dart:io' as io;
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserInformation extends StatefulWidget {
  UserInformation({Key? key}) : super(key: key);

  @override
  _UserInformationState createState() => _UserInformationState();
}

enum UploadType {
  /// Uploads a file from the device.
  profileFile,
  bannerFile,
}

class _UserInformationState extends State<UserInformation> {
  final String defaultProfileImage =
      'https://firebasestorage.googleapis.com/v0/b/logafic-7911f.appspot.com/o/defaultProfile%2FdefaultProfileImage.png?alt=media&token=a52d30db-14ed-4d68-a94b-e518c893f5a5';

  final String defaultBannerImage =
      'https://firebasestorage.googleapis.com/v0/b/logafic-7911f.appspot.com/o/defaultProfile%2FdefaultBannerImage.jpg?alt=media&token=ca4a7d8c-7f89-4929-b541-3096073c0470';

  AuthController authController = AuthController.to;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController dateCtl = TextEditingController();

  final FocusNode _emailFocusNode = FocusNode();

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  DateTime? dateTime;
  PickedFile? _fileProfileImage;
  PickedFile? _fileBannerImage;

  /// Enum representing the upload task types the example app supports.

  final ImagePicker _picker = ImagePicker();

  String dropdownCity = 'Şehir';
  String dropdownGender = 'Cinsiyet';
  String? _birthday;
  TextEditingController? _userName;
  TextEditingController? _university;
  TextEditingController? _department;
  TextEditingController? _webSite;
  TextEditingController? _linkedin;
  TextEditingController? _twitter;
  TextEditingController? _instagram;
  TextEditingController? _biography;
  void initState() {
    _userName = new TextEditingController();
    _university = new TextEditingController();
    _department = new TextEditingController();
    _webSite = new TextEditingController();
    _linkedin = new TextEditingController();
    _twitter = new TextEditingController();
    _instagram = new TextEditingController();
    _biography = new TextEditingController();

    super.initState();
  }

  void dispose() {
    _userName!.dispose();
    _university!.dispose();
    _department!.dispose();
    _webSite!.dispose();
    _linkedin!.dispose();
    _twitter!.dispose();
    _biography!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;
    final body = new Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text(
            'Profilinizi birlikte tamamlayalım.',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.transparent,
        ),
        body: _userInfoForm);
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

  Widget get _dropdownCity {
    return DropdownButton<String>(
      value: dropdownCity,
      underline: Container(
        height: 2,
        color: Colors.black26,
      ),
      onChanged: (String? newValue) {
        setState(() {
          dropdownCity = newValue!;
        });
      },
      items: <String>['Şehir', 'İstanbul', 'İzmir', 'Ankara', 'Balıkesir']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }

  Widget get _dropdownGender {
    return DropdownButton<String>(
      value: dropdownGender,
      underline: Container(
        height: 2,
        color: Colors.black26,
      ),
      onChanged: (String? newValue) {
        setState(() {
          dropdownGender = newValue!;
        });
      },
      items: <String>['Cinsiyet', 'Erkek', 'Kadın', 'Belirtmek istemiyorum']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }

  Widget get _userInfoForm {
    return Form(
      key: _formKey,
      child: Center(
          child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.6,
        child: Scrollbar(
          child: ListView(
            children: <Widget>[
              Padding(
                  padding: EdgeInsets.all(2),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.all(Radius.circular(10.0)), // Şekil
                        gradient: LinearGradient(
                            // Gradiant renk düzenleme başlangıcı
                            colors: [Colors.black45, Colors.black12],
                            begin: Alignment.topCenter,
                            end: Alignment
                                .bottomCenter)), // Gradiant renk düzenleme bitişi
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        _fileProfileImage == null
                            ? Text('Profile fotoğrafı eklemek ister misin?..')
                            : Center(
                                child: SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.2,
                                    child: Image.network(
                                        _fileProfileImage!.path))),
                        PopupMenuButton<UploadType>(
                            onSelected: handleUploadType,
                            icon: const Icon(Icons.photo_album_outlined),
                            itemBuilder: (context) => [
                                  const PopupMenuItem(
                                      // ignore: sort_child_properties_last
                                      child: Text('Ekle'),
                                      value: UploadType.profileFile),
                                ])
                      ],
                    ),
                  )),
              Padding(
                padding: EdgeInsets.all(2),
                child: Container(
                    decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.all(Radius.circular(10.0)), // Şekil
                        gradient: LinearGradient(
                            // Gradiant renk düzenleme başlangıcı
                            colors: [Colors.black45, Colors.black12],
                            begin: Alignment.topCenter,
                            end: Alignment
                                .bottomCenter)), // Gradiant renk düzenleme bitişi
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          _fileBannerImage == null
                              ? Text('Arka plan fotoğrafı eklemek ister misin?')
                              : Center(
                                  child: SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.2,
                                      child: Image.network(
                                          _fileBannerImage!.path))),
                          PopupMenuButton<UploadType>(
                              onSelected: handleUploadType,
                              icon: const Icon(Icons.photo_album_outlined),
                              itemBuilder: (context) => [
                                    const PopupMenuItem(
                                        child: Text('Ekle'),
                                        value: UploadType.bannerFile),
                                  ])
                        ],
                      ),
                    )),
              ),
              Padding(
                padding: EdgeInsets.all(3),
                child: TextFormField(
                  controller: _userName,
                  decoration: InputDecoration(labelText: 'Kullanıcı Adınız *'),
                  validator: _validateEmptyString,
                  focusNode: _emailFocusNode,
                ),
              ),
              TextFormField(
                controller: _university,
                decoration: InputDecoration(labelText: 'Üniversite *'),
                validator: _validateEmptyString,
              ),
              TextFormField(
                controller: _department,
                decoration: InputDecoration(labelText: 'Bölüm *'),
                validator: _validateEmptyString,
              ),
              _dropdownGender,
              _dropdownCity,
              TextFormField(
                controller: _webSite,
                decoration: InputDecoration(labelText: 'Web Site'),
              ),
              TextField(
                controller: _linkedin,
                decoration: InputDecoration(labelText: 'Linkedin'),
              ),
              TextField(
                controller: _twitter,
                decoration: InputDecoration(labelText: 'Twitter'),
              ),
              TextField(
                controller: _instagram,
                decoration: InputDecoration(labelText: 'Instagram'),
              ),
              TextFormField(
                controller: dateCtl,
                decoration: InputDecoration(
                  labelText: "Doğum tarihi *",
                ),
                validator: _validateEmptyString,
                onTap: () async {
                  try {
                    DateTime? date = DateTime(1900);
                    FocusScope.of(context).requestFocus(new FocusNode());

                    date = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1900),
                        lastDate: DateTime(2100));
                    _birthday = "${date!.day}.${date.month}.${date.year}";
                    dateCtl.text = "${date.day}.${date.month}.${date.year}";
                  } catch (Err) {
                    print(Err);
                  }
                },
              ),
              TextField(
                controller: _biography,
                decoration: InputDecoration(labelText: 'Biyografi'),
                minLines: 2,
                maxLines: 10,
                keyboardType: TextInputType.multiline,
              ),
              Padding(
                padding: EdgeInsets.only(top: 25, bottom: 25),
                child: ElevatedButton.icon(
                  icon: Icon(Icons.save_alt_outlined, size: 18),
                  label: Text("KAYDET"),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      String profileRef = '';
                      String bannerRef = '';
                      if (authController.firebaseUser.value!.uid.isNotEmpty) {
                        _fileProfileImage != null
                            ? profileRef =
                                await uploadFile(_fileProfileImage!, 'profile')
                            // ignore: unnecessary_statements
                            : '';
                        Duration(seconds: 1);
                        _fileBannerImage != null
                            ? bannerRef =
                                await uploadFile(_fileBannerImage!, 'banner')
                            // ignore: unnecessary_statements
                            : '';
                        Duration(seconds: 1);
                        UserProfile? userProfile = UserProfile();
                        userProfile.userEmail =
                            authController.firebaseUser.value!.email;
                        userProfile.userId =
                            authController.firebaseUser.value!.uid;
                        userProfile.userName = _userName!.value.text != ''
                            ? _userName!.value.text
                            : '';
                        userProfile.universty = _university!.value.text != ''
                            ? _university!.value.text
                            : '';

                        userProfile.department = _department!.value.text != ''
                            ? _department!.value.text
                            : '';

                        userProfile.gender = dropdownGender;
                        userProfile.city = dropdownCity;
                        userProfile.webSite = _webSite!.value.text != ''
                            ? _webSite!.value.text
                            : '';

                        userProfile.linkedin = _linkedin!.value.text != ''
                            ? _linkedin!.value.text
                            : '';

                        userProfile.twitter = _twitter!.value.text != ''
                            ? _twitter!.value.text
                            : '';

                        userProfile.instagram = _instagram!.value.text != ''
                            ? _instagram!.value.text
                            : '';

                        userProfile.birtday = _birthday = _birthday!;
                        userProfile.biograpfy = _biography!.value.text != ''
                            ? _biography!.value.text
                            : '';

                        userProfile.userProfileImage =
                            profileRef != '' ? profileRef : defaultProfileImage;

                        userProfile.userBackImage =
                            bannerRef != '' ? bannerRef : defaultBannerImage;
                        userProfile.isAdmin = false;

                        authController.createUserFirestore(
                            userProfile, authController.firebaseUser.value!);
                        authController.newUser = false;
                      } else {
                        Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }

  String? _validateEmptyString(String? email) {
    RegExp regex = RegExp(r'\w+@\w+\.\w+');
    if (email!.isEmpty || !regex.hasMatch(email))
      _emailFocusNode.requestFocus();
    if (email.isEmpty) return 'Bu alanı boş bırakamazsınız.';
  }

  Future<String> uploadFile(PickedFile file, String imageName) async {
    try {
      // Create a Reference to the file
      firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance
          .ref()
          .child('users')
          .child('${authController.firebaseUser.value!.uid}-$imageName.jpg');
      final metadata = firebase_storage.SettableMetadata(
          contentType: 'image/jpeg',
          customMetadata: {'picked-file-path': file.path});

      if (kIsWeb) {
        await ref.putData(await file.readAsBytes(), metadata);
      } else {
        await ref.putFile(io.File(file.path), metadata);
      }
      return await ref.getDownloadURL();
    } catch (err) {
      print(err);
    }
    return '';
  }

  Future<void>? handleUploadType(UploadType type) async {
    switch (type) {
      case UploadType.profileFile:
        try {
          final file = await _picker.getImage(source: ImageSource.gallery);
          setState(() {
            _fileProfileImage = file!;
          });
        } catch (Err) {
          print(Err);
        }
        break;
      case UploadType.bannerFile:
        try {
          final file = await _picker.getImage(source: ImageSource.gallery);
          setState(() {
            _fileBannerImage = file!;
          });
        } catch (Err) {
          print(Err);
        }
        break;
    }
  }
}
