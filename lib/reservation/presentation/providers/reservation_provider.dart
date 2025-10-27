import 'dart:io';

import 'package:alquilafacil/reservation/domain/model/reservation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

import '../../data/remote/helpers/reservation_service_helper.dart';

class ReservationProvider extends ChangeNotifier{
  final ReservationServiceHelper reservationService;
  List<Reservation> reservations = [];
  List<Reservation> reservationsFromOtherUsers = [];
  String reservationPhotoUrl = "";

  ReservationProvider(this.reservationService);
  Future<void> createReservation(int userId, int localId, String startDate, String endDate, double price, String voucherImageUrl) async{
    await reservationService.createReservation(userId, localId, startDate, endDate, price, voucherImageUrl);
    notifyListeners();
  }

  Future<void> modifyReservation(int reservationId, int userId, int localId, String startDate, String endDate) async{
    await reservationService.modifyReservation(reservationId, userId, localId, startDate, endDate);
    notifyListeners();
  }

  Future<void> getReservationsByUserId(int userId) async{
    try {
      reservations = await reservationService.getReservationsByUserId(userId);
    } catch (e){
      Logger().e("Error al obtener reservas del usuario", e);
      reservations = [];
    }
    notifyListeners();
  }

  Future<void> getOtherUsersReservationsByUserId(int userId) async{
    try {
      reservationsFromOtherUsers = await reservationService.getOtherUsersReservationsByUserId(userId);
    } catch (e){
      reservationsFromOtherUsers = [];
    }
    notifyListeners();
  }

  Future<void> deleteReservation(int reservationId) async{
    await reservationService.deleteReservation(reservationId);
    notifyListeners();
  }

  Future<void> uploadImage(File image) async {
    try {
      reservationPhotoUrl = await reservationService.uploadImage(image);
    } catch (e) {
      Logger().e(
          "Error while trying to upload image, please check the service request",
          e);
    }
    notifyListeners();
  }
}