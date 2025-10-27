import 'dart:io';

import 'package:alquilafacil/subscriptions/data/remote/helpers/subscription_service_helper.dart';
import 'package:alquilafacil/subscriptions/domain/model/subscription.dart';
import 'package:flutter/cupertino.dart';
import 'package:logger/logger.dart';

class SubscriptionProvider extends ChangeNotifier{
  final SubscriptionServiceHelper subscriptionService;
  String subscriptionPhotoUrl = "";
  String subscriptionStatus = "";
  List<Subscription> subscriptions = [];

  SubscriptionProvider(this.subscriptionService);

  Future<void> createSubscription(Subscription subscription) async {
    await subscriptionService.createSubscription(subscription);
    notifyListeners();
  }

  Future<List<String>> getAdminBankAccounts() async {
    final bankAccounts = await subscriptionService.getAdminBankAccounts();
    notifyListeners();
    return bankAccounts;
  }

  Future<void> uploadImage(File image) async {
    try {
      subscriptionPhotoUrl = await subscriptionService.uploadImage(image);
    } catch (e) {
      Logger().e(
          "Error while trying to upload image, please check the service request",
          e);
    }
    notifyListeners();
  }

  Future<void> getSubscriptionStatusByUserId() async {
    subscriptionStatus = await subscriptionService.getSubscriptionStatusByUserId();
    notifyListeners();
  }

  Future<void> getAllSubscriptions() async {
    subscriptions = await subscriptionService.getAllSubscriptions();
    notifyListeners();
  }

  Future<void> activeSubscription(int subscriptionId) async {
    await subscriptionService.activeSubscription(subscriptionId);
    notifyListeners();
  }
}