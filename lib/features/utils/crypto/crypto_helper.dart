import 'package:encrypt/encrypt.dart' as encrypt;

class EncryptHelper {
  static final key = encrypt.Key.fromUtf8('A1N3DO012CHAUWQ1J5CNFU20KD9E81NC');
  static final iv = encrypt.IV.fromUtf8('DK39F4FH288FHFY');

  final encrypter = encrypt.Encrypter(encrypt.AES(key));

  Map<String, dynamic> encryptData(Map<String, dynamic> data) {
    return data.map((key, value) {
      if (value is String && key != 'genderName') {
        var encryptedValue = encrypter.encrypt(value, iv: iv);
        return MapEntry(key, encryptedValue.base64);
      } else {
        return MapEntry(key, value);
      }
    });
  }

  Map<String, dynamic> decryptData(Map<String, dynamic> data) {
    return data.map((key, value) {
      if (value is String) {
        try {
          var decryptedValue = encrypter.decrypt64(value.toString(), iv: iv);
          return MapEntry(key, decryptedValue);
        } catch (e) {
          return MapEntry(key, value);
        }
      } else {
        return MapEntry(key, value);
      }
    });
  }
}
