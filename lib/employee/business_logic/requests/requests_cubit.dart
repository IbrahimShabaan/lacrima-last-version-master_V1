import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lacrima/employee/data/models/request_model.dart';
import 'package:lacrima/shared/notifications/notifications_services.dart';
import 'package:lacrima/employee/business_logic/requests/requests_states.dart';

class RequestsCubit extends Cubit<RequestsStates> {
  RequestsCubit() : super(RequestsEmployeeInitialState());

  static RequestsCubit get(context) => BlocProvider.of(context);

  // ############ Insert Employee Leave Request ############
  Future<void> insertEmployeeRequest({
    required String empId,
    required String status,
    // required String discount,
    required String empToken,
    required String requestId,
    required String empLastName,
    required String requestType,
    required String endDateTime,
    required String empFirstName,
    required String vacationType,
    required String startDateTime,
  }) async {
    RequestsModel requestsModel = RequestsModel(
      requestId: requestId,
      empId: empId,
      status: status,
      requestType: requestType,
      endDateTime: endDateTime,
      type: vacationType,
      startDateTime: startDateTime,
      empToken: empToken,
      empLastName: empLastName,
      empFirstName: empFirstName,
      createdAt: Timestamp.fromDate(DateTime.now()),
      // discount: discount,
    );
    emit(InsertRequestsLoadingState());
    await FirebaseFirestore.instance
        .collection('Requests')
        .doc(requestId)
        .set(requestsModel.toJson())
        .then((value) {
      emit(InsertRequestsSuccessState());
    }).catchError((error) {
      emit(InsertRequestsErrorState(error.toString()));
    });
  }

  Future<void> updateRequest({
    required String requestId,
    required String status,
  }) async {
    emit(UpdateRequestsLoadingState());
    FirebaseFirestore.instance
        .collection('Requests')
        .doc(requestId)
        .set({'status': status}, SetOptions(merge: true)).then((value) {
      emit(UpdateRequestsSuccessState());
    }).catchError((error) {
      emit(UpdateRequestsErrorState(error.toString()));
    });
  }

  Future<void> deleteAllRequestEmployee(String empId) async {
    emit(DeleteRequestsLoadingState());
    await FirebaseFirestore.instance
        .collection('Requests')
        .where('empId', isEqualTo: empId)
        .get()
        .then((value) {
      for (var doc in value.docs) {
        doc.reference.delete();
      }
      emit(DeleteRequestsSuccessState());
    }).catchError((error) {
      emit(DeleteRequestsErrorState(error.toString()));
    });
  }

  // ############ Handling Request Leave Type ############
  var leaveTypeItems = [
    'Business',
    'Personal',
  ];
  var leaveTypeItemsValue = 'Business';
  void leaveChange(value) {
    leaveTypeItemsValue = value;
    emit(LeaveTypeChange());
  }

  // ############ Handling Request Vacation Type ############

  var vacationTypeItems = [
    'Annual',
    'Death',
    'Sick',
  ];
  var vacationTypeItemsValue = 'Annual';
  void vacationChange(value) {
    vacationTypeItemsValue = value;
    emit(VacationTypeChange());
  }

  // ############ Handling Request OverTime Type ############

  var overTimeTypeItems = [
    'Holiday',
    'Eid',
    'Regular',
  ];
  var overTimeTypeItemsValue = 'Holiday';
  void overTimeChange(value) {
    overTimeTypeItemsValue = value;
    emit(OverTimeTypeChange());
  }

  // ================ Update Vacation Employee =================
  Future<void> updateVacationEmployee({
    required String type,
    required String empId,
    required String empToken,
    required double discount,
    required String requestId,
    required String requestType,
    required BuildContext context,
  }) async {
    emit(UpdateVacationLoadingState());
    await FirebaseFirestore.instance
        .collection('Employees')
        .doc(empId)
        .get()
        .then((value) async {
      double last = value.data()!['lastYearVacations'];
      double used = value.data()!['usedVacations'];
      double total = value.data()!['totalVacations'];
      double result = total + last;
      if (result >= discount) {
        if (last >= discount) {
          await FirebaseFirestore.instance
              .collection('Employees')
              .doc(empId)
              .set({
            'usedVacations': used + discount,
            'lastYearVacations': last - discount,
          }, SetOptions(merge: true));
          await updateRequest(requestId: requestId, status: 'Accepted');
          await NotificationServices.sendNotificationToToken(
            token: empToken,
            title: 'Request $type',
            body: 'Your request "$requestType" has been accepted.',
          );
          Navigator.pop(context);
          emit(UpdateVacationSuccessState());
        } else if (last != 0.0 && last <= discount) {
          var res2 = last.remainder(discount);
          var res3 = discount - res2;
          await FirebaseFirestore.instance
              .collection('Employees')
              .doc(empId)
              .set({
            'usedVacations': used + discount,
            'lastYearVacations': last - last.remainder(discount),
            'totalVacations': total - res3,
          }, SetOptions(merge: true));
          await updateRequest(requestId: requestId, status: 'Accepted');
          await NotificationServices.sendNotificationToToken(
            token: empToken,
            title: 'Request $type',
            body: 'Your request "$requestType" has been accepted.',
          );
          emit(UpdateVacationSuccessState());
          Navigator.pop(context);
        } else if (total >= discount) {
          await FirebaseFirestore.instance
              .collection('Employees')
              .doc(empId)
              .set({
            'usedVacations': used += discount,
            'totalVacations': total - discount,
          }, SetOptions(merge: true));
          await updateRequest(requestId: requestId, status: 'Accepted');
          await NotificationServices.sendNotificationToToken(
            token: empToken,
            title: 'Request $type',
            body: 'Your request "$requestType" has been accepted.',
          );
          emit(UpdateVacationSuccessState());
          Navigator.pop(context);
        } else {
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text(
                'There are not Vacations to accept the vacation. Please check the current year and last year '),
          ));
        }
      } else {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('there are not enough vacations'),
        ));
      }
    }).catchError((error) {
      emit(UpdateVacationErrorState(error.toString()));
    });
  }
}
