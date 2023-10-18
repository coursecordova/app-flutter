import 'package:cloud_firestore/cloud_firestore.dart';

Future<bool> signupWithEmail(
    {required String nama,
    required String sekolah,
    required String noHp}) async {
  if (nama == '') {
    return false;
  }

  if (noHp == '' || noHp.length <= 10 || noHp.length > 14) {
    return false;
  }

  if (sekolah == '' || (sekolah.length <= 3 && sekolah != '-')) {
    return false;
  }

  final dataUser = FirebaseFirestore.instance.collection('users').doc();

  final json = {
    'nama': nama,
    'sekolah': sekolah,
    'noHp': noHp,
  };

  try {
    await dataUser.set(json);
    return true; // Mengembalikan true jika penyimpanan berhasil.
  } catch (e) {
    print('Gagal menyimpan data: $e');
    return false; // Mengembalikan false jika terjadi kesalahan.
  }
}

