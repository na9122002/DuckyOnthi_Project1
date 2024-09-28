// ignore_for_file: dead_code
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:html/parser.dart';

Future<void> parseData() async {
  const String url =
      'https://lichvn.net/xem-tu-vi-tron-doi-tuoi-giap-ty-1.html';
  Dio dio = Dio();
  var response = await dio.get(
    url,
    options: Options(
      headers: {'cookie': 'any_cookie'},
      // method: 'POST',
    ),
  );
  //print the data to console.
  if (kDebugMode) {
    print('_alexTR_logging_: response : $response');
  }
  // set document
  var document = parse(response.data);
  // ket qua
  List<String> resultsJson = [];
  //declaring a list of String to hold all the data.
  List<String> data = [];
  var boxTuvi = document.getElementsByClassName("chitiet_hd");
  var boxDapAn = document.getElementsByTagName("tr");
  String ten = '';
  String a = '';
  String nam = '';
  String cung = '';
  String truc = '';
  String mang = '';
  String khac = '';
  String connha = '';
  String xuong = '';
  String tuong = '';
  String domang = '';
  String tongquat = '';
  String cuocsong = '';
  String tinhduyen = '';
  String giadao = '';
  String tuoihop = '';
  String vochong = '';
  String tuoiky = '';
  String namkhokhan = '';
  String gioxuathanh = '';
  String dientien = '';
  String check = '';

  // resultsJson = '[{"id": $i,"question":"Có bao nhiêt cách chọn ra 3 học sinh từ một nhóm có 5 học sinh?","image": "","trueAnswer": "C_{5}^{3}","falseAnswer1": "5!","falseAnwser2": "A_{5}^{3}","falseAnwer3": "5^{3}"},';
  if (boxTuvi.isNotEmpty) {
    if (boxTuvi[0].getElementsByTagName('p') != null &&
        boxTuvi[0].getElementsByTagName('p').length >= 12) {
      //for answer A
      var Ten = boxTuvi[0].getElementsByTagName('p')[1];
      if (Ten != null) {
        ten = Ten.innerHtml;
        // ten.replaceAll(RegExp('\\b${RegExp.escape(e.key)}\\b'), e.value)
      }
      //for answer B
      var A = boxTuvi[0].getElementsByTagName('p')[1];
      if (A != null) {
        a = A.innerHtml;
      }
      //for answer C
      var Nam = boxTuvi[0].getElementsByTagName('p')[1];
      if (Nam != null) {
        nam = Nam.innerHtml;
      }

      //for answer B
      var Cung = boxTuvi[0].getElementsByTagName('p')[1];
      if (Cung != null) {
        cung = Cung.innerHtml;
      }
      var Truc = boxTuvi[0].getElementsByTagName('p')[1];
      if (Truc != null) {
        truc = Truc.innerHtml;
      }
      var Mang = boxTuvi[0].getElementsByTagName('p')[1];
      if (Mang != null) {
        mang = Mang.innerHtml;
      }
      var Khac = boxTuvi[0].getElementsByTagName('p')[1];
      if (Khac != null) {
        khac = Khac.innerHtml;
      }
      var Connha = boxTuvi[0].getElementsByTagName('p')[1];
      if (Connha != null) {
        connha = Connha.innerHtml;
      }
      var Xuong = boxTuvi[0].getElementsByTagName('p')[1];
      if (Xuong != null) {
        xuong = Xuong.innerHtml;
      }
      var Tuong = boxTuvi[0].getElementsByTagName('p')[1];
      if (Tuong != null) {
        tuong = Tuong.innerHtml;
      }
      var Domang = boxTuvi[0].getElementsByTagName('p')[1];
      if (Domang != null) {
        domang = Domang.innerHtml;
      }
      var Cuocsong = boxTuvi[0].getElementsByTagName('p')[4];
      if (Cuocsong != null) {
        cuocsong = Cuocsong.innerHtml;
      }
      var Tinhduyen = boxTuvi[0].getElementsByTagName('p')[5];
      if (Tinhduyen != null) {
        tinhduyen = Tinhduyen.innerHtml;
      }
      var Giadao = boxTuvi[0].getElementsByTagName('p')[6];
      if (Giadao != null) {
        giadao = Giadao.innerHtml;
      }
      var Tuoihop = boxTuvi[0].getElementsByTagName('p')[7];
      if (Tuoihop != null) {
        tuoihop = Tuoihop.innerHtml;
      }
      var Tuoiky = boxTuvi[0].getElementsByTagName('p')[8];
      if (Tuoiky != null) {
        tuoiky = Tuoiky.innerHtml;
      }
      var Vochong = boxTuvi[0].getElementsByTagName('p')[9];
      if (Vochong != null) {
        vochong = Vochong.innerHtml;
      }
      var Namkhokhan = boxTuvi[0].getElementsByTagName('p')[10];
      if (Namkhokhan != null) {
        namkhokhan = Namkhokhan.innerHtml;
      }
      var Gioxuathanh = boxTuvi[0].getElementsByTagName('p')[11];
      if (Gioxuathanh != null) {
        gioxuathanh = Gioxuathanh.innerHtml;
      }
      var Dientien = boxTuvi[0].getElementsByTagName('p')[12];
      if (Dientien != null) {
        dientien = Dientien.innerHtml;
      }
      // var Check = boxTuvi[0].getElementsByTagName('p')[12];
      // if (Check != null) {
      //   check = Check.innerHtml;
      // }
    }
  }
  if (kDebugMode) {
    debugPrint(
        'cuocsong:"${cuocsong}",tinhduyen:"${tinhduyen}",giadao:"${giadao}",tuoihop:"${tuoihop}",vochong: "${vochong}", tuoiky: "${tuoiky}",namkhokhan:"${namkhokhan}",gioxuathanh:"${gioxuathanh}",dientien: "${dientien}",check: "",',
        wrapWidth: 1090);
  }
  // if (boxVanDap.isNotEmpty) {
  //   for (int i = 0; i < 50; i++) {
  //     //     if (boxVanDap[i].getElementsByTagName('a') != null &&
  //     //         boxVanDap[i].getElementsByTagName('a').isNotEmpty) {
  //     //       var questionTagA = boxVanDap[i].getElementsByTagName('a')[0];
  //     //       if (questionTagA != null &&
  //     //           questionTagA.getElementsByClassName('underline') != null &&
  //     //           questionTagA.getElementsByClassName('underline').isNotEmpty) {
  //     //         question = questionTagA.getElementsByClassName('underline')[0].innerHtml;
  //     //         if (kDebugMode) {
  //     //           print('_alexTR_logging_: question : ${question.trim()}');
  //     //         }
  //     //       }
  //     //     }

  //     if (boxVanDap[i].getElementsByTagName('a') != null &&
  //         boxVanDap[i].getElementsByTagName('a').length >= 0) {
  //       var Quesion1 = boxVanDap[i].getElementsByTagName('a')[0];
  //       if (Quesion1 != null) {
  //         var attrs = Quesion1.attributes['title'];
  //         if (attrs != null && attrs.isNotEmpty) {
  //           question.add(attrs.trim());
  //         }
  //       }
  //     }
  //     // if (boxVanDap[i].getElementsByTagName('a') != null &&
  //     //     boxVanDap[i].getElementsByTagName('a').isNotEmpty) {
  //     //   var questionTagA = boxVanDap[i].getElementsByTagName('a')[0];
  //     //   if (questionTagA != null &&
  //     //       questionTagA.getElementsByClassName('underline') != null &&
  //     //       questionTagA.getElementsByClassName('underline').isNotEmpty) {
  //     //     question.add(questionTagA
  //     //         .getElementsByClassName('underline')[0]
  //     //         .innerHtml
  //     //         .trim());
  //     //     // if (kDebugMode) {
  //     //     //   print('_alexTR_logging_: question : ${question}');
  //     //     // }
  //     //   }
  //     // }
  //     //image:
  //     if (boxVanDap[i].getElementsByTagName('img') != null &&
  //         boxVanDap[i].getElementsByTagName('img').length > 0) {
  //       var image1 = boxVanDap[i].getElementsByTagName('img')[0];
  //       if (image1 != null) {
  //         var attrs = image1.attributes['src'];
  //         if (attrs != null && attrs.isNotEmpty) {
  //           image.add(attrs.trim());
  //         }
  //       }
  //     } else {
  //       image.add("");
  //     }
  //     // answer A,b,c,d
  //     if (boxVanDap[i].getElementsByTagName('p') != null &&
  //         boxVanDap[i].getElementsByTagName('p').length > 0) {
  //       //for answer A
  //       var answerAHtml = boxVanDap[i].getElementsByTagName('p')[0];
  //       if (answerAHtml != null) {
  //         answerA.add(answerAHtml.innerHtml.trim());
  //       }
  //       //for answer B
  //       var answerBHtml = boxVanDap[i].getElementsByTagName('p')[1];
  //       if (answerBHtml != null) {
  //         answerB.add(answerBHtml.innerHtml.trim());
  //       }
  //       //for answer C
  //       var answerCHtml = boxVanDap[i].getElementsByTagName('p')[2];
  //       if (answerCHtml != null) {
  //         answerC.add(answerCHtml.innerHtml.trim());
  //       }
  //       //for answer D
  //       var answerDHtml = boxVanDap[i].getElementsByTagName('p')[3];
  //       if (answerDHtml != null) {
  //         answerD.add(answerDHtml.innerHtml.trim());
  //       }
  //     }
  //   }
  // }
  // if (kDebugMode) {
  //   print('THANNNNNNNNNNNNNNNNNN');
  // }
  // for (int i = 0; i < 50; i++) {
  //   if (DapAn[i] == "A") {
  //     resultsJson.add(
  //         '{"id": "${i + 1}   ","question":"${question[i]}","image": "${image[i]}","trueAnswer": "${answerA[i]}","falseAnswer1": "${answerB[i]}","falseAnwser2": "${answerC[i]}","falseAnwer3": "${answerD[i]}"},');
  //   } else if (DapAn[i] == "B") {
  //     resultsJson.add(
  //         '{"id": "${i + 1}","question":"${question[i]}","image": "${image[i]}","trueAnswer": "${answerB[i]}","falseAnswer1": "${answerA[i]}","falseAnwser2": "${answerC[i]}","falseAnwer3": "${answerD[i]}"},');
  //   } else if (DapAn[i] == "C") {
  //     resultsJson.add(
  //         '{"id": "${i + 1}","question":"${question[i]}","image": "${image[i]}","trueAnswer": "${answerC[i]}","falseAnswer1": "${answerA[i]}","falseAnwser2": "${answerB[i]}","falseAnwer3": "${answerD[i]}"},');
  //   } else if (DapAn[i] == "D") {
  //     resultsJson.add(
  //         '{"id": "${i + 1}","question":"${question[i]}","image": "${image[i]}","trueAnswer": "${answerD[i]}","falseAnswer1": "${answerA[i]}","falseAnwser2": "${answerC[i]}","falseAnwer3": "${answerB[i]}"},');
  //   }
  // }
  // for (int i = 0; i < 40; i++) {
  //   if (DapAn[i] == "A") {
  //     resultsJson.add(
  //         '{"id": "${i + 1}   ","question":"${question[i]}","trueAnswer": "${answerA[i]}","falseAnswer1": "${answerB[i]}","falseAnwser2": "${answerC[i]}","falseAnwer3": "${answerD[i]}"},');
  //   } else if (DapAn[i] == "B") {
  //     resultsJson.add(
  //         '{"id": "${i + 1}","question":"${question[i]}","trueAnswer": "${answerB[i]}","falseAnswer1": "${answerA[i]}","falseAnwser2": "${answerC[i]}","falseAnwer3": "${answerD[i]}"},');
  //   } else if (DapAn[i] == "C") {
  //     resultsJson.add(
  //         '{"id": "${i + 1}","question":"${question[i]}","trueAnswer": "${answerC[i]}","falseAnswer1": "${answerA[i]}","falseAnwser2": "${answerB[i]}","falseAnwer3": "${answerD[i]}"},');
  //   } else if (DapAn[i] == "D") {
  //     resultsJson.add(
  //         '{"id": "${i + 1}","question":"${question[i]}","trueAnswer": "${answerD[i]}","falseAnswer1": "${answerA[i]}","falseAnwser2": "${answerC[i]}","falseAnwer3": "${answerB[i]}"},');
  //   }
  // }
  for (int i = 0; i < 50; i++) {
    if (kDebugMode) {
      print('NGA:${resultsJson[i]}');

      // print('NGAAAA :${DapAn[i]}');
    }
  }
  return;
  data.add(document.getElementsByClassName("box-van-dap")[0].innerHtml);
  //declaring variable for temp since we will be using it multiple places
  var temp = document.getElementsByClassName("temp")[0];
  data.add(temp.innerHtml.substring(0, temp.innerHtml.indexOf("<span>")));
  data.add(temp
      .getElementsByTagName("small")[0]
      .innerHtml
      .replaceAll(RegExp("[(|)|℃]"), ""));

  //We can also do document.getElementsByTagName("td") but I am just being more specific here.
  var rows =
      document.getElementsByTagName("table")[0].getElementsByTagName("td");
//Map elememt to its innerHtml,  because we gonna need it.
  //Iterate over all the table-data and store it in the data list
  rows.map((e) => e.innerHtml).forEach((element) {
    if (element != "-") {
      data.add(element);
    }
  });

  //print the data to console.
  if (kDebugMode) {
    print('_alexTR_logging_: data : $data');
  }
}
