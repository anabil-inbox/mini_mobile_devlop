import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:inbox_clients/feature/model/app_setting_modle.dart';
import 'package:inbox_clients/feature/view_model/storage_view_model/storage_view_model.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';

import 'app_shaerd_data.dart';

class DateUtility {
  static String getPostTime2(String date) {
    initializeDateFormatting(isArabicLang()?'ar':'en');
    if (date == null || date.isEmpty) {
      return '';
    }
    var dt = DateTime.parse(date).toLocal();
    var dat =
        DateFormat.jm().format(dt) + ' - ' + DateFormat("dd MMM yy",(isArabicLang()?"ar":"en")).format(dt);
    return dat;
  }

  static String getdob(String date) {
    if (date == null || date.isEmpty) {
      return '';
    }
    var dt = DateTime.parse(date).toLocal();
    var dat = DateFormat.yMMMd().format(dt);
    return dat;
  }

  static String getJoiningDate(String date) {
    initializeDateFormatting(isArabicLang()?'ar':'en');
    if (date == null || date.isEmpty) {
      return '';
    }
    var dt = DateTime.parse(date).toLocal();
    var dat = DateFormat("MMMM yyyy",isArabicLang()?'ar':'en').format(dt);
    return 'Joined $dat';
  }

  // static String getChatTime(String date) {
  //   initializeDateFormatting(isArabicLang()?'ar':'en');
  //   try {
  //     if (date == null || date.isEmpty) {
  //           return '';
  //         }
  //     String msg = '';
  //     var dt = DateTime.parse(date).toLocal();
  //     if (DateTime.now().toLocal().isBefore(dt)) {
  //           return DateFormat.jm().format(DateTime.parse(date).toLocal()).toString();
  //         }
  //     var dur = DateTime.now().toLocal().difference(dt);
  //     if (dur.inDays > 0) {
  //           msg = '${dur.inDays} ${txtD.tr}';
  //           return dur.inDays == 1 ? '${txtBefore?.tr} 1 ${txtD.tr}' : DateFormat("dd MMM",isArabicLang()?'ar':'en').format(dt);
  //         } else if (dur.inHours > 0) {
  //           msg = '${txtBefore?.tr}  ${dur.inHours} ${txtH.tr}';
  //         } else if (dur.inMinutes > 0) {
  //           msg = '${txtBefore?.tr} ${dur.inMinutes} ${txtM.tr}';
  //         } else if (dur.inSeconds > 0) {
  //           msg ='${txtBefore?.tr} ${dur.inSeconds} ${txtS.tr}';
  //         } else {
  //           msg = '${txtNow.tr}';
  //         }
  //     return msg;
  //   } catch (e) {
  //     print(e);
  //     Logger().d(e);
  //     return "";
  //   }
  // }

  static String getPollTime(String date) {
    try {
      int hr, mm;
      String msg = 'Poll ended';
      var enddate = DateTime.parse(date);
      if (DateTime.now().isAfter(enddate)) {
            return msg;
          }
      msg = 'Poll ended in';
      var dur = enddate.difference(DateTime.now());
      hr = dur.inHours - dur.inDays * 24;
      mm = dur.inMinutes - (dur.inHours * 60);
      if (dur.inDays > 0) {
            msg = ' ' + dur.inDays.toString() + (dur.inDays > 1 ? ' Days ' : ' Day');
          }
      if (hr > 0) {
            msg += ' ' + hr.toString() + ' hour';
          }
      if (mm > 0) {
            msg += ' ' + mm.toString() + ' min';
          }
      return (dur.inDays).toString() +
              ' Days ' +
              ' ' +
              hr.toString() +
              ' Hours ' +
              mm.toString() +
              ' min';
    } catch (e) {
      Logger().d(e);
      return "";
    }
  }

  static String convertToLocalDateTime(DateTime uTCTime) {
    try {
      initializeDateFormatting(isArabicLang()?'ar':'en');
      var dateFormat = DateFormat("hh:mm aa",(isArabicLang()?"ar":"en")); // you can change the format here
      var utcDate = dateFormat.format(uTCTime); // pass the UTC time here
      var localDate = dateFormat.parse(utcDate, true).toLocal().toString();
      String createdDate = dateFormat.format(DateTime.parse(localDate));
      return createdDate;
    } catch (e) {
      print(e);
      return "";
    }
  }

  // get Utc Time (Houers And Menites From Day) : 
  static String getLocalhouersFromUtc({required Day day}){
  final dtFrom = DateTime(0,0,0, int.parse(day.from!.split(":")[0]) , int.parse(day.from!.split(":")[1]));  
  final dtTo = DateTime(0,0,0 ,int.parse(day.to!.split(":")[0]) , int.parse(day.to!.split(":")[1]));  

    convertToLocalDateTime(dtFrom);
    convertToLocalDateTime(dtTo);
    return "${convertToLocalDateTime(dtFrom)} - ${convertToLocalDateTime(dtTo)}";
  }
  
  // ignore: non_constant_identifier_names
  static DateTime ConvertStringToDateTime(bool format, String dateTimeSt) {
    try {
      Logger().d("i parssed it $dateTimeSt");
      var dateFormat =
          DateFormat("yyyy-MM-dd hh:mm a"); // you can change the format here
      if (format) dateFormat = DateFormat("EEE,MMM dd hh:mm aa",(isArabicLang()?"ar":"en"));
      DateTime dateTime = dateFormat.parse(dateTimeSt);
      print(dateTime);
      return dateTime;
    } catch (e) {
      print(e);
      try {
        var dateFormat =
            DateFormat("EEE,MMM dd hh:mm aa",(isArabicLang()?"ar":"en")); // you can change the format here
        DateTime dateTime = dateFormat.parse(dateTimeSt);
        print(dateTime);
        return dateTime;
      } catch (e) {
        print(e);
        var dateFormat =
            DateFormat("yyyy-MM-dd hh:mm a"); // you can change the format here
        DateTime dateTime = dateFormat.parse(dateTimeSt);
        print(dateTime);
        return dateTime;
      }
    }
  }

  static DateTime convertLocalDateTimeToUTC(String localTime) {
    try {
      var dateFormat =
          DateFormat("yyyy-MM-dd hh:mm a"); // you can change the format here
      var dateFormat1 =
          DateFormat("yyyy-MM-dd HH:mm"); // you can change the format here
      DateTime dateUtc =
          DateTime.parse(dateFormat1.format(dateFormat.parse(localTime, true)))
              .toUtc();
      print('utc to localTime : $localTime');
      print("dateUtc1: $dateUtc");

      var createdDate = dateFormat1.format(dateUtc);
      print('utc convert : $createdDate');
      var createdDate1 = (DateTime.parse(createdDate));
      print('utc convert2 : $createdDate1');

      return createdDate1;
    } catch (e) {
      print(e);
      Logger().d(e);
      return DateTime.now();
    }
  }

  String ConvertUtcToLocalDateTime(DateTime utcDateTime) {
    try {
      DateTime dateNew = utcDateTime;
      dateNew = DateTime.utc(dateNew.year, dateNew.month, (dateNew.day),
          dateNew.hour, dateNew.minute);
      dateNew = dateNew.toLocal();
      var dateFormat2 =
          DateFormat("EEE,MMM dd hh:mm aa"); // you can change the format here
      String createdDate2 = dateFormat2.format(dateNew);
      return createdDate2;
    } catch (e) {
      print(e);
      Logger().d(e);
      return "";
    }
  }

  static DateTime convertUtcToLocalDateTimeDT(DateTime utcDateTime) {
    try {
      DateTime dateNew = utcDateTime;
      dateNew = DateTime.utc(dateNew.year, dateNew.month, (dateNew.day),
          dateNew.hour, dateNew.minute);
      dateNew = dateNew.toLocal();
      return dateNew;
    } catch (e) {
      print(e);
      Logger().d(e);
      return utcDateTime;
    }
  }

  static bool compareDateTimeToNow(DateTime utcDateTime) {
    ///todo don't forget convert to local
    DateTime dateNew = utcDateTime;
    dateNew = DateTime.utc(dateNew.year, dateNew.month, (dateNew.day),
        dateNew.hour, dateNew.minute);
    dateNew = dateNew.toLocal();
    DateTime currantDate = DateTime.now();
    return currantDate.isAtSameMomentAs(dateNew);
  }

  static String convertUtcToLocalDate(DateTime utcDateTime) {
    try {
      DateTime dateNew = utcDateTime;
      dateNew = DateTime.utc(dateNew.year, dateNew.month, (dateNew.day),
          dateNew.hour, dateNew.minute);
      dateNew = dateNew.toLocal();
      initializeDateFormatting(isArabicLang()?'ar':'en');
      // String languageCode = Localizations.localeOf(Get.context!).languageCode;
      var dateFormat2 = DateFormat( "EEE,dd MMM yyyy",isArabicLang()?'ar':'en');
      // var dateFormat2 = DateFormat("EEE,MMM dd"); // you can change the format here
      String createdDate2 = dateFormat2.format(dateNew);
      return createdDate2;
    } catch (e) {
      print(e);
      Logger().d(e);
      return "";
    }
  }

  static String convertUtcToLocalFullDate(DateTime utcDateTime) {
    try {
      DateTime dateNew = utcDateTime;
      dateNew = DateTime.utc(dateNew.year, dateNew.month, (dateNew.day),
          dateNew.hour, dateNew.minute);
      dateNew = dateNew.toLocal();
      initializeDateFormatting(isArabicLang()?'ar':'en');
      var dateFormat2 =
          DateFormat("EEE,MMM dd yyyy",(isArabicLang()?"ar":"en")); // you can change the format here
      String createdDate2 = dateFormat2.format(dateNew);
      return createdDate2;
    } catch (e) {
      print(e);
      Logger().d(e);
      return "";
    }
  }

  static String convertUtcToLocalTime(DateTime utcDateTime) {
    try {
      initializeDateFormatting(isArabicLang()?'ar':'en');
      DateTime dateNew = utcDateTime;
      dateNew = DateTime.utc(dateNew.year, dateNew.month, (dateNew.day),
          dateNew.hour, dateNew.minute);
      dateNew = dateNew.toLocal();
      var dateFormat2 = DateFormat("hh:mm a",(isArabicLang()?"ar":"en"));// you can change the format here
      String createdDate2 = dateFormat2.format(dateNew);
      return createdDate2;
    } catch (e) {
      print(e);
      Logger().d(e);
      return "";
    }
  }

  static TimeOfDay stringToTimeOfDay(String tod) {
    try {
      final format = DateFormat.Hm(); //"6:00 AM"
      return TimeOfDay.fromDateTime(format.parse(tod));
    } catch (e) {
      Logger().d(e);
      return TimeOfDay.now();
    }
  }

  static TimeOfDay stringToTimeOfDay24(String tod) {
    try {
      final format = DateFormat.Hm(); //"6:00 AM"
      return TimeOfDay.fromDateTime(format.parse(tod));
    } catch (e) {
      Logger().d(e);
      return TimeOfDay.now();
    }
  }

  static double toDoubleTimeOfDay(TimeOfDay myTime) {
    return myTime.hour + myTime.minute / 60.0;
  }

  static String getDifferanceBetweenTime(DateTime utcDateTime, {var min}) {
    try {
      DateTime dateNew = utcDateTime;
      dateNew = DateTime.utc(dateNew.year, dateNew.month, (dateNew.day),
          dateNew.hour, min ?? dateNew.minute);
      dateNew = dateNew.toLocal();
      DateTime currentDate = DateTime.now().toLocal();
      final timeInMilliSeconds = dateNew.difference(currentDate).inMilliseconds;
      final days = dateNew.difference(currentDate).inDays;
      final hours = dateNew.difference(currentDate).inHours;
      final minutes = dateNew.difference(currentDate).inMinutes;

      String time = "$days d ${hours % 24} h  ${minutes % 60} m";
      if (days <= 0 && hours <= 0) {
        time = "${minutes % 60} m";
      } else if (days <= 0) {
        time = "${hours % 24} h  ${minutes % 60} m";
      }
      return time;
    } catch (e) {
      print(e);
      Logger().d(e);
      return "";
    }
  }

  static String converToUtcTostring2(DateTime dates) {
    try {
      var dateLocal = dates.toLocal();
      String amPm = DateFormat.jm().format(DateFormat("hh:mm:ss")
          .parse("${dateLocal.hour}:${dateLocal.minute}:00"));

      return amPm;
    } catch (e) {
      print(e);
      Logger().d(e);
      return "";
    }
  }

  static String converToUtcTostring(String dates) {
    try {
      String timeToDate = dates;
      var dateTime = DateTime.parse(dates);
      var dateLocal = dateTime.toLocal();
      String amPm = DateFormat.jm().format(DateFormat("hh:mm:ss")
          .parse("${dateLocal.hour}:${dateLocal.minute}:00"));

      return amPm;
    } catch (e) {
      print(e);
      Logger().d(e);
      return "";
    }
  }

  static String currencyName() {
    Locale locale = Localizations.localeOf(Get.context!);
    var format = NumberFormat.simpleCurrency(locale: locale.toString());
    return '${format.currencyName}';
  }

  static String currencySymbol() {
    Locale locale = Localizations.localeOf(Get.context!);
    var format = NumberFormat.simpleCurrency(locale: locale.toString());
    return '${format.currencySymbol}';
  }

  static RegExp _timePattern =
      RegExp(r'(?<hour>\d+):(?<minute>\d+) (?<amPm>AM|PM)');

// timeString must be of the format "3:52:59 PM"
  static DateTime parseHoursInUtcUtil(String timeString) {
    try {
      final match = _timePattern.firstMatch(timeString);

      final hour = int.parse(match!.namedGroup('hour')!);
      final minute = int.parse(match.namedGroup('minute')!);
      // final second = int.parse(match.namedGroup('second'));
      final isPm = match.namedGroup('amPm') == 'PM';
      final now = DateTime.now().toUtc();
      return DateTime(
              now.year, now.month, now.day, isPm ? hour + 12 : hour, minute, 0)
          .toUtc();
    } catch (e) {
      print(e);
      Logger().d(e);
      return DateTime.now().toUtc();
    }
  }

  static compareToTime(TimeOfDay oneVal, TimeOfDay twoVal) {
    try {
      Logger().d("$oneVal  $twoVal");
      var format = DateFormat("HH:mm a");
      var one = format.parse(oneVal.format(Get.context!));
      var two = format.parse(twoVal.format(Get.context!));
      Logger().d("one $one");
      Logger().d("two $two");
      // return one.isBefore(two.subtract(Duration(days: 1)));
      return (one.hour < two.hour && one.minute <= two.minute);
    } catch (e) {
      print(e);
      Logger().d(e);
      return "";
    }
  }

  // static convertDateToNormal(var date) {
  //   try {
  //     var dateParsed = DateFormat("EEE,MMM dd").parse(date);
  //     return "${dateParsed.year.isLowerThan(DateTime.now().year) ? DateTime.now().year : dateParsed.year}-${dateParsed.month}-${dateParsed.day}";
  //   } catch (e) {
  //     print(e);
  //     Logger().d(e);
  //     var dateParsed = DateTime.parse(date.toString());
  //     return "${dateParsed.year}-${dateParsed.month}-${dateParsed.day}";
  //   }
  // }

  static convertDateTimeToAmPm(DateTime dateTime) {
    try {
      initializeDateFormatting(isArabicLang()?'ar':'en');
      return DateFormat("yyyy-MM-dd hh:mm a",(isArabicLang()?"ar":"en")).format(dateTime);
    } catch (e) {
      print(e);
      return DateTime.now();
    }
  }
}
