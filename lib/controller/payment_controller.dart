import 'dart:convert';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class PaymentController extends GetxController{
  double balance =0;

  PaymentController(){
    FirebaseFirestore.instance.collection("Account").doc("0").snapshots().listen((value) {
      balance = double.parse(value.data()!['balance'].toString());
      update();
    });
  }
  Future<bool?> payWithApplePay(double amount) async {
    double totalPrice = amount;
    print(amount);
    try {
      await Stripe.instance.presentApplePay(
        params: ApplePayPresentParams(
          cartItems: [
            ApplePayCartSummaryItem.immediate(
              label: 'Saqr Balance',
              amount: totalPrice.toString(),
            ),
          ],
          country: 'AE',
          currency: 'AED',
        ),
      );
      final paymentIntentResponse = await _getPaymentIntent({
        'amount': (totalPrice * 100).toInt().toString(),
        'currency': 'AED',
        'payment_method_types[]': 'card',
      });
      print(paymentIntentResponse);
      final clientSecret = paymentIntentResponse!['client_secret'];

      print(clientSecret);
      await Stripe.instance.confirmApplePayPayment(clientSecret);
      return true;
    } on PlatformException catch (exception) {
      log(exception.message ?? 'Something went wrong');
      log(exception.code ?? 'Something went wrong');
      log(exception.details ?? 'Something went wrong');
    } catch (exception) {
      log(exception.toString());
      log(exception.toString());
      return false;
    }
    return false;
  }
  addBalance(amount){
    // balance=amount+balance;
    FirebaseFirestore.instance.collection("Account").doc("0").update({"balance":(amount+balance).toString()});
    Get.back();
    // update();
  }
  Future<Map<String, dynamic>?> _getPaymentIntent(
      Map<String, dynamic> data) async {
    try {
      http.Response paymentIntentRespose = await http.post(
        Uri.parse(
            'https://api.stripe.com/v1/payment_intents?amount=${data['amount']}&currency=${data['currency']}&payment_method_types[]=${data['payment_method_types[]']}'),
        headers: <String, String>{
          'Authorization': 'Bearer sk_test_51P8isI08kbWqoawO672jNI2xWIQ0A4R63nx0WtAEC3wfwdOD7sBG4uxJ2lJfkDaZ6GIFS70HMgX7ygrmTylxyhwA00xyD6WZFN',
        },
      );
      var jsonData = jsonDecode(paymentIntentRespose.body);
      return jsonData;
    } catch (exception) {
      log(exception.toString());
    }
    return null;
  }


  Future<bool> handleApplePayPress(context,double selected) async {
    try {

      //if (Stripe.instance.isApplePaySupported.value) {
        return await payWithApplePay(selected) ?? false;
        // if (paymentSuccessful) {
        //   log('payment successful');
        // } else {
        //   log('payment failed');
        // }
      // } else {
      //   ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      //     content: Text('Apple pay is not supported in this device'),
      //   ));
      //   return false;
      // }
    } catch (exception) {
      log(exception.toString());
    }
    return false;
  }
}
