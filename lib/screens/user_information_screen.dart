import 'dart:html';

import 'package:flutter/material.dart';

class UserInformation extends StatefulWidget {
  UserInformation({Key key}) : super(key: key);

  @override
  _UserInformationState createState() => _UserInformationState();
}

class _UserInformationState extends State<UserInformation> {
  TextEditingController dateCtl = TextEditingController();
  File _imageFile;
  String dropdownCity = 'Şehir';
  String dropdownGender = 'Cinsiyet';
  TextEditingController _userName;
  TextEditingController _university;
  TextEditingController _department;
  TextEditingController _webSite;
  TextEditingController _linkedin;
  TextEditingController _twitter;
  TextEditingController _instagram;
  TextEditingController _biography;
  void initState() {
    super.initState();
    _userName = new TextEditingController();
    _university = new TextEditingController();
    _department = new TextEditingController();
    _webSite = new TextEditingController();
    _linkedin = new TextEditingController();
    _twitter = new TextEditingController();
    _instagram = new TextEditingController();
    _biography = new TextEditingController();
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
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Profilinizi birlikte tamamlayalım.',
            style: TextStyle(color: Colors.black54),
          ),
          backgroundColor: Colors.white,
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
        ),
        body: Center(
            child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.6,
          child: Scrollbar(
            child: ListView(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(8),
                  child: Container(
                    height: 200,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(30.0),
                            bottomRight: Radius.circular(30.0)),
                        gradient: LinearGradient(
                            colors: [Colors.black45, Colors.black12],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter)),
                    child: Center(
                      child: OutlinedButton.icon(
                        icon: Icon(
                          Icons.photo_library_sharp,
                          color: Colors.white,
                        ),
                        label: Text(
                          'Arka Plan Fotoğrafı',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () {},
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(2),
                  child: Container(
                    width: 50,
                    height: 200,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(30.0),
                            bottomRight: Radius.circular(30.0)),
                        gradient: LinearGradient(
                            colors: [Colors.black45, Colors.black12],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter)),
                    child: Center(
                      child: OutlinedButton.icon(
                        icon: Icon(
                          Icons.photo_library_sharp,
                          color: Colors.white,
                        ),
                        label: Text(
                          'Profil Fotoğrafı',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () {},
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(3),
                  child: TextField(
                    controller: _userName,
                    decoration: InputDecoration(labelText: 'Kullanıcı Adınız'),
                  ),
                ),
                TextField(
                  controller: _university,
                  decoration: InputDecoration(labelText: 'Üniversite'),
                ),
                TextField(
                  controller: _department,
                  decoration: InputDecoration(labelText: 'Bölüm'),
                ),
                _dropdownGender,
                _dropdownCity,
                TextField(
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
                    DateTime date = DateTime(1900);
                    FocusScope.of(context).requestFocus(new FocusNode());

                    date = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1900),
                        lastDate: DateTime(2100));

                    dateCtl.text = "${date.day}.${date.month}.${date.year}";
                  },
                ),
                TextField(
                  controller: _biography,
                  decoration: InputDecoration(labelText: 'Biyografi'),
                  minLines: 3,
                  maxLines: 10,
                  keyboardType: TextInputType.multiline,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 25, bottom: 25),
                  child: ElevatedButton.icon(
                    icon: Icon(Icons.save_alt_outlined, size: 18),
                    label: Text("KAYDET"),
                    onPressed: () {},
                  ),
                )
              ],
            ),
          ),
        )));
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
}
