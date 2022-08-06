// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';import 'package:income_calculator/shared/color_shared.dart';
import 'package:income_calculator/shared/text_shared.dart';
import 'package:income_calculator/shared/widget_shared.dart';
import '../../controller/earnings_controller.dart';
import '../../shared/sized_shared.dart';

class CostRowText extends StatelessWidget {
  final int idxincome;
  final int idxcost;
  final String costamt;
  final String costdesc;

  CostRowText({
    Key? key,
    required this.idxincome,
    required this.idxcost,
    required this.costamt,
    required this.costdesc,
  }) : super(key: key);

  EarningsController earnController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        PopupMenuButton(
            onSelected: (v) {
              if (v == 'delete') {
                showAlertDialog(context);
              } else if (v == 'edit') {
                earnController.setEditController(idxincome, idxcost);
                _bottomSheetMore(context);
             
              }
            },
            itemBuilder: (context) => [
                  PopupMenuItem(
                    value: 'edit',
                    onTap: () {},
                    child: Row(
                      children: const [
                        Icon(Icons.edit_note_outlined),
                        Text('Edit')
                      ],
                    ),
                  ),
                  PopupMenuItem(
                    value: 'delete',
                    child: Row(
                      children: const [Icon(Icons.delete), Text('Delete')],
                    ),
                  )
                ],
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Row(
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  const Icon(Icons.more_horiz_rounded, color: primaryColor),
                  Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: Text(
                      costdesc.toUpperCase(),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.8,
                      ),
                    ),
                  ),
                ],
              ),
            )),
        Text(
          costamt,
          style:
              const TextStyle(letterSpacing: 0.8, fontWeight: FontWeight.w400),
        ),
      ],
    );
  }

  showAlertDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: const Text("Cancel"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget continueButton = TextButton(
      child: const Text("OK"),
      onPressed: () {
        earnController.deleteCost(idxincome, idxcost);
        Navigator.of(context).pop();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Alert Message!", style: AppText.px15.bold.w500),
      content: Text("Are you sure you want to delete?",
          style: AppText.px15.w500.w500),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
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
                  _buildTextEditingCostName(),
                  _buildTextEditingCostAmt(),
                  Expanded(
                      child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: primaryButton(
                          color: primaryColor,
                          text: 'Edit Expenses',
                          onCliked: () {
                            if (earnController.costkey.currentState!
                                .validate()) {
                              earnController.setConfirmEdit(idxincome, idxcost);
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
