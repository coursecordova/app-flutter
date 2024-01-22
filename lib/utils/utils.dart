import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_cordova/utils/data.dart';
import 'package:flutter_application_cordova/utils/email.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:convert';
import 'package:crypto/crypto.dart';

FirebaseFirestore db = FirebaseFirestore.instance;

// is already login checker
bool isAlreadySign = false;

// checking token isAlready
String token = '';

// new password
String newPassword = '';

// Check if email is already sign up or not
Future loginChecker(String emailData) async {
  print(emailData);
  await db
      .collection('users')
      .where('email', isEqualTo: emailData)
      .get()
      .then((QuerySnapshot value) => {
            print(emailData),
            if (value.docs.isNotEmpty) {isAlreadySign = true}
          });
}

// updated data in database
Future updatedData(String emailData, {String objectData = ''}) async {
  await db
      .collection('users')
      .where('email', isEqualTo: emailData)
      .get()
      .then((value) => {
            value.docs.forEach((element) {
              var data = element.data();
              if (objectData == "token" && data['resetToken'] == null ||
                  data['resetToken'] == "") {
                // if token is null
                // generated token and saved to database
                token = generateRandomToken(6);
                element.reference.update({'resetToken': token});
              }

              if (objectData == "passwordReset") {
                element.reference.update({'resetToken': ""});

                element.reference.update({'password': newPassword});
              }
            })
          });
}

bool isEmailValid(String email) {
  final emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@gmail\.com$');
  return emailRegex.hasMatch(email);
}

// Generated random token for forget password
String generateRandomToken(int length) {
  const chars =
      "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
  Random random = Random();

  String token = "";

  for (int i = 0; i < length; i++) {
    int randomIndex = random.nextInt(chars.length);
    token += chars[randomIndex];
  }

  // Return token
  return token;
}

Future<Map<String, dynamic>> signupWithEmail({
  required String email,
  required String password,
  required String noHp,
  required String sekolah,
}) async {
  if (email == '' || !isEmailValid(email)) {
    return {'isValid': false, 'message': "Gunakan email google @gmail.com"};
  }

  await loginChecker(email);

  if (isAlreadySign) {
    isAlreadySign = false;
    return {
      'isValid': false,
      'message': "Email sudah digunakan. Silahkan kembali ke halaman login"
    };
  }

  if (password == '' || password.length < 8) {
    return {
      'isValid': false,
      'message': "password anda harus 8 huruf atau lebih"
    };
  }

  if (noHp == '' || noHp.length <= 10 || noHp.length > 14) {
    return {'isValid': false, 'message': "nomor telephone anda tidak valid"};
  }

  if (sekolah == '' || (sekolah.length <= 3 && sekolah != '-')) {
    return {
      'isValid': false,
      'message': "gunakan nama sekolah yang valid dan tidak boleh kosong"
    };
  }

  final dataUser = db.collection('users').doc();

  // ecnrypt password
  final key = utf8.encode(password);
  final hashPassword = sha256.convert(key);

  password = hashPassword.toString();

  final json = {
    'email': email,
    'sekolah': sekolah,
    'password': password,
    'noHp': noHp,
    'methodlogin': 'gmail',
    'course': {}
  };

  try {
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
    await dataUser.set(json);
    print("login berhasil");

    List<String> emailData = email.split("@");

    // save data to sharedPreferenced
    Userpref.setUserData({
      'email': email,
      'username': emailData.first,
      'sekolah': sekolah,
      'noHp': noHp,
    });

    return {
      'isValid': true,
      'message': "Sign up anda sukses"
    }; // Mengembalikan true jika penyimpanan berhasil.
  } catch (e) {
    print('Gagal menyimpan data: $e');
    return {
      'isValid': false,
      'message': "Maaf data anda gagal disimpan"
    }; // Mengembalikan false jika terjadi kesalahan.
  }
}

Future<Map<String, dynamic>> loginWithEmail(
    {required String email, required password}) async {
  if (password == '' || password.length < 8) {
    return {
      'isValid': false,
      'message': "password anda harus 8 huruf atau lebih"
    };
  }
  // check if email is already sign up or not
  await loginChecker(email);

  // if email is not already sign up
  // show alert for user to sign up

  if (!isAlreadySign) {
    isAlreadySign = false;
    return {
      'isValid': false,
      'message':
          "Email belum didaftarkan. kembali ke halaman masuk untuk daftar akun"
    };
  }

  String userPassword = '';
  String methodLogin = '';

  // user data
  String sekolah = '';
  String noHp = '';
  String username = '';

  List<String> emailData = email.split("@");
  username = emailData.first;

  await db
      .collection('users')
      .where('email', isEqualTo: email)
      .get()
      .then((value) => {
            value.docs.forEach((element) {
              var data = element.data();
              userPassword = data['password'];
              methodLogin = data['methodlogin'];
              sekolah = data['sekolah'];
              noHp = data['noHp'];
            })
          });

  if (methodLogin != 'gmail') {
    return {
      'isValid': false,
      'message':
          "Akun anda ditemukan. Email anda menggunakan login dengan google. silahkan login dengan google atau ganti password"
    };
  }

  // check encrypt
  final key = utf8.encode(password);
  final hashPassword = sha256.convert(key);

  if (userPassword != hashPassword.toString()) {
    return {'isValid': false, 'message': "Password yang anda masukkan salah"};
  }

  // save data to sharedPreferenced
  Userpref.setUserData({
    'email': email,
    'username': username,
    'sekolah': sekolah,
    'noHp': noHp,
  });

  return {
    'isValid': true,
    'message': "Login berhasil, silahkan masuk ke halaman utama"
  };
}

Future<Map<String, dynamic>> resetPasswordEmail({required String email}) async {
  // check email is valid ot not
  if (email == '' || !isEmailValid(email)) {
    return {
      'isValid': false,
      'message': "email kosong atau gunakan email google @gmail.com"
    };
  }

  // Check email is exist or not
  await loginChecker(email);

  // if email not exist return waring
  if (!isAlreadySign) {
    return {
      'isValid': false,
      'message':
          "Email belum didaftarkan. kembali ke halaman masuk untuk daftar akun"
    };
  }

  // saved token to database
  await updatedData(email, objectData: "token");

  // if email exist, send email with link to reset password
  await emailSender(email, token);

  return {
    'isValid': true,
    'message':
        "Cek email mu untuk melihat token untuk update password, atau cek spam"
  };
}

Future<Map<String, dynamic>> resetTokenValidator(
    String? emailData, String? resetToken) async {
  bool isValid = false;
  await db
      .collection('users')
      .where('email', isEqualTo: emailData)
      .get()
      .then((value) => {
            value.docs.forEach((element) {
              var data = element.data();
              if (data['resetToken'] == resetToken) {
                isValid = true;
              }
            })
          });

  if (isValid) {
    isValid = false;
    return {
      'isValid': true,
      'message': "Validasi token anda berhasil. Silahkan perbarui password anda"
    };
  }

  return {
    'isValid': false,
    'message':
        "Token anda tidak valid. Perbarui permintaan reset anda dan gunakan token yang baru"
  };
}

Future<Map<String, dynamic>> changePassword(
    {required emailData, required password}) async {
  bool isValid = false;

  if (password.length < 8 || password == '') {
    return {'isValid': isValid, 'message': "Gunakan minimal 8 kombinasi huruf"};
  }

  // ecnrypt password
  final key = utf8.encode(password);
  final hashPassword = sha256.convert(key);

  newPassword = hashPassword.toString();

  await updatedData(emailData, objectData: "passwordReset")
      .then((value) => {isValid = true});

  if (isValid) {
    isValid = false;
    return {
      'isValid': true,
      'message': "Password anda berhasil diubah. Silahkan login"
    };
  }

  return {
    'isValid': false,
    'message':
        "Token anda tidak valid. Perbarui permintaan reset anda dan gunakan token yang baru"
  };
}

Future<bool> signupWithGoogle(
    {required String? email, required emailId, required displayName}) async {
  // create variabel to check. is email from user is already sign up
  bool isSignUp = false;
  String? sekolah;
  String? noHp;

  // check email from users
  print("Check user email");
  await db
      .collection('users')
      .where('email', isEqualTo: email)
      .get()
      .then((QuerySnapshot value) {
    if (value.docs.isNotEmpty) {
      isSignUp = true;
    } // if already signup
  });

  // if user email is already sign up return true
  if (isSignUp) {
    print("email sudah di daftarkan");
    isSignUp = false;

    List<String>? emailData = email?.split("@");

    // save data to sharedPreferenced
    Userpref.setUserData({
      'email': email,
      'username': emailData?.first,
      'sekolah': sekolah,
      'noHp': noHp,
      'loginMethod': "google"
    });

    return true;
  } else {
    // if email from user is not already
    // get email, emailId, and name

    final dataUser = db.collection('users').doc();

    // ecnrypt emailId
    // ecnrypt password
    final key = utf8.encode(emailId);
    final hashPassword = sha256.convert(key);

    final password = hashPassword.toString();

    final json = {
      'name': displayName,
      'email': email,
      'password': password,
      'methodlogin': "google",
      'course': {}
    };

    print("kirim data ke database untuk disimpan");

    try {
      // Sent to database to store user data
      await dataUser.set(json);

      List<String>? emailData = email?.split("@");

      // save data to sharedPreferenced
      Userpref.setUserData({
        'email': email,
        'username': emailData?.first,
        'sekolah': sekolah,
        'noHp': noHp,
        'loginMethod': "google"
      });
      print("Email baru saja di daftarkan");
      return true; // Mengembalikan true jika penyimpanan berhasil.
    } catch (e) {
      print('Gagal menyimpan data: $e');
      return false; // Mengembalikan false jika terjadi kesalahan.
    }
  }
}
