import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rakta/utils/hive.dart';

void sendReviewMessage() async {
  var data = await FirebaseFirestore.instance.collection("whatsapp").doc("0").get();
  var token = data['token'];
  var url = Uri.parse('https://graph.facebook.com/v19.0/190767744131124/messages');
  var headers = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer '+token,
  };
  var body = json.encode({
    'messaging_product': 'whatsapp',
    'recipient_type': 'individual',
    'to': HiveDataBase.getUserData().mobile,
    'type': 'template',
    'template': {
      'name': 'rak_review',
      'language': {'code': 'en_US'},
      'components': [
        {
          'type': 'button',
          'sub_type': 'url',
          'index': '0',
          'parameters': [
            {'type': 'payload', 'payload': Random().nextInt(99999999).toString()}
          ]
        }
      ]
    }
  });

  var response = await http.post(url, headers: headers, body: body);
  print(response.body);
}
