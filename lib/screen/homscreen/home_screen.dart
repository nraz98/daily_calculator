import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:income_calculator/controller/earnings_controller.dart';
import 'package:income_calculator/screen/job_summary/job_summary.dart';
import 'package:income_calculator/shared/layout_shared.dart';
import 'package:income_calculator/shared/text_shared.dart';
import 'package:income_calculator/screen/homscreen/home_shared.dart';
import 'package:intl/intl.dart';
import '../../shared/color_shared.dart';
import '../../shared/sized_shared.dart';
import '../../shared/widget_shared.dart';

// ignore: must_be_immutable
class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);
  EarningsController earnController = Get.find();

  @override
  Widget build(BuildContext context) {
    return MainLayoutWidget(
      title: 'EARNINGS INCOME',
      headerContent: _buildHeaderContent(context),
      cardContent: _buildCardContent(),
      body: _buildBodyLayout(context),
    );
  }

  Widget _buildHeaderContent(context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: Height.sizedbox_height_15),
      child: Column(
        children: [
          Center(
            child: Text(
              'HI USER',
              style: AppText.px20.bold.customColor(whiteColor),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                child: const Icon(
                  Icons.crisis_alert,
                  color: whiteColor,
                ),
                onTap: () {
                  earnController.setGoalsController();
                  _bottomSheetMore(context);
                },
              ),
              Text(
                'Set Goals',
                style: AppText.px15.bold.customColor(whiteColor),
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCardContent() {
    return GetBuilder<EarningsController>(builder: (earnController) {
      return Padding(
        padding: EdgeInsets.symmetric(vertical: Height.sizedbox_height_15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: Width.sizedbox_width_10,
                ),
                Text(
                  'Total Earnings',
                  style: AppText.px17.customColor(const Color(0xff464646)),
                ),
              ],
            ),
            SizedBox(height: Height.sizedbox_height_10),
            Text(
              'RM ${earnController.totalEarn}',
              style: AppText.px24.w500.customColor(Colors.black),
            ),
            (earnController.usergoals.value.isNotEmpty)
                ? ((double.parse(earnController.usergoals.value) > 0)
                    ? Text(
                        'You need to get RM${earnController.usergoals} to achieved the goals.',
                        style:
                            AppText.px13.customColor(const Color(0xff464646)))
                    : Text('You already achieved the goals',
                        style:
                            AppText.px13.customColor(const Color(0xff464646))))
                : const SizedBox()
          ],
        ),
      );
    });
  }

  Widget _buildBodyLayout(BuildContext context) {
    return GetBuilder<EarningsController>(builder: (earnController) {
      return Expanded(
        child: Column(
          children: [
            groupButton(
                context: context,
                frameList: earnController.dateframe,
                controller: earnController.groupController,
                onCliked: (data, index, isSelected) {
                  earnController.setIndexButton(index);
                
                    earnController.setBeforeAfter(index);
                  
                }),
            Expanded(
                child: earnController.userEarn.isNotEmpty
                    ? ListView.builder(
                        itemCount: earnController.userEarn.first.income.length,
                        itemBuilder: (context, index) {
                          return (earnController.indexButton.value == 0)
                              ? _listEarnings(index)
                              : _listEarningsFilter(index);
                        })
                    : Center(
                        child: titleText(text: 'No Earnings Data Found'),
                      )),
          ],
        ),
      );
    });
  }

  Widget _listEarnings(int index) {
    return InkWell(
      onTap: (() {
        Get.to(() => JobSummaryScreen(index: index));
      }),
      child: CardEarnings(
          jobdate: earnController.userEarn.first.income[index].jobDate,
          jobname: earnController.userEarn.first.income[index].jobName,
          jobfee: earnController.userEarn.first.income[index].commission,
          jobcommission: earnController.userEarn.first.income[index].fee),
    );
  }

  Widget _listEarningsFilter(int index) {
    return GetBuilder<EarningsController>(builder: (earnController) {
      DateTime start =
          DateFormat('yyyy/MM/dd').parse(earnController.startDate.value);
      DateTime end =
          DateFormat('yyyy/MM/dd').parse(earnController.endDate.value);
      DateTime value = DateFormat('yyyy/MM/dd')
          .parse(earnController.userEarn.first.income[index].jobDate);
      return (end.isAfter(value) && start.isBefore(value))
          ? InkWell(
              onTap: (() {
                Get.to(() => JobSummaryScreen(index: index));
              }),
              child: CardEarnings(
                  jobdate: earnController.userEarn.first.income[index].jobDate,
                  jobname: earnController.userEarn.first.income[index].jobName,
                  jobfee:
                      earnController.userEarn.first.income[index].commission,
                  jobcommission:
                      earnController.userEarn.first.income[index].fee),
            )
          : const SizedBox();
    });
  }

  void _bottomSheetMore(context) {
    showModalBottomSheet(
        context: context,
        builder: (builder) {
          return Form(
            key: earnController.costkey,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      titleLeft(text: 'Expenses Details'),
                      IconButton(
                        icon: const Icon(Icons.close),
                        highlightColor: primaryColor,
                        onPressed: () {
                          Navigator.of(context).pop(true);
                        },
                      )
                    ],
                  ),
                  _buildTextEditingWeekGoal(),
                  _buildTextEditingMonthGoal(),
                  Expanded(
                      child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: primaryButton(
                          color: primaryColor,
                          text: 'Edit Goals',
                          onCliked: () {
                            if (earnController.costkey.currentState!
                                .validate()) {
                              earnController.setConfirmGoals();
                              Navigator.of(context).pop(true);
                            }
                          }),
                    ),
                  ))
                ],
              ),
            ),
          );
        });
  }

  Widget _buildTextEditingWeekGoal() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: Column(
        children: [
          titleLeft(text: 'Weekly Goals:'),
          TextFormField(
            decoration: InputDecoration(
                focusColor: blackColors,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                prefixText: "RM",
                prefixStyle: const TextStyle(color: blackColors),
                hintText: 'Weekly Goals',
                hintStyle: const TextStyle(color: blackColors)),
            keyboardType: TextInputType.number,
            autovalidateMode: AutovalidateMode.always,
            controller: earnController.weekgoalController,
            onChanged: (val) {
              earnController.weekGoals.value = val;
            },
            validator: (val) {
              if (val!.isEmpty) {
                return 'Insert value';
              } else if (double.parse(val) < 0) {
                return 'Insert positive value';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }

  Widget _buildTextEditingMonthGoal() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: Column(
        children: [
          titleLeft(text: 'Monthly Goals:'),
          TextFormField(
            decoration: InputDecoration(
                focusColor: blackColors,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                hintText: 'Monthly Cost ',
                prefixText: "RM",
                prefixStyle: const TextStyle(color: blackColors),
                hintStyle: const TextStyle(color: blackColors)),
            keyboardType: TextInputType.number,
            autovalidateMode: AutovalidateMode.always,
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
            ],
            controller: earnController.monthgoalController,
            onChanged: (val) {
              earnController.monthGoals.value = val;
            },
            validator: (val) {
              if (val!.isEmpty) {
                return 'Insert value';
              } else if (double.parse(val) < 0) {
                return 'Insert positive value';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }
}
