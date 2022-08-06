import 'package:flutter/material.dart';

import 'package:income_calculator/shared/color_shared.dart';
import 'package:income_calculator/shared/sized_shared.dart';
import 'package:intl/intl.dart';

import 'package:sizer/sizer.dart';

class CardEarnings extends StatelessWidget {
  final String jobdate;
  final String jobname;
  final String jobfee;
  final String jobcommission;

  const CardEarnings(
      {Key? key,
      required this.jobdate,
      required this.jobname,
      required this.jobfee,
      required this.jobcommission,
    })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    DateTime parseDate = DateFormat('yyyy/MM/dd').parse(jobdate);
    var inputDate = DateTime.parse(parseDate.toString());
    var newdate = DateFormat('y MMM d').format(inputDate);
     double newFee = double.parse(jobfee);
     double  newCommision = double.parse(jobcommission);
     double total = newFee + newCommision;
    String newTotal = total.toStringAsFixed(2);
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: Height.sizedbox_height_10,
          horizontal: Width.sizedbox_width_15),
      child: Card(
          elevation: 3,
          shadowColor: secondaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(13.0),
          ),
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Padding(
                padding: EdgeInsets.all(2.6.w),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Date',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.8,
                            ),
                          ),
                          Text(
                            newdate,
                            style: const TextStyle(
                                color: blackColors,
                                letterSpacing: 0.8,
                                fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      height: 1.8.h,
                      thickness: 0.75,
                      color: secondaryColor,
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Job Name',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              letterSpacing: 0.8,
                            ),
                          ),
                          Text(
                            jobname,
                            style: const TextStyle(
                                color: blackColors,
                                letterSpacing: 0.8,
                                fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 0.3.h,
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Fees (RM)',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              letterSpacing: 0.8,
                            ),
                          ),
                          Text(
                            'RM ${double.parse(jobfee).toStringAsFixed(2)}',
                            style: const TextStyle(
                                color: blackColors,
                                letterSpacing: 0.8,
                                fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 0.3.h,
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Job Commision',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              letterSpacing: 0.8,
                            ),
                          ),
                          Text(
                            'RM ${double.parse(jobcommission).toStringAsFixed(2)}',
                            style: const TextStyle(
                                letterSpacing: 0.8,
                                fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 0.3.h,
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Total',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.8,
                            ),
                          ),
                          Text(
                            'RM $newTotal',
                            style: const TextStyle(
                                letterSpacing: 0.8,
                                fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                  ],
                )),
          )),
    );
  }
}
