import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:group_button/group_button.dart';
import 'package:intl/intl.dart';

import '../model/earnings_model.dart';

class EarningsController extends GetxController {
  final GlobalKey<FormState> costkey = GlobalKey<FormState>();

  //Date Format
  var today = DateFormat('yyyy/MM/dd').format(DateTime.now());
  var less7 = DateFormat('yyyy/MM/dd')
      .format(DateTime.now().subtract(const Duration(days: 7)));
  var less30 = DateFormat('yyyy/MM/dd')
      .format(DateTime.now().subtract(const Duration(days: 30)));
  var less60 = DateFormat('yyyy/MM/dd')
      .format(DateTime.now().subtract(const Duration(days: 60)));

  var userEarn = <UserEarnings>[].obs;
  var totalEarn = '0.00'.obs;
  var netTotal = '0.00'.obs;

  //Related to Goal
  var weekGoals = '0.00'.obs;
  var monthGoals = '0.00'.obs;
  var usergoals = ''.obs;

  //Related to Cost Attribute
  var costname = "";
  var costamt = "";

  //Related to Button Date Frame
  var indexButton = 0.obs;
  var startDate = "".obs;
  var endDate = "".obs;

  final List<String> dateframe = [
    'All',
    'This Week',
    'This Month',
    'Last Month',
  ].obs;

  late GroupButtonController groupController;

  //TextEditingController
  late TextEditingController costnameController,
      costamtController,
      weekgoalController,
      monthgoalController;

// Set Index Button
  void setIndexButton(int index) {
    indexButton.value = index;
    update();
  }

  //Set Before and End Date
  void setBeforeAfter(int index) {
    if (index == 0) {
      startDate.value = "";
      endDate.value = "";
      usergoals.value = "";

      fetchTotalEarnings();
    } else if (index == 1) {
      startDate.value = less7;
      endDate.value = today;
      usergoals.value = (double.parse(userEarn.first.weeklygoals) -
              double.parse(totalEarn.value))
          .toStringAsFixed(2);

      fetchTotalEarningsFilter();
    } else if (index == 2) {
      startDate.value = less30;
      endDate.value = today;
      usergoals.value = (double.parse(userEarn.first.monthlygoals) -
              double.parse(totalEarn.value))
          .toStringAsFixed(2);
      fetchTotalEarningsFilter();
    } else if (index == 3) {
      startDate.value = less60;
      endDate.value = less30;
      usergoals.value = '';
      fetchTotalEarningsFilter();
    } else {
      usergoals.value = '';
    }
    update();
  }

  //Set Goals Controller
  void setGoalsController() {
    weekgoalController.text = userEarn.first.weeklygoals;
    monthgoalController.text = userEarn.first.monthlygoals;
    weekGoals.value = userEarn.first.weeklygoals;
    monthGoals.value = userEarn.first.monthlygoals;
    update();
  }

  void setConfirmGoals() {
    userEarn.first.weeklygoals = weekGoals.value;
    userEarn.first.monthlygoals = monthGoals.value;

    // ignore: unrelated_type_equality_checks
    if (indexButton == 1) {
      usergoals.value = (double.parse(userEarn.first.weeklygoals) -
              double.parse(totalEarn.value))
          .toStringAsFixed(2);
      // ignore: unrelated_type_equality_checks
    } else if (indexButton == 2) {
      usergoals.value = (double.parse(userEarn.first.monthlygoals) -
              double.parse(totalEarn.value))
          .toStringAsFixed(2);
    } else {
      usergoals.value = '';
    }

    update();
  }

  //Add Cost
  void setConfirmAdd(int idxincome, String name, String amt) {
    userEarn.first.income[idxincome].jobCost
        .add(JobCost(costDesc: name, costAmt: amt));
    calculateNetTotal(idxincome);

    costnameController = TextEditingController();
    costamtController = TextEditingController();
    update();
  }

  void deleteCost(int idxincome, int idxcost) {
    userEarn.first.income[idxincome].jobCost.removeAt(idxcost);
    calculateNetTotal(idxincome);
    update();
  }

  void setEditController(int idxincome, int idxcost) {
    costnameController.text =
        userEarn.first.income[idxincome].jobCost[idxcost].costDesc;
    costamtController.text =
        userEarn.first.income[idxincome].jobCost[idxcost].costAmt;

    update();
  }

  void setConfirmEdit(int idxincome, int idxcost) {
    userEarn.first.income[idxincome].jobCost[idxcost].costDesc = costname;
    userEarn.first.income[idxincome].jobCost[idxcost].costAmt = costamt;

    calculateNetTotal(idxincome);

    update();
  }

  @override
  void onInit() {
    fetchUserData();
    costnameController = TextEditingController();
    costamtController = TextEditingController();
    weekgoalController = TextEditingController();
    monthgoalController = TextEditingController();
    groupController = GroupButtonController();
    groupController.selectIndex(0);
    super.onInit();
  }

  @override
  void dispose() {
    Get.delete<EarningsController>();
    costnameController.dispose();
    costamtController.dispose();
    super.dispose();
  }

  Future<void> fetchUserData() async {
    final response = await rootBundle.loadString('assets/my_income.json');
    //Convert to model
    UserEarnings userModel = UserEarnings.fromJson(jsonDecode(response));
    userEarn.add(UserEarnings(
        weeklygoals: userModel.weeklygoals,
        monthlygoals: userModel.monthlygoals,
        income: userModel.income));

    //Sort into recent date
    userEarn.first.income.sort((a, b) => b.jobDate.compareTo(a.jobDate));

    //Get total earnings
    fetchTotalEarnings();
    update();
  }

  Future<void> fetchTotalEarnings() async {
    double sumEarn = 0;

    if (userEarn.first.income.isNotEmpty) {
      for (int i = 0; i < userEarn.first.income.length; i++) {
        double commision = double.parse(userEarn.first.income[i].commission);
        double fee = double.parse(userEarn.first.income[i].fee);
        double temp = commision + fee;
        sumEarn += temp;
      }
    } else {
      sumEarn = 0;
    }
    totalEarn.value = sumEarn.toStringAsFixed(2);
    update();
  }

  void fetchTotalEarningsFilter() async {
    double sumEarn = 0;

    if (userEarn.first.income.isNotEmpty) {
      for (int i = 0; i < userEarn.first.income.length; i++) {
        DateTime start = DateFormat('yyyy/MM/dd').parse(startDate.value);
        DateTime end = DateFormat('yyyy/MM/dd').parse(endDate.value);
        DateTime value =
            DateFormat('yyyy/MM/dd').parse(userEarn.first.income[i].jobDate);

        if ((end.isAfter(value) && start.isBefore(value))) {
          double commision = double.parse(userEarn.first.income[i].commission);
          double fee = double.parse(userEarn.first.income[i].fee);
          double temp = commision + fee;
          sumEarn += temp;
        }
      }
    } else {
      sumEarn = 0;
    }

    totalEarn.value = sumEarn.toStringAsFixed(2);

    // ignore: unrelated_type_equality_checks
    if (indexButton == 1) {
      usergoals.value = (double.parse(userEarn.first.weeklygoals) -
              double.parse(totalEarn.value))
          .toStringAsFixed(2);
      // ignore: unrelated_type_equality_checks
    } else if (indexButton == 2) {
      usergoals.value = (double.parse(userEarn.first.monthlygoals) -
              double.parse(totalEarn.value))
          .toStringAsFixed(2);
    } else {
      usergoals.value = '';
    }

    update();
  }

  String calculateFeeCommision(String fee, String commision) {
    double newFee = double.parse(fee);
    double newCommision = double.parse(commision);

    double total = newFee + newCommision;

    return total.toStringAsFixed(2);
  }

  void calculateNetTotal(int idxincome) {
    double newFee = double.parse(userEarn.first.income[idxincome].fee);
    double newCommision =
        double.parse(userEarn.first.income[idxincome].commission);

    double totalCost = 0;

    for (int i = 0;
        i < (userEarn.first.income[idxincome].jobCost.length);
        i++) {
      double cost =
          double.parse(userEarn.first.income[idxincome].jobCost[i].costAmt);
      totalCost += cost;
    }
    double net = newFee + newCommision + totalCost;
    netTotal.value = net.toStringAsFixed(2);
  }
}
