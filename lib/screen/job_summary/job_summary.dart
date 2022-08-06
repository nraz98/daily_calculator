
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:income_calculator/controller/earnings_controller.dart';
import 'package:income_calculator/screen/job_summary/job_summary_extent.dart';
import 'package:income_calculator/shared/color_shared.dart';
import 'package:income_calculator/shared/layout_shared.dart';
import 'package:income_calculator/shared/sized_shared.dart';
import 'package:income_calculator/shared/text_shared.dart';
import 'package:income_calculator/shared/widget_shared.dart';

// ignore: must_be_immutable
class JobSummaryScreen extends StatelessWidget {
  final int index;

  JobSummaryScreen({Key? key, required this.index}) : super(key: key);

  EarningsController earnController = Get.find();

  @override
  Widget build(BuildContext context) {
    return MainLayoutWidget(
      title: 'JOB EARNINGS',
      cardContent: _buildCardContent(context),
    );
  }

  Widget _buildCardContent(context) {
    //Get Net Total

    earnController.calculateNetTotal(index);
    var totalFeeCommission = earnController.calculateFeeCommision(
        earnController.userEarn.first.income[index].fee,
        earnController.userEarn.first.income[index].commission);

    
     return GetBuilder<EarningsController>(builder: (earnController) {
    return  Padding(
          padding: EdgeInsets.symmetric(vertical: Height.sizedbox_height_15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal:  Width.sizedbox_width_10,),
                child: titleLeft(text: 'Earnings Details'),
              ),
              SizedBox(height: Height.sizedbox_height_10),
              rowtitlevalue(
                  title: 'Job Name',
                  value: earnController.userEarn.first.income[index].jobName),
              rowtitlevalue(
                  title: 'Job Fee (RM)',
                  value: double.parse(
                          earnController.userEarn.first.income[index].fee)
                      .toStringAsFixed(2)),
              rowtitlevalue(
                  title: 'Job Commission (RM)',
                  value: double.parse(earnController
                          .userEarn.first.income[index].commission)
                      .toStringAsFixed(2)),
                               const Padding(
                    padding: EdgeInsets.symmetric(vertical: 5),
                    child: Divider(
                      thickness: 0.7,
                      color: blackColors,
                    ),
                  ),
              rowtitlevalue(
                  title: 'Total Fee & Commision (RM)',
                  value: totalFeeCommission),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
           
                    titleLeft(text: 'Cost (RM)'),
                         InkWell(
                        child: const Icon(
                          Icons.add,
                          color: blackColors,
                        ),
                        onTap: () {
                      _bottomSheetMore(context, index);
                        },) 
                  ],
                ),
              ),
              _buildCostList(),
                   const Padding(
                    padding: EdgeInsets.symmetric(vertical: 5),
                    child: Divider(
                      thickness: 1.5,
                      color: blackColors,
                    ),
                  ),
                                rowtitlevalue(
                  title: 'Net Earnings (RM)',
                  value:earnController.netTotal.value),

            ],
          ),
        );

     });


  }

  Widget _buildCostList() {
    return GetBuilder<EarningsController>(builder: (earnController) {
      return earnController.userEarn.first.income[index].jobCost.isNotEmpty
          ? ListView.builder(
              shrinkWrap: true,
              itemCount:
                  earnController.userEarn.first.income[index].jobCost.length,
              itemBuilder: (context, idx) {
                return CostRowText(
                    idxincome: index,
                    idxcost: idx,
                    costamt:
                        ' ${double.parse(earnController.userEarn.first.income[index].jobCost[idx].costAmt).toStringAsFixed(2)}',
                    costdesc: earnController
                        .userEarn.first.income[index].jobCost[idx].costDesc);
              })
          : const SizedBox();
    });
  }



    void _bottomSheetMore(context, idxincome) {
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
                  _buildTextEditingCostName(),
                  _buildTextEditingCostAmt(),
                  Expanded(
                      child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: primaryButton(
                          color: primaryColor,
                          text: 'Add Expenses',
                          onCliked: () {
                            if (earnController.costkey.currentState!
                                .validate()) {
                              earnController.setConfirmAdd(idxincome, earnController.costname, earnController.costamt);
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

  Widget _buildTextEditingCostName() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: TextFormField(
        decoration: InputDecoration(
            focusColor: blackColors,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            hintText: 'Cost Name',
            hintStyle: const TextStyle(color: blackColors)),
        keyboardType: TextInputType.name,
        autovalidateMode: AutovalidateMode.always,
        controller: earnController.costnameController,
        onChanged: (val) {
          earnController.costname = val;
        },
        validator: (val) {
          if (val!.isEmpty) {
            return 'Insert value';
          }
          return null;
        },
      ),
    );
  }

  Widget _buildTextEditingCostAmt() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: TextFormField(
        decoration: InputDecoration(
            focusColor: blackColors,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            hintText: 'Cost Amount (RM)',
            prefixText: "RM",
            prefixStyle: const TextStyle(color: blackColors),
            hintStyle: const TextStyle(color: blackColors)),
        keyboardType: TextInputType.number,
        autovalidateMode: AutovalidateMode.always,
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
        ],
        controller: earnController.costamtController,
        onChanged: (val) {
          earnController.costamt = val;
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
    );
  }
}
