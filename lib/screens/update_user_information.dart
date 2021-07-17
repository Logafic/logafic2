import 'package:logafic/controllers/authController.dart';
import 'package:logafic/data_model/user_profile_model.dart';
import 'package:logafic/routing/router_names.dart';
import 'package:logafic/widgets/background.dart';
import 'dart:async';
import 'dart:io' as io;
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UpdateUserInformation extends StatefulWidget {
  final String userId;
  UpdateUserInformation({Key? key, required this.userId}) : super(key: key);

  @override
  _UpdateUserInformationState createState() => _UpdateUserInformationState();
}

enum UploadType {
  /// Uploads a file from the device.
  profileFile,
  bannerFile,
}

class _UpdateUserInformationState extends State<UpdateUserInformation> {
  AuthController authController = AuthController.to;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController dateCtl = TextEditingController();
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  DateTime? dateTime;
  PickedFile? _fileProfileImage;
  PickedFile? _fileBannerImage;
  bool isLoading = false;

  /// Enum representing the upload task types the example app supports.

  final ImagePicker _picker = ImagePicker();

  String? dropdownCity;
  String? dropdownGender;
  String? _birthday;
  String? urlProfileImage;
  String? urlBannerImage;
  TextEditingController _userName = TextEditingController();
  TextEditingController _university = TextEditingController();
  TextEditingController _department = TextEditingController();
  TextEditingController _webSite = TextEditingController();
  TextEditingController _linkedin = TextEditingController();
  TextEditingController _twitter = TextEditingController();
  TextEditingController _instagram = TextEditingController();
  TextEditingController _biography = TextEditingController();

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
            'Profilinizi birlikte güncelleyelim..',
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
                  // ÇIkmak istediğinize emin misiniz diye sorsun.
                  Navigator.pop(context);
                },
              );
            },
          ),
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
    return FutureBuilder<DocumentSnapshot>(
        future: firestore.collection('users').doc(widget.userId).get(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            Map<String, dynamic> data =
                snapshot.data!.data() as Map<String, dynamic>;
            urlProfileImage = data['userProfileImage'];
            urlBannerImage = data['userBackImage'];
            _userName.text = data['userName'];
            _university.text = data['universty'];
            _department.text = data['department'];
            _biography.text = data['biograpfy'];
            _birthday = data['birtday'];
            dropdownCity = data['city'];
            dropdownGender = data['gender'];
            dateCtl.text = data['birtday'];

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
                                    ? SizedBox(
                                        width: 200,
                                        height: 200,
                                        child: Image.network(urlProfileImage!),
                                      )
                                    : Center(
                                        child: SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.2,
                                            child: Image.network(
                                                _fileProfileImage!.path))),
                                PopupMenuButton<UploadType>(
                                    onSelected: handleUploadType,
                                    icon:
                                        const Icon(Icons.photo_album_outlined),
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
                                      ? SizedBox(
                                          width: 200,
                                          height: 200,
                                          child: Image.network(urlBannerImage!),
                                        )
                                      : Center(
                                          child: SizedBox(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.2,
                                              child: Image.network(
                                                  _fileBannerImage!.path))),
                                  PopupMenuButton<UploadType>(
                                      onSelected: handleUploadType,
                                      icon: const Icon(
                                          Icons.photo_album_outlined),
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
                          enabled: false,
                          controller: _userName,
                          decoration:
                              InputDecoration(labelText: 'Kullanıcı Adınız'),
                        ),
                      ),
                      TextFormField(
                        controller: _university,
                        decoration: InputDecoration(labelText: 'Üniversite'),
                      ),
                      TextFormField(
                        controller: _department,
                        decoration: InputDecoration(labelText: 'Bölüm'),
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
                        onTap: () async {
                          try {
                            DateTime? date = DateTime(1900);
                            FocusScope.of(context)
                                .requestFocus(new FocusNode());
                            date = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(1900),
                                lastDate: DateTime(2100));
                            _birthday =
                                "${date!.day}.${date.month}.${date.year}";
                            dateCtl.text =
                                "${date.day}.${date.month}.${date.year}";
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
                            label: Text("GÜNCELLE"),
                            onPressed: () async {
                              if (authController
                                  .firebaseUser.value!.uid.isNotEmpty) {
                                UserProfile? userProfile = UserProfile();
                                if (_fileProfileImage != null) {
                                  String profileRef = await uploadFile(
                                      _fileProfileImage!, 'profile');
                                  userProfile.userProfileImage = profileRef;
                                } else {
                                  userProfile.userProfileImage = urlBannerImage;
                                }
                                Duration(seconds: 1);
                                if (_fileBannerImage != null) {
                                  String bannerRef = await uploadFile(
                                      _fileBannerImage!, 'banner');
                                  userProfile.userBackImage = bannerRef;
                                } else {
                                  userProfile.userBackImage = urlBannerImage;
                                }
                                Duration(seconds: 1);
                                userProfile.userEmail = data['email'];
                                userProfile.userId = data['userId'];
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
                                isLoading = true;

                                firestore
                                    .collection('users')
                                    .doc(widget.userId)
                                    .update(userProfile.toJson())
                                    .then((value) {
                                  isLoading
                                      ? Center(
                                          child: CircularProgressIndicator(),
                                        )
                                      : Navigator.pushNamed(
                                          context, ProfileRoute,
                                          arguments: {'userId': widget.userId});
                                });
                              } else {
                                Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                            }),
                      ),
                    ],
                  ),
                ),
              )),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        });
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
