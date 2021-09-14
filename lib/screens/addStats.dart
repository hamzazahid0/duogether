import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:gamehub/api/firebase.dart';
import 'package:gamehub/getx/addStatsGetx.dart';
import 'package:gamehub/screens/newLevel.dart';
import 'package:gamehub/utils/utils.dart';
import 'package:get/get.dart';
import 'package:radar_chart/radar_chart.dart' as radar;
import 'package:google_fonts/google_fonts.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

class AddStats extends StatefulWidget {
  const AddStats({Key? key}) : super(key: key);

  @override
  _AddStatsState createState() => _AddStatsState();
}

class _AddStatsState extends State<AddStats> {
  FirebaseApi firebaseApi = Get.find();
  AddStatsGetx addStatsGetx = Get.put(AddStatsGetx());
  TextEditingController controller = TextEditingController();
  TextEditingController level = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.isDarkMode ? Colors.black : Colors.white,
      body: SafeArea(
        child: Stack(
          fit: StackFit.expand,
          children: [
            Container(
              child: Obx(() => addStatsGetx.game.value == 'Oyun seçin'
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/games.png',
                            height: 70,
                            width: 70,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 30),
                            child: Text(
                              'Tecrübe eklemek için oyun seçin',
                              maxLines: 2,
                              textAlign: TextAlign.center,
                              style: GoogleFonts.roboto(
                                  fontSize: 30,
                                  color: context.isDarkMode
                                      ? Colors.white
                                      : Colors.black),
                            ),
                          ),
                        ],
                      ),
                    )
                  : SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      child: Column(
                        children: [
                          // SizedBox(
                          //   height: 600,
                          //   width: double.maxFinite,
                          //   child: Padding(
                          //     padding: const EdgeInsets.only(bottom: 10,left: 5,right: 5,top: 80),
                          //     child: Material(
                          //                     borderRadius: BorderRadius.circular(20),
                          //                     elevation: 12,
                          //                     child: ClipRRect(
                          //                       borderRadius:
                          //                           BorderRadius.circular(20),
                          //                       child: Image.network(
                          //                           addStatsGetx.image.value,fit: BoxFit.cover,),
                          //                     )),
                          //   ),
                          // ),
                          SizedBox(
                            height: 80,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: context.isDarkMode
                                      ? Colors.grey[900]
                                      : Colors.grey[200]),
                              child: Padding(
                                padding: EdgeInsets.all(8),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text('Deneyim',
                                          style: GoogleFonts.roboto(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold)),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        // Material(
                                        //     borderRadius: BorderRadius.circular(20),
                                        //     elevation: 12,
                                        //     child: ClipRRect(
                                        //       borderRadius:
                                        //           BorderRadius.circular(20),
                                        //       child: Image.network(
                                        //           addStatsGetx.image.value),
                                        //     )),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            // SleekCircularSlider(
                                            //   min: 0,
                                            //   max: 5,
                                            //   innerWidget: (data) => Center(
                                            //       child: Text(
                                            //           '${addStatsGetx.stage.value}',
                                            //           style: GoogleFonts.economica(
                                            //               fontSize: 22))),
                                            //   appearance: CircularSliderAppearance(
                                            //       spinnerMode: false,
                                            //       startAngle: 170,
                                            //       angleRange: 200,
                                            //       customColors: CustomSliderColors(
                                            //           dynamicGradient: false,
                                            //           progressBarColors: [
                                            //             Color(0xFFFF0080),
                                            //             Color(0xFFFF8C00),
                                            //             Color(0xFF40E0D0)
                                            //           ])),
                                            //   initialValue: addStatsGetx.exp.value,
                                            //   onChange: (data) {
                                            //     addStatsGetx.exp.value = data;
                                            //     addStatsGetx.setStage();
                                            //   },
                                            // ),
                                            SizedBox(
                                              height: 10,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.85,
                                              child: SfSlider(
                                                  min: 0.0,
                                                  max: 3.0,
                                                  stepSize: 1.0,
                                                  interval: 1,
                                                  value: addStatsGetx.exp.value,
                                                  onChanged: (data) {
                                                    addStatsGetx.exp.value =
                                                        data;
                                                  }),
                                            ),
                                            SizedBox(
                                              height: 50,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.75,
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                      child: Text('Acemi',
                                                          textAlign: TextAlign
                                                              .center)),
                                                  Container(
                                                    width: 1,
                                                    height: 10,
                                                    color: Colors.grey,
                                                  ),
                                                  Expanded(
                                                      child: Text('Ortalama',
                                                          textAlign: TextAlign
                                                              .center)),
                                                  Container(
                                                    width: 1,
                                                    height: 10,
                                                    color: Colors.grey,
                                                  ),
                                                  Expanded(
                                                      child: Text(
                                                    'Uzman',
                                                    textAlign: TextAlign.center,
                                                  )),
                                                  Container(
                                                    width: 1,
                                                    height: 10,
                                                    color: Colors.grey,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            addStatsGetx.hasLevels.value
                                                ? Container(
                                                    width: 100,
                                                    height: 40,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadiusDirectional
                                                                .circular(10),
                                                        color: Colors.white
                                                            .withOpacity(0.2)),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              0),
                                                      child: TextField(
                                                        textAlign:
                                                            TextAlign.center,
                                                        keyboardType:
                                                            TextInputType
                                                                .number,
                                                        controller: level,
                                                        decoration:
                                                            InputDecoration(
                                                                hintText:
                                                                    'Seviye',
                                                                border:
                                                                    InputBorder
                                                                        .none),
                                                      ),
                                                    ),
                                                  )
                                                : Container()
                                            // Text('Tecrübe',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: context.isDarkMode?Colors.white:Colors.black),)
                                          ],
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          GestureDetector(
                            onTap: () async {
                              var time = await DatePicker.showDatePicker(
                                context,
                                maxTime: DateTime.now(),
                                currentTime: DateTime.now(),
                                onConfirm: (date) {
                                  addStatsGetx.date.value =
                                      '${date.year}-${date.month}-${date.day}';
                                  addStatsGetx.dateTime.value = date;
                                  addStatsGetx.dateSelected.value = true;
                                },
                                locale: LocaleType.tr,
                                theme: DatePickerTheme(
                                    containerHeight: 300,
                                    headerColor: context.isDarkMode
                                        ? Colors.black
                                        : Colors.white,
                                    backgroundColor: context.isDarkMode
                                        ? Colors.grey[900]!
                                        : Colors.grey[200]!,
                                    itemStyle: TextStyle(
                                        color: context.isDarkMode
                                            ? Colors.white
                                            : Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                    cancelStyle: TextStyle(
                                      color: context.isDarkMode
                                          ? Colors.white
                                          : Colors.black,
                                      fontSize: 18,
                                    ),
                                    doneStyle: TextStyle(
                                        color: context.isDarkMode
                                            ? Colors.white
                                            : Colors.black,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold)),
                              );
                            },
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              child: Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: context.isDarkMode
                                        ? Colors.grey[900]
                                        : Colors.grey[200]),
                                child: Padding(
                                  padding: const EdgeInsets.all(15),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      !addStatsGetx.dateSelected.value
                                          ? Text('Nezaman başladım')
                                          : Container(),
                                      SizedBox(
                                        height: 8,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(addStatsGetx.date.value,
                                              style: GoogleFonts.roboto(
                                                  fontSize: 24,
                                                  fontWeight: FontWeight.bold)),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 3),
                                            child: Icon(
                                                Icons.calendar_today_rounded),
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                        height: 8,
                                      ),
                                      addStatsGetx.dateSelected.value
                                          ? Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text('Oynadığım süre:'),
                                                Text(
                                                  '${Utils().getGameTime(addStatsGetx.dateTime.value)}',
                                                  style:
                                                      TextStyle(fontSize: 20),
                                                ),
                                              ],
                                            )
                                          : Container(),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          addStatsGetx.hasStats.value
                              ? Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15),
                                  child: Obx(
                                    () => Container(
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          color: context.isDarkMode
                                              ? Colors.grey[900]
                                              : Colors.grey[200]),
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 20, left: 20),
                                                child: Text('Uzmanlık',
                                                    style: GoogleFonts.roboto(
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.bold)),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 300,
                                            width: 300,
                                            child: Stack(
                                              children: [
                                                PieChart(PieChartData(
                                                    centerSpaceRadius: 100,
                                                    sections: [
                                                      PieChartSectionData(
                                                        color: Colors.green,
                                                        value: addStatsGetx
                                                                .g.value +
                                                            0.1,
                                                        showTitle: false,
                                                        radius: 20,
                                                      ),
                                                      PieChartSectionData(
                                                        color: Colors.red,
                                                        value: addStatsGetx
                                                                .r.value +
                                                            0.1,
                                                        showTitle: false,
                                                        radius: 20,
                                                      ),
                                                      PieChartSectionData(
                                                        color: Colors.blue,
                                                        value: addStatsGetx
                                                                .b.value +
                                                            0.1,
                                                        showTitle: false,
                                                        radius: 20,
                                                      ),
                                                      PieChartSectionData(
                                                        color: Colors.yellow,
                                                        value: addStatsGetx
                                                                .y.value +
                                                            0.1,
                                                        showTitle: false,
                                                        radius: 20,
                                                      ),
                                                      PieChartSectionData(
                                                        color: Colors.orange,
                                                        value: addStatsGetx
                                                                .o.value +
                                                            0.1,
                                                        showTitle: false,
                                                        radius: 20,
                                                      ),
                                                      PieChartSectionData(
                                                        color: Colors.purple,
                                                        value: addStatsGetx
                                                                .p.value +
                                                            0.1,
                                                        showTitle: false,
                                                        radius: 20,
                                                      ),
                                                    ])),
                                                Center(
                                                  child: SizedBox(
                                                    height: 200,
                                                    width: 200,
                                                    child: Center(
                                                      child: radar.RadarChart(
                                                        radius: 80,
                                                        length: 6,
                                                        backgroundColor: Colors
                                                            .white
                                                            .withOpacity(0.2),
                                                        radialColor: Colors.grey
                                                            .withOpacity(0.1),
                                                        radialStroke: 1.5,
                                                        radars: [
                                                          radar.RadarTile(
                                                            values: [
                                                              addStatsGetx
                                                                  .r.value,
                                                              addStatsGetx
                                                                  .o.value,
                                                              addStatsGetx
                                                                  .p.value,
                                                              addStatsGetx
                                                                  .g.value,
                                                              addStatsGetx
                                                                  .b.value,
                                                              addStatsGetx
                                                                  .y.value
                                                            ],
                                                            borderStroke: 2,
                                                            borderColor:
                                                                Colors.purple,
                                                            backgroundColor:
                                                                Colors.purple
                                                                    .withOpacity(
                                                                        0.4),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              SleekCircularSlider(
                                                min: 0.35,
                                                max: 1,
                                                innerWidget: (data) => Center(
                                                    child: Text(
                                                        '${addStatsGetx.yellow.value}',
                                                        style: GoogleFonts
                                                            .poiretOne(
                                                                fontSize: 22,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold))),
                                                appearance:
                                                    CircularSliderAppearance(
                                                        size: 120,
                                                        spinnerMode: false,
                                                        startAngle: 135,
                                                        angleRange: 270,
                                                        customColors:
                                                            CustomSliderColors(
                                                                dynamicGradient:
                                                                    false,
                                                                progressBarColor:
                                                                    Colors
                                                                        .yellow)),
                                                initialValue:
                                                    addStatsGetx.y.value,
                                                onChange: (data) {
                                                  addStatsGetx.y.value = data;
                                                },
                                              ),
                                              SleekCircularSlider(
                                                min: 0.35,
                                                max: 1,
                                                innerWidget: (data) => Center(
                                                    child: Text(
                                                        '${addStatsGetx.red.value}',
                                                        style: GoogleFonts
                                                            .poiretOne(
                                                                fontSize: 22,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold))),
                                                appearance:
                                                    CircularSliderAppearance(
                                                        size: 120,
                                                        spinnerMode: false,
                                                        startAngle: 135,
                                                        angleRange: 270,
                                                        customColors:
                                                            CustomSliderColors(
                                                                dynamicGradient:
                                                                    false,
                                                                progressBarColor:
                                                                    Colors
                                                                        .red)),
                                                initialValue:
                                                    addStatsGetx.r.value,
                                                onChange: (data) {
                                                  addStatsGetx.r.value = data;
                                                },
                                              )
                                            ],
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              SleekCircularSlider(
                                                min: 0.35,
                                                max: 1,
                                                innerWidget: (data) => Center(
                                                    child: Text(
                                                        '${addStatsGetx.orange.value}',
                                                        style: GoogleFonts
                                                            .poiretOne(
                                                                fontSize: 22,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold))),
                                                appearance:
                                                    CircularSliderAppearance(
                                                        size: 120,
                                                        spinnerMode: false,
                                                        startAngle: 135,
                                                        angleRange: 270,
                                                        customColors:
                                                            CustomSliderColors(
                                                                dynamicGradient:
                                                                    false,
                                                                progressBarColor:
                                                                    Colors
                                                                        .orange)),
                                                initialValue:
                                                    addStatsGetx.o.value,
                                                onChange: (data) {
                                                  addStatsGetx.o.value = data;
                                                },
                                              ),
                                              SleekCircularSlider(
                                                min: 0.35,
                                                max: 1,
                                                innerWidget: (data) => Center(
                                                    child: Text(
                                                        '${addStatsGetx.purple.value}',
                                                        style: GoogleFonts
                                                            .poiretOne(
                                                                fontSize: 22,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold))),
                                                appearance:
                                                    CircularSliderAppearance(
                                                        size: 120,
                                                        spinnerMode: false,
                                                        startAngle: 135,
                                                        angleRange: 270,
                                                        customColors:
                                                            CustomSliderColors(
                                                                dynamicGradient:
                                                                    false,
                                                                progressBarColor:
                                                                    Colors
                                                                        .purple)),
                                                initialValue:
                                                    addStatsGetx.p.value,
                                                onChange: (data) {
                                                  addStatsGetx.p.value = data;
                                                },
                                              )
                                            ],
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              SleekCircularSlider(
                                                min: 0.35,
                                                max: 1,
                                                innerWidget: (data) => Center(
                                                    child: Text(
                                                        '${addStatsGetx.green.value}',
                                                        style: GoogleFonts
                                                            .poiretOne(
                                                                fontSize: 22,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold))),
                                                appearance:
                                                    CircularSliderAppearance(
                                                        size: 120,
                                                        spinnerMode: false,
                                                        startAngle: 135,
                                                        angleRange: 270,
                                                        customColors:
                                                            CustomSliderColors(
                                                                dynamicGradient:
                                                                    false,
                                                                progressBarColor:
                                                                    Colors
                                                                        .green)),
                                                initialValue:
                                                    addStatsGetx.g.value,
                                                onChange: (data) {
                                                  addStatsGetx.g.value = data;
                                                },
                                              ),
                                              SleekCircularSlider(
                                                min: 0.35,
                                                max: 1,
                                                innerWidget: (data) => Center(
                                                    child: Text(
                                                        '${addStatsGetx.blue.value}',
                                                        style: GoogleFonts
                                                            .poiretOne(
                                                                fontSize: 22,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold))),
                                                appearance:
                                                    CircularSliderAppearance(
                                                        size: 120,
                                                        spinnerMode: false,
                                                        startAngle: 135,
                                                        angleRange: 270,
                                                        customColors:
                                                            CustomSliderColors(
                                                                dynamicGradient:
                                                                    false,
                                                                progressBarColor:
                                                                    Colors
                                                                        .blue)),
                                                initialValue:
                                                    addStatsGetx.b.value,
                                                onChange: (data) {
                                                  addStatsGetx.b.value = data;
                                                },
                                              )
                                            ],
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 5, horizontal: 20),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadiusDirectional
                                                          .circular(20),
                                                  color: Colors.white
                                                      .withOpacity(0.2)),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: TextField(
                                                  controller: controller,
                                                  decoration: InputDecoration(
                                                      hintText:
                                                          'Oyun stili ve aradığın oyuncu tipi gibi bilgileri yazarak doğru kişiyi bul.',
                                                      border: InputBorder.none),
                                                  maxLines: 3,
                                                  maxLength: 100,
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 100,
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                              : Container()
                        ],
                      ),
                    )),
            ),
            Positioned(
              bottom: 15,
              left: 15,
              right: 15,
              child: Obx(
                () => Material(
                  elevation: 10,
                  borderRadius: BorderRadius.circular(15),
                  color: addStatsGetx.game.value == 'Oyun seçin'
                      ? Colors.grey[900]
                      : Colors.green[600],
                  child: InkWell(
                    onTap: addStatsGetx.game.value == 'Oyun seçin'
                        ? null
                        : () {
                            if (addStatsGetx.hasLevels.value) {
                              if (level.text == '') {
                                Get.snackbar('Tüm boşlukları doldurun',
                                    'Oyun içi seviye girin');
                                return;
                              }
                            }
                            if (addStatsGetx.date.value == 'Tarih seçin') {
                              Get.snackbar('Tüm boşlukları doldurun',
                                  'Oyun süresini girin ');
                              return;
                            }
                            Get.back();
                            FirebaseFirestore.instance
                                .collection('Users')
                                .doc(FirebaseAuth.instance.currentUser!.uid)
                                .collection('Stats')
                                .add({
                              'name': addStatsGetx.game.value,
                              'photo': addStatsGetx.image.value,
                              'exp': addStatsGetx.exp.value,
                              'stage': addStatsGetx.stage.value,
                              'green': addStatsGetx.green.value,
                              'red': addStatsGetx.red.value,
                              'yellow': addStatsGetx.yellow.value,
                              'blue': addStatsGetx.blue.value,
                              'orange': addStatsGetx.orange.value,
                              'purple': addStatsGetx.purple.value,
                              'r': addStatsGetx.r.value,
                              'g': addStatsGetx.g.value,
                              'y': addStatsGetx.y.value,
                              'b': addStatsGetx.b.value,
                              'o': addStatsGetx.o.value,
                              'p': addStatsGetx.p.value,
                              'hasLevels': addStatsGetx.hasLevels.value,
                              'hasStats': addStatsGetx.hasStats.value,
                              'level': level.text.toString(),
                              'time': Utils()
                                  .getGameTime(addStatsGetx.dateTime.value),
                              'info': controller.text.toString()
                            });
                            firebaseApi.firestore
                                .collection('Users')
                                .doc(firebaseApi.auth.currentUser!.uid)
                                .collection('Rosettes')
                                .where('name',
                                    isEqualTo:
                                        Utils.aktifsaatleriniduzenleme['name']!)
                                .get()
                                .then((value) async {
                              if (value.docs.isEmpty) {
                                Get.snackbar('Başarı kazandın',
                                    Utils.aktifsaatleriniduzenleme['name']!,
                                    icon: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 5),
                                      child: Icon(
                                        Icons.emoji_events_outlined,
                                        size: 35,
                                      ),
                                    ));
                                await firebaseApi.firestore
                                    .collection('Users')
                                    .doc(firebaseApi.auth.currentUser!.uid)
                                    .collection('Rosettes')
                                    .add({
                                  'name':
                                      Utils.aktifsaatleriniduzenleme['name']!,
                                  'photo':
                                      Utils.aktifsaatleriniduzenleme['photo']!,
                                });
                                await firebaseApi.firestore
                                    .collection('Users')
                                    .doc(firebaseApi.auth.currentUser!.uid)
                                    .get()
                                    .then((value) async {
                                  int exp = value.data()!['exp'];
                                  int level = value.data()!['level'];
                                  int newExp = exp + 100;
                                  int newLevel = Utils().getLevel(newExp);
                                  await firebaseApi.firestore
                                      .collection('Users')
                                      .doc(firebaseApi.auth.currentUser!.uid)
                                      .update({'exp': newExp});
                                  if (level != newLevel) {
                                    //yeni seviyye
                                    await firebaseApi.firestore
                                        .collection('Users')
                                        .doc(firebaseApi.auth.currentUser!.uid)
                                        .update({'level': newLevel});
                                    Get.to(() => NewLevel(level: newLevel));
                                  }
                                });
                              }
                            });
                          },
                    borderRadius: BorderRadius.circular(15),
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Center(
                          child: Text(
                        'Ekle',
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      )),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 10,
              right: 10,
              left: 10,
              child: Row(
                children: [
                  Material(
                    elevation: 10,
                    borderRadius: BorderRadius.circular(15),
                    color: context.isDarkMode
                        ? Colors.grey[900]
                        : Colors.grey[200],
                    child: InkWell(
                      onTap: () {
                        Get.back();
                      },
                      borderRadius: BorderRadius.circular(15),
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Icon(Icons.arrow_back_outlined),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 7,
                  ),
                  Expanded(
                    child: Obx(
                      () => Material(
                        elevation: 10,
                        color: context.isDarkMode
                            ? Colors.grey[900]
                            : Colors.grey[200],
                        borderRadius: BorderRadius.circular(15),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(15),
                          onTap: () {
                            showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              builder: (context) {
                                return Container(
                                  width: double.maxFinite,
                                  height: Get.size.height * 0.8,
                                  color: context.isDarkMode
                                      ? Colors.grey[900]
                                      : Colors.white,
                                  child: Column(
                                    children: [
                                      Container(
                                        height: 50,
                                        width: double.infinity,
                                        color: context.isDarkMode
                                            ? Colors.black
                                            : Colors.grey[200],
                                        child: Row(
                                          children: [
                                            SizedBox(
                                              width: 10,
                                            ),
                                            TextButton(
                                                onPressed: () {
                                                  Get.back();
                                                },
                                                child: Text(
                                                  'İptal',
                                                  style: TextStyle(
                                                      fontSize: 19,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: context.isDarkMode
                                                          ? Colors.white
                                                          : Colors.black),
                                                )),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                          child:
                                              FutureBuilder<
                                                      QuerySnapshot<
                                                          Map<String,
                                                              dynamic>>>(
                                                  future: firebaseApi.firestore
                                                      .collection('Users')
                                                      .doc(firebaseApi.auth
                                                          .currentUser!.uid)
                                                      .collection('Games')
                                                      .get(),
                                                  builder: (context, snapshot) {
                                                    var games;
                                                    if (snapshot.hasData) {
                                                      games =
                                                          snapshot.data!.docs;
                                                    }
                                                    return snapshot.hasData
                                                        ? snapshot.data!.docs
                                                                    .length ==
                                                                0
                                                            ? Center(
                                                                child: Column(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    Image.asset(
                                                                      'assets/about/game.png',
                                                                      height:
                                                                          70,
                                                                      width: 70,
                                                                      color: context.isDarkMode
                                                                          ? Colors
                                                                              .white
                                                                          : Colors
                                                                              .black,
                                                                    ),
                                                                    Text(
                                                                      'Oyun eklenmedi',
                                                                      style: GoogleFonts.roboto(
                                                                          fontSize:
                                                                              30,
                                                                          color: context.isDarkMode
                                                                              ? Colors.white
                                                                              : Colors.black),
                                                                    ),
                                                                  ],
                                                                ),
                                                              )
                                                            : FutureBuilder<
                                                                    QuerySnapshot<
                                                                        Map<String,
                                                                            dynamic>>>(
                                                                future: FirebaseFirestore
                                                                    .instance
                                                                    .collection(
                                                                        'Users')
                                                                    .doc(firebaseApi
                                                                        .auth
                                                                        .currentUser!
                                                                        .uid)
                                                                    .collection(
                                                                        'Stats')
                                                                    .get(),
                                                                builder:
                                                                    (context,
                                                                        added) {
                                                                  if (added
                                                                      .hasData) {
                                                                    List<String>
                                                                        myaccounts =
                                                                        [];
                                                                    added.data!
                                                                        .docs
                                                                        .forEach(
                                                                            (element) {
                                                                      myaccounts.add(
                                                                          element
                                                                              .data()['name']);
                                                                    });
                                                                    games.removeWhere(
                                                                        (element) {
                                                                      if (myaccounts
                                                                          .contains(
                                                                              element.data()['name'])) {
                                                                        return true;
                                                                      } else {
                                                                        return false;
                                                                      }
                                                                    });
                                                                  }
                                                                  return !added
                                                                          .hasData
                                                                      ? Container()
                                                                      : games.length ==
                                                                              0
                                                                          ? Center(
                                                                              child: Column(
                                                                                mainAxisAlignment: MainAxisAlignment.center,
                                                                                children: [
                                                                                  Image.asset(
                                                                                    'assets/about/game.png',
                                                                                    height: 70,
                                                                                    width: 70,
                                                                                    color: context.isDarkMode ? Colors.white : Colors.black,
                                                                                  ),
                                                                                  Text(
                                                                                    'Tüm oyunları ekledin',
                                                                                    style: GoogleFonts.roboto(fontSize: 30, color: context.isDarkMode ? Colors.white : Colors.black),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            )
                                                                          : ListView
                                                                              .builder(
                                                                              itemCount: games.length,
                                                                              physics: BouncingScrollPhysics(),
                                                                              itemBuilder: (context, index) {
                                                                                return Padding(
                                                                                  padding: const EdgeInsets.all(8.0),
                                                                                  child: Material(
                                                                                    borderRadius: BorderRadius.circular(20),
                                                                                    color: context.isDarkMode ? Colors.grey[900] : Colors.grey[200],
                                                                                    child: InkWell(
                                                                                      onTap: () {
                                                                                        addStatsGetx.game.value = games[index].data()['name'];
                                                                                        addStatsGetx.image.value = games[index].data()['photo'];
                                                                                        addStatsGetx.red.value = games[index].data()['red'];
                                                                                        addStatsGetx.green.value = games[index].data()['green'];
                                                                                        addStatsGetx.blue.value = games[index].data()['blue'];
                                                                                        addStatsGetx.yellow.value = games[index].data()['yellow'];
                                                                                        addStatsGetx.orange.value = games[index].data()['orange'];
                                                                                        addStatsGetx.purple.value = games[index].data()['purple'];
                                                                                        addStatsGetx.hasLevels.value = games[index].data()['hasLevels'];
                                                                                        addStatsGetx.hasStats.value = games[index].data()['hasStats'];
                                                                                        addStatsGetx.selected.value = true;
                                                                                        Get.back();
                                                                                      },
                                                                                      borderRadius: BorderRadius.circular(20),
                                                                                      child: Container(
                                                                                        child: Row(
                                                                                          children: [
                                                                                            SizedBox(
                                                                                              width: 10,
                                                                                            ),
                                                                                            CircleAvatar(
                                                                                              backgroundColor: Colors.grey[300],
                                                                                              backgroundImage: NetworkImage(games[index].data()['photo'] == null ? '' : games[index].data()['photo']),
                                                                                              radius: 25,
                                                                                            ),
                                                                                            SizedBox(
                                                                                              width: 20,
                                                                                            ),
                                                                                            Expanded(
                                                                                                child: Padding(
                                                                                              padding: const EdgeInsets.symmetric(vertical: 10),
                                                                                              child: Column(
                                                                                                mainAxisAlignment: MainAxisAlignment.center,
                                                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                                                children: [
                                                                                                  Expanded(
                                                                                                    child: Align(
                                                                                                      alignment: Alignment.centerLeft,
                                                                                                      child: Text(
                                                                                                        games[index].data()['name'],
                                                                                                        textAlign: TextAlign.center,
                                                                                                        maxLines: 1,
                                                                                                        style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                                                                                                      ),
                                                                                                    ),
                                                                                                  ),
                                                                                                ],
                                                                                              ),
                                                                                            ))
                                                                                          ],
                                                                                        ),
                                                                                        height: 70,
                                                                                        decoration: BoxDecoration(
                                                                                          borderRadius: BorderRadius.circular(20),
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                );
                                                                              },
                                                                            );
                                                                })
                                                        : Container();
                                                  }))
                                    ],
                                  ),
                                );
                              },
                            );
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 15),
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: 10,
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width -
                                          200,
                                      child: Text(
                                        addStatsGetx.game.value,
                                        style: TextStyle(
                                            fontSize: 22,
                                            fontWeight: FontWeight.w600,
                                            color: context.isDarkMode
                                                ? Colors.white
                                                : Colors.black),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              addStatsGetx.game.value == 'Oyun seçin'
                                  ? Container()
                                  : Align(
                                      alignment: Alignment.centerRight,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10),
                                        child: IconButton(
                                            onPressed: () {
                                              addStatsGetx.game.value =
                                                  'Oyun seçin';
                                            },
                                            icon: Icon(Icons.cancel)),
                                      ),
                                    )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
