import 'package:flutter/material.dart';
import 'package:flutter_application_cordova/page/course_information_page.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class FormRegisClass extends StatefulWidget {
  final String courseId;
  const FormRegisClass({super.key, required this.courseId});

  @override
  State<FormRegisClass> createState() => _FormRegisClassState();
}

class _FormRegisClassState extends State<FormRegisClass> {
  int _value = 1;
  bool seen = false;
  String notifNirValid = '';
  String nama = '';
  String noHp = '';
  String email = '';
  String sumber = '';
  String namaSekolah = '';
  String kelas = '';
  String kodeUnik = '-';
  String url = '';
  bool emailValid = true;

  _launchURL() async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $url';
    }
  }

  void cekValidasi() {
    notifNirValid = '';
    if (nama == '') {
      notifNirValid = 'Mohon isi nama lengkap anda';
      return;
    } else if (noHp == '') {
      notifNirValid = 'Mohon isi nomor telepon anda';
      return;
    } else if (email == '') {
      notifNirValid = 'Mohon isi Alamat email';
      return;
    } else if (noHp.length < 10 || noHp.length > 14) {
      notifNirValid = 'Mohon isi nomor telepon dengan benar';
      return;
    } else if (email.substring(email.length - 4, email.length) != '.com') {
      notifNirValid = 'Mohon isi alamat email dengan benar!';
      return;
    } else if (seen) {
      if (namaSekolah == '') {
        notifNirValid = 'Mohon isi nama sekolah kamu';
        return;
      } else if (kelas == '') {
        notifNirValid = 'Mohon isi kelas / jurusan kamu';
        return;
      }
    }
  }

  void pesanToWhatsApp() {
    if (kelas != '') {
      url = """
https://wa.me/${6282124308812} ?text=
Halo kak, saya $nama ($email).

Saya adalah seorang pelajar di $namaSekolah, kelas $kelas.
Saya tertarik mengikuti Kursus.

Sebelumnya saya mempunyai voucher, voucher saya adalah *$kodeUnik*.

Tolong bantu proses pendaftarannya, ya. Terima kasih!
""";
    } else if (seen == false) {
      if (kodeUnik == '' || kodeUnik == '-') {
        url = """
https://wa.me/${6282124308812} ?text=
Halo kak, saya $nama ($email).

Saya tertarik mengikuti kursus.
Tolong bantu proses pendaftarannya, ya. Terima kasih!
""";
      } else {
        url = """
https://wa.me/${6282124308812} ?text=
Halo kak, saya $nama ($email).

Saya tertarik mengikuti kursus.
Sebelumnya saya mempunyai voucher, voucher saya adalah *$kodeUnik*.

Tolong bantu proses pendaftarannya, ya. Terima kasih!
""";
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    pesanToWhatsApp();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Text(
          'Cordovacourse',
          style: GoogleFonts.roboto(
              textStyle: TextStyle(fontSize: 17, color: Colors.white)),
        ),
        backgroundColor: Color(0xFFEF2D74),
      ),
      resizeToAvoidBottomInset: false,
      body: WillPopScope(
        onWillPop: () async {
          Navigator.of(context).pushReplacement(new MaterialPageRoute(
              builder: (context) =>
                  CourseInformationPage(courseId: widget.courseId)));
          return true;
        },
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          reverse: false,
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 20, bottom: 20, left: 15),
                child: Text(
                  'Data diri',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Color.fromARGB(253, 215, 5, 124)),
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 10, right: 10, left: 10),
                child: TextField(
                  onChanged: ((value) {
                    setState(() {
                      nama = value.toString();
                    });
                  }),
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      fillColor: Color.fromARGB(255, 255, 240, 245),
                      filled: false,
                      labelText: 'Nama lengkap',
                      labelStyle: TextStyle(fontSize: 12),
                      icon: Icon(Icons.person,
                          color: Color.fromARGB(253, 215, 5, 124))),
                ),
              ),
              Container(
                margin: EdgeInsets.all(10),
                child: TextField(
                  onChanged: ((value) {
                    setState(() {
                      noHp = value.toString();
                    });
                  }),
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      fillColor: Color.fromARGB(255, 255, 240, 245),
                      filled: false,
                      labelText: 'Nomor Telepon (WhatsApp)',
                      hintText: '08xxxxxxxx',
                      labelStyle: TextStyle(fontSize: 12),
                      icon: Icon(Icons.phone,
                          color: Color.fromARGB(253, 215, 5, 124))),
                ),
              ),
              Container(
                margin: EdgeInsets.all(10),
                child: TextField(
                  onChanged: ((value) {
                    setState(() {
                      email = value.toString();
                    });
                  }),
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      fillColor: Color.fromARGB(255, 255, 240, 245),
                      filled: false,
                      labelText: 'Alamat Email',
                      labelStyle: TextStyle(fontSize: 12),
                      icon: Icon(Icons.email,
                          color: Color.fromARGB(253, 215, 5, 124))),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                margin: EdgeInsets.only(top: 20, bottom: 20, left: 15),
                child: Text(
                  'Sumber',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Color.fromARGB(253, 215, 5, 124)),
                ),
              ),
              Container(
                child: Row(
                  children: [
                    Radio(
                        activeColor: Color.fromARGB(253, 215, 5, 124),
                        value: 1,
                        groupValue: _value,
                        onChanged: ((value) {
                          setState(() {
                            _value = value!;
                            seen = false;
                            namaSekolah = '';
                            kelas = '';
                          });
                        })),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      'Sosial Media',
                      style: TextStyle(fontSize: 12),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Radio(
                        activeColor: Color.fromARGB(253, 215, 5, 124),
                        value: 2,
                        groupValue: _value,
                        onChanged: ((value) {
                          setState(() {
                            _value = value!;
                            seen = true;
                          });
                        })),
                    SizedBox(
                      width: 3,
                    ),
                    Text(
                      'Sekolah / Universitas',
                      style: TextStyle(fontSize: 12),
                    ),
                  ],
                ),
              ),
              Container(
                child: Row(
                  children: [
                    Radio(
                        activeColor: Color.fromARGB(253, 215, 5, 124),
                        value: 3,
                        groupValue: _value,
                        onChanged: ((value) {
                          setState(() {
                            _value = value!;
                            seen = false;
                            namaSekolah = '';
                            kelas = '';
                          });
                        })),
                    SizedBox(
                      width: 4,
                    ),
                    Text(
                      'Website',
                      style: TextStyle(fontSize: 12),
                    ),
                    Radio(
                        activeColor: Color.fromARGB(253, 215, 5, 124),
                        value: 4,
                        groupValue: _value,
                        onChanged: ((value) {
                          setState(() {
                            _value = value!;
                            seen = false;
                            namaSekolah = '';
                            kelas = '';
                          });
                        })),
                    SizedBox(
                      width: 2,
                    ),
                    Text(
                      'Lainnya',
                      style: TextStyle(fontSize: 12),
                    ),
                  ],
                ),
              ),
              Visibility(
                  visible: seen,
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.all(10),
                        child: TextField(
                          onChanged: ((value) {
                            setState(() {
                              namaSekolah = value.toString();
                            });
                          }),
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              fillColor: Color.fromARGB(255, 255, 240, 245),
                              filled: false,
                              labelText: 'Nama sekolah',
                              labelStyle: TextStyle(fontSize: 12),
                              icon: Icon(Icons.school,
                                  color: Color.fromARGB(253, 215, 5, 124))),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(10),
                        child: TextField(
                          onChanged: ((value) {
                            setState(() {
                              kelas = value.toString();
                            });
                          }),
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              fillColor: Color.fromARGB(255, 255, 240, 245),
                              filled: false,
                              labelText: 'Kelas / Jurusan',
                              labelStyle: TextStyle(fontSize: 12),
                              icon: Icon(Icons.class_,
                                  color: Color.fromARGB(253, 215, 5, 124))),
                        ),
                      ),
                    ],
                  )),
              Container(
                margin: EdgeInsets.only(top: 20, bottom: 20, left: 15),
                child: Text(
                  'Voucher (jika ada)',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Color.fromARGB(253, 215, 5, 124)),
                ),
              ),
              Container(
                margin: EdgeInsets.all(10),
                child: TextField(
                  onChanged: ((value) {
                    setState(() {
                      kodeUnik = value.toString();
                    });
                  }),
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      fillColor: Color.fromARGB(255, 255, 240, 245),
                      filled: false,
                      labelText: '-',
                      hintText: 'Kode voucher',
                      labelStyle: TextStyle(fontSize: 12),
                      icon: Icon(Icons.price_change,
                          color: Color.fromARGB(253, 215, 5, 124))),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    cekValidasi();
                    (notifNirValid == '')
                        ? _launchURL()
                        : ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Row(
                              children: [
                                Icon(
                                  Icons.dangerous,
                                  color: Colors.white,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text('$notifNirValid')
                              ],
                            ),
                            backgroundColor: Colors.red,
                          ));
                  });
                },
                child: Text(
                  'Verifikasi ke admin',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                style: ElevatedButton.styleFrom(
                    fixedSize: Size(200, 50),
                    shape: StadiumBorder(),
                    backgroundColor: Color.fromARGB(253, 215, 5, 124)),
              ),
              SizedBox(
                height: 50,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
