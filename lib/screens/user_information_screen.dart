import 'package:logafic/data_model/user_profile_model.dart';
import 'package:logafic/widgets/background.dart';
import 'package:logafic/routing/router_names.dart';
import 'dart:async';
import 'dart:io' as io;
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logafic/utils/authentication.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:toast/toast.dart';

class UserInformation extends StatefulWidget {
  UserInformation({Key key}) : super(key: key);

  @override
  _UserInformationState createState() => _UserInformationState();
}

enum UploadType {
  /// Uploads a file from the device.
  profileFile,
  bannerFile,
  clear,
}

class _UserInformationState extends State<UserInformation> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController dateCtl = TextEditingController();

  final FocusNode _emailFocusNode = FocusNode();

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  List<firebase_storage.UploadTask> _uploadTasks = [];

  DateTime dateTime;
  List<String> imageRef = [];
  PickedFile _fileProfileImage;
  PickedFile _fileBannerImage;
  String _profileUrl;
  String _bannerUrl;

  /// Enum representing the upload task types the example app supports.

  final ImagePicker _picker = ImagePicker();

  String dropdownCity = 'Şehir';
  String dropdownGender = 'Cinsiyet';
  String _birthday;
  TextEditingController _userName;
  TextEditingController _university;
  TextEditingController _department;
  TextEditingController _webSite;
  TextEditingController _linkedin;
  TextEditingController _twitter;
  TextEditingController _instagram;
  TextEditingController _biography;
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
    _userName.dispose();
    _university.dispose();
    _department.dispose();
    _webSite.dispose();
    _linkedin.dispose();
    _twitter.dispose();
    _biography.dispose();
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
        ),
        body: Form(
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
                            borderRadius: BorderRadius.all(
                                Radius.circular(10.0)), // Şekil
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
                                ? Text(
                                    'Profile fotoğrafı eklemek ister misin?..')
                                : Center(
                                    child: SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.2,
                                        child: Image.network(
                                            _fileProfileImage.path))),
                            PopupMenuButton<UploadType>(
                                onSelected: handleUploadType,
                                icon: const Icon(Icons.photo_album_outlined),
                                itemBuilder: (context) => [
                                      const PopupMenuItem(
                                          // ignore: sort_child_properties_last
                                          child: Text('Ekle'),
                                          value: UploadType.profileFile),
                                      if (_uploadTasks.isNotEmpty)
                                        const PopupMenuItem(
                                            // ignore: sort_child_properties_last
                                            child: Text('Clear list'),
                                            value: UploadType.clear)
                                    ])
                          ],
                        ),
                      )),
                  Padding(
                    padding: EdgeInsets.all(2),
                    child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(
                                Radius.circular(10.0)), // Şekil
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
                                  ? Text(
                                      'Arka plan fotoğrafı eklemek ister misin?')
                                  : Center(
                                      child: SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.2,
                                          child: Image.network(
                                              _fileBannerImage.path))),
                              PopupMenuButton<UploadType>(
                                  onSelected: handleUploadType,
                                  icon: const Icon(Icons.photo_album_outlined),
                                  itemBuilder: (context) => [
                                        const PopupMenuItem(
                                            child: Text('Ekle.'),
                                            value: UploadType.bannerFile),
                                        if (_uploadTasks.isNotEmpty)
                                          const PopupMenuItem(
                                              child: Text('Clear list'),
                                              value: UploadType.clear)
                                      ])
                            ],
                          ),
                        )),
                  ),
                  Padding(
                    padding: EdgeInsets.all(3),
                    child: TextFormField(
                      controller: _userName,
                      decoration:
                          InputDecoration(labelText: 'Kullanıcı Adınız'),
                      validator: _validateEmptyString,
                      focusNode: _emailFocusNode,
                    ),
                  ),
                  TextFormField(
                    controller: _university,
                    decoration: InputDecoration(labelText: 'Üniversite'),
                    validator: _validateEmptyString,
                  ),
                  TextFormField(
                    controller: _department,
                    decoration: InputDecoration(labelText: 'Bölüm'),
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
                      labelText: "Doğum tarihi",
                    ),
                    validator: _validateEmptyString,
                    onTap: () async {
                      try {
                        DateTime date = DateTime(1900);
                        FocusScope.of(context).requestFocus(new FocusNode());

                        date = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(1900),
                            lastDate: DateTime(2100));
                        _birthday = "${date.day}.${date.month}.${date.year}";
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
                        if (_formKey.currentState.validate()) {
                          UserProfile userProfile = UserProfile();
                          userProfile.userEmail = userEmail;
                          userProfile.userId = uid;
                          userProfile.userName = _userName.value.text;
                          userProfile.universty = _university.value.text;
                          userProfile.department = _department.value.text;
                          userProfile.gender = dropdownGender;
                          userProfile.city = dropdownCity;
                          userProfile.webSite = _webSite.value.text;
                          userProfile.linkedin = _linkedin.value.text;
                          userProfile.twitter = _twitter.value.text;
                          userProfile.instagram = _instagram.value.text;
                          userProfile.birtday = _birthday;
                          userProfile.biograpfy = _biography.value.text;
                          try {
                            firebase_storage.UploadTask task =
                                await uploadFile(_fileProfileImage, 'Profile');
                            if (task != null) {
                              setState(() {
                                _uploadTasks = [..._uploadTasks, task];
                              });
                            }
                          } catch (Err) {
                            print(Err);
                          }
                          userProfile.userProfileImage = _profileUrl;
                          try {
                            firebase_storage.UploadTask task =
                                await uploadFile(_fileBannerImage, 'Banner');
                            if (task != null) {
                              setState(() {
                                _uploadTasks = [..._uploadTasks, task];
                              });
                            }
                          } catch (Err) {
                            print(Err);
                          }
                          userProfile.userBackImage = _bannerUrl;
                          await addUser(userProfile.toJson()).then((value) =>
                              {Navigator.pushNamed(context, LoginRoute)});
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          )),
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

  Widget get _dropdownCity {
    return DropdownButton<String>(
      value: dropdownCity,
      underline: Container(
        height: 2,
        color: Colors.black26,
      ),
      onChanged: (String newValue) {
        setState(() {
          dropdownCity = newValue;
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
      onChanged: (String newValue) {
        setState(() {
          dropdownGender = newValue;
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

  String _validateEmptyString(String email) {
    RegExp regex = RegExp(r'\w+@\w+\.\w+');
    if (email.isEmpty || !regex.hasMatch(email)) _emailFocusNode.requestFocus();
    if (email.isEmpty)
      return 'Bu alanı boş bırakamazsınız.';
    else
      return null;
  }

  Future<firebase_storage.UploadTask> uploadFile(
      PickedFile file, String imageName) async {
    try {
      if (file == null) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('No file was selected'),
        ));
        return null;
      }

      firebase_storage.UploadTask uploadTask;

      // Create a Reference to the file
      firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance
          .ref('gs://logafic-7911f.appspot.com')
          .child('users')
          .child('$uid-$imageName.jpg');

      if (imageName == 'Profile') {
        _profileUrl = await _downloadLink(ref);
      } else {
        _bannerUrl = await _downloadLink(ref);
      }

      final metadata = firebase_storage.SettableMetadata(
          contentType: 'image/jpeg',
          customMetadata: {'picked-file-path': file.path});

      if (kIsWeb) {
        uploadTask = ref.putData(await file.readAsBytes(), metadata);
      } else {
        uploadTask = ref.putFile(io.File(file.path), metadata);
      }

      return Future.value(uploadTask);
    } catch (err) {
      print(err);
      return null;
    }
  }

  void showToast(String msg, int duration, {int gravity}) {
    Toast.show(msg, context, duration: duration, gravity: gravity);
  }

  Future<void> addUser(Map<String, dynamic> user) async {
    try {
      CollectionReference users =
          FirebaseFirestore.instance.collection('users');
      return users
          .add(user)
          .then((value) => {
                print('Success user added'),
                showToast('Kullanıcı bilgileri başarıyla kayıt edildi', 1)
              })
          .catchError((onError) => showToast(onError, 2));
    } catch (E) {
      showToast(E, 1);
    }
  }

  Future<void> handleUploadType(UploadType type) async {
    switch (type) {
      case UploadType.profileFile:
        try {
          final file = await _picker.getImage(source: ImageSource.gallery);
          setState(() {
            _fileProfileImage = file;
          });
        } catch (Err) {
          print(Err);
        }
        break;
      case UploadType.bannerFile:
        try {
          final file = await _picker.getImage(source: ImageSource.gallery);
          setState(() {
            _fileBannerImage = file;
          });
        } catch (Err) {
          print(Err);
        }
        break;
      case UploadType.clear:
        setState(() {
          _uploadTasks = [];
        });
        break;
    }
  }

  Future<String> _downloadLink(firebase_storage.Reference ref) async {
    try {
      return await ref.getDownloadURL();
    } catch (err) {
      print(err);
    }
  }
}
