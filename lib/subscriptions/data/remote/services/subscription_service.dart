import 'dart:io';

import '../../../domain/model/subscription.dart';

abstract class SubscriptionService{
  Future<void> createSubscription(Subscription subscription);
  Future<List<String>> getAdminBankAccounts();
  Future<String> uploadImage(File image);
  Future<String> getSubscriptionStatusByUserId();
  Future<List<Subscription>> getAllSubscriptions();
  Future<void> activeSubscription(int subscriptionId);
}