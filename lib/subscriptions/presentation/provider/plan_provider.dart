import 'package:alquilafacil/subscriptions/data/remote/helpers/plan_service_helper.dart';
import 'package:alquilafacil/subscriptions/domain/model/plan.dart';
import 'package:flutter/cupertino.dart';

class PlanProvider extends ChangeNotifier{
  List<Plan> currentPlans = [];
  final PlanServiceHelper planServiceHelper;
  PlanProvider(this.planServiceHelper);

  Future<void> fetchPlansAvailable() async {
    currentPlans = await planServiceHelper.getPlans();
    notifyListeners();
  }
}
