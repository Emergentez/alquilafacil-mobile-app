import 'package:alquilafacil/subscriptions/domain/model/plan.dart';

abstract class PlanService{
  Future<List<Plan>> getPlans();
}