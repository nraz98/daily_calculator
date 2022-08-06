

import 'dart:convert';

UserEarnings userEarningsFromJson(String str) =>
    UserEarnings.fromJson(json.decode(str));

String userEarningsToJson(UserEarnings data) => json.encode(data.toJson());

class UserEarnings {
  UserEarnings({
    required this.weeklygoals,
    required    this.monthlygoals,
    required this.income,
  });
  String weeklygoals;
    String monthlygoals;
  List<Income> income;

     factory UserEarnings.fromJson(Map<String, dynamic> json) => UserEarnings(
        weeklygoals: json["weeklygoals"],
        monthlygoals: json["monthlygoals"],
        income: List<Income>.from(json["income"].map((x) => Income.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "weeklygoals": weeklygoals,
        "monthlygoals": monthlygoals,
        "income": List<dynamic>.from(income.map((x) => x.toJson())),
    };
}

class Income {
  Income({
    required this.uuid,
    required this.jobName,
    required this.jobDate,
    required this.fee,
    required this.commission,
    required this.jobCost,
  });

  String uuid;
  String jobName;
  String jobDate;
  String fee;
  String commission;
  List<JobCost> jobCost;

  factory Income.fromJson(Map<String, dynamic> json) => Income(
        uuid: json["uuid"],
        jobName: json["job_name"],
        jobDate: json["job_date"],
        fee: json["fee"],
        commission: json["commission"],
        jobCost: List<JobCost>.from(
            json["job_cost"].map((x) => JobCost.fromJson(x))),
      );

  get isDeleted => null;

  Map<String, dynamic> toJson() => {
        "uuid": uuid,
        "job_name": jobName,
        "job_date": jobDate,
        "fee": fee,
        "commission": commission,
        "job_cost": List<dynamic>.from(jobCost.map((x) => x.toJson())),
      };
}

class JobCost {
  JobCost({
    required this.costDesc,
    required this.costAmt,
  });

  String costDesc;
  String costAmt;

  factory JobCost.fromJson(Map<String, dynamic> json) => JobCost(
        costDesc: json["cost_desc"],
        costAmt: json["cost_amt"],
      );

  Map<String, dynamic> toJson() => {
        "cost_desc": costDesc,
        "cost_amt": costAmt,
      };
}
