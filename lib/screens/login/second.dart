import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gamehub/api/firebase.dart';
import 'package:gamehub/utils/utils.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:time_range_picker/time_range_picker.dart';

class Second extends StatefulWidget {
  final PageController pageController;
  const Second({Key? key, required this.pageController}) : super(key: key);

  @override
  _SecondState createState() => _SecondState();
}

class _SecondState extends State<Second> {
  FirebaseApi firebaseApi = Get.find();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Obx(() => Container(
            color: context.isDarkMode ? Colors.grey[800] : Colors.white,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Material(
                          color: context.isDarkMode
                              ? Colors.grey[900]
                              : Colors.grey[200],
                          borderRadius: BorderRadius.circular(10),
                          child: InkWell(
                            onTap: () {
                              widget.pageController.animateToPage(3,
                                  duration: Duration(milliseconds: 250),
                                  curve: Curves.linear);
                            },
                            borderRadius: BorderRadius.circular(10),
                            child: Padding(
                              padding: const EdgeInsets.all(12),
                              child: Row(
                                children: [
                                  Icon(Icons.arrow_back_ios_rounded),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    'Geri',
                                    style: TextStyle(fontSize: 20),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Text(
                    'Yaşadığım yer',
                    style: GoogleFonts.roboto(
                        fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      children: [
                        Expanded(
                          child: Material(
                            borderRadius: BorderRadius.circular(20),
                            color: context.isDarkMode
                                ? Colors.grey[900]
                                : Colors.grey[200],
                            child: InkWell(
                              borderRadius: BorderRadius.circular(20),
                              onTap: () {
                                showCupertinoModalPopup(
                                  barrierColor:
                                      Colors.grey[200]!.withOpacity(0.65),
                                  filter:
                                      ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                                  context: context,
                                  builder: (context) {
                                    return Container(
                                      child: Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            10, 10, 10, 0),
                                        child: FutureBuilder<
                                            QuerySnapshot<
                                                Map<String, dynamic>>>(
                                          future: firebaseApi.getCountries(),
                                          builder: (context, snapshot) {
                                            return snapshot.hasData
                                                ? ListView.builder(
                                                    padding: EdgeInsets.zero,
                                                    physics:
                                                        BouncingScrollPhysics(),
                                                    itemCount: snapshot
                                                        .data!.docs.length,
                                                    itemBuilder:
                                                        (context, index) {
                                                      return Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(2),
                                                        child: Material(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(20),
                                                          color: context
                                                                  .isDarkMode
                                                              ? Colors.grey[900]
                                                              : Colors
                                                                  .grey[200],
                                                          child: InkWell(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          20),
                                                              onTap: () {
                                                                firebaseApi
                                                                    .countrySelected
                                                                    .value = true;
                                                                firebaseApi
                                                                    .country
                                                                    .value = snapshot
                                                                        .data!
                                                                        .docs[
                                                                    index]['name'];
                                                                firebaseApi.city
                                                                        .value =
                                                                    'Şehir';
                                                                firebaseApi
                                                                    .chechToQuestion2();
                                                                Get.back();
                                                              },
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .all(17),
                                                                child: Text(
                                                                  snapshot.data!
                                                                              .docs[
                                                                          index]
                                                                      ['name'],
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          18),
                                                                ),
                                                              )),
                                                        ),
                                                      );
                                                    },
                                                  )
                                                : Container();
                                          },
                                        ),
                                      ),
                                      width: double.maxFinite,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.4,
                                      decoration: BoxDecoration(
                                          color: context.isDarkMode
                                              ? Colors.black
                                              : Colors.grey[50],
                                          borderRadius: BorderRadius.vertical(
                                              top: Radius.circular(20))),
                                    );
                                  },
                                );
                              },
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(15),
                                  child: Text(
                                    firebaseApi.country.value,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.roboto(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: Text(
                            '-',
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                        Expanded(
                          child: Material(
                            borderRadius: BorderRadius.circular(20),
                            color: context.isDarkMode
                                ? Colors.grey[900]
                                : Colors.grey[200],
                            child: InkWell(
                              borderRadius: BorderRadius.circular(20),
                              onTap: firebaseApi.countrySelected.value
                                  ? () {
                                      showCupertinoModalPopup(
                                        barrierColor:
                                            Colors.grey[200]!.withOpacity(0.65),
                                        filter: ImageFilter.blur(
                                            sigmaX: 2, sigmaY: 2),
                                        context: context,
                                        builder: (context) {
                                          return Container(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      10, 10, 10, 0),
                                              child:
                                                  FutureBuilder<List<String>>(
                                                future: firebaseApi.getCities(
                                                    firebaseApi.country.value),
                                                builder: (context, snapshot) {
                                                  return snapshot.hasData
                                                      ? ListView.builder(
                                                          padding:
                                                              EdgeInsets.zero,
                                                          physics:
                                                              BouncingScrollPhysics(),
                                                          itemCount: snapshot
                                                              .data!.length,
                                                          itemBuilder:
                                                              (context, index) {
                                                            return Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(2),
                                                              child: Material(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            20),
                                                                color: context
                                                                        .isDarkMode
                                                                    ? Colors.grey[
                                                                        900]
                                                                    : Colors.grey[
                                                                        200],
                                                                child: InkWell(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            20),
                                                                    onTap: () {
                                                                      firebaseApi
                                                                          .city
                                                                          .value = snapshot
                                                                              .data![
                                                                          index];
                                                                      firebaseApi
                                                                          .chechToQuestion2();
                                                                      Get.back();
                                                                    },
                                                                    child:
                                                                        Padding(
                                                                      padding:
                                                                          const EdgeInsets.all(
                                                                              17),
                                                                      child:
                                                                          Text(
                                                                        snapshot
                                                                            .data![index],
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                18),
                                                                      ),
                                                                    )),
                                                              ),
                                                            );
                                                          },
                                                        )
                                                      : Container();
                                                },
                                              ),
                                            ),
                                            width: double.maxFinite,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.4,
                                            decoration: BoxDecoration(
                                                color: context.isDarkMode
                                                    ? Colors.black
                                                    : Colors.grey[50],
                                                borderRadius:
                                                    BorderRadius.vertical(
                                                        top: Radius.circular(
                                                            20))),
                                          );
                                        },
                                      );
                                    }
                                  : null,
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(15),
                                  child: Text(
                                    firebaseApi.city.value,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: firebaseApi.countrySelected.value
                                        ? GoogleFonts.roboto(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold)
                                        : GoogleFonts.roboto(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.grey),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Material(
                          borderRadius: BorderRadius.circular(20),
                          color: context.isDarkMode
                              ? Colors.grey[900]
                              : Colors.grey[200],
                          child: InkWell(
                            onTap: () async {
                              LocationPermission permission =
                                  await Geolocator.checkPermission();
                              if (permission.index == 0) {
                                await Geolocator.requestPermission();
                              } else {
                                Position position =
                                    await Geolocator.getCurrentPosition();

                                List<Placemark> placemarks =
                                    await placemarkFromCoordinates(
                                        position.latitude, position.longitude);
                                firebaseApi.country.value =
                                    placemarks.first.country!;
                                firebaseApi.city.value =
                                    placemarks.first.administrativeArea!;
                              }
                            },
                            borderRadius: BorderRadius.circular(20),
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.all(15),
                                child: Icon(Icons.location_on_rounded),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Text(
                    'Oynadığım platformlar',
                    style: GoogleFonts.roboto(
                        fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: context.isDarkMode
                            ? Colors.grey[900]
                            : Colors.grey[200],
                        borderRadius: BorderRadius.circular(20)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 20),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              firebaseApi.pc.value = !firebaseApi.pc.value;
                              firebaseApi.chechToQuestion2();
                            },
                            onLongPress: () {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                      content: Row(
                                children: [
                                  Text(
                                    'PC platformu',
                                    style: GoogleFonts.roboto(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              )));
                            },
                            child: CircleAvatar(
                              backgroundColor: firebaseApi.pc.value
                                  ? Colors.green
                                  : Colors.white,
                              child: firebaseApi.pc.value
                                  ? Center(
                                      child: Padding(
                                        padding: const EdgeInsets.all(6),
                                        child: Image.asset('assets/pc.png'),
                                      ),
                                    )
                                  : Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(90),
                                          color: Colors.grey.withOpacity(0.7)),
                                      child: Center(
                                        child: Padding(
                                          padding: const EdgeInsets.all(6),
                                          child: Image.asset('assets/pc.png'),
                                        ),
                                      ),
                                    ),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          GestureDetector(
                            onTap: () {
                              firebaseApi.ps.value = !firebaseApi.ps.value;
                              firebaseApi.chechToQuestion2();
                            },
                            onLongPress: () {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                      content: Row(
                                children: [
                                  Text(
                                    'PlayStation platformu',
                                    style: GoogleFonts.roboto(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              )));
                            },
                            child: CircleAvatar(
                              backgroundColor: firebaseApi.ps.value
                                  ? Colors.green
                                  : Colors.white,
                              child: firebaseApi.ps.value
                                  ? Center(
                                      child: Padding(
                                        padding: const EdgeInsets.all(6),
                                        child: Image.asset('assets/ps.png'),
                                      ),
                                    )
                                  : Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(90),
                                          color: Colors.grey.withOpacity(0.7)),
                                      child: Center(
                                        child: Padding(
                                          padding: const EdgeInsets.all(6),
                                          child: Image.asset('assets/ps.png'),
                                        ),
                                      ),
                                    ),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          GestureDetector(
                            onTap: () {
                              firebaseApi.mobile.value =
                                  !firebaseApi.mobile.value;
                              firebaseApi.chechToQuestion2();
                            },
                            onLongPress: () {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                      content: Row(
                                children: [
                                  Text(
                                    'Mobil platform',
                                    style: GoogleFonts.roboto(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              )));
                            },
                            child: CircleAvatar(
                              backgroundColor: firebaseApi.mobile.value
                                  ? Colors.green
                                  : Colors.white,
                              child: firebaseApi.mobile.value
                                  ? Center(
                                      child: Padding(
                                        padding: const EdgeInsets.all(6),
                                        child: Image.asset(
                                            'assets/mobil-icon.png'),
                                      ),
                                    )
                                  : Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(90),
                                          color: Colors.grey.withOpacity(0.7)),
                                      child: Center(
                                        child: Padding(
                                          padding: const EdgeInsets.all(6),
                                          child: Image.asset(
                                              'assets/mobil-icon.png'),
                                        ),
                                      ),
                                    ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Text(
                      'Oyun içi iletişim',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.roboto(
                          fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: firebaseApi.headphone.value &&
                                    firebaseApi.headpressed.value
                                ? Colors.green
                                : context.isDarkMode
                                    ? Colors.grey[900]
                                    : Colors.grey[200],
                            borderRadius: BorderRadius.circular(20)),
                        child: Padding(
                          padding: EdgeInsets.all(12),
                          child: InkWell(
                            onTap: () {
                              firebaseApi.headphone.value = true;
                              firebaseApi.headpressed.value = true;
                            },
                            child: SizedBox(
                              width: 120,
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 40,
                                    width: 40,
                                    child: Image.asset('assets/headset.png'),
                                  ),
                                  SizedBox(
                                    height: 3,
                                  ),
                                  Text(
                                    'Sesli',
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.roboto(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Text(
                          'V',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: !firebaseApi.headphone.value &&
                                    firebaseApi.headpressed.value
                                ? Colors.green
                                : context.isDarkMode
                                    ? Colors.grey[900]
                                    : Colors.grey[200],
                            borderRadius: BorderRadius.circular(20)),
                        child: Padding(
                          padding: EdgeInsets.all(12),
                          child: InkWell(
                            onTap: () {
                              firebaseApi.headphone.value = false;
                              firebaseApi.headpressed.value = true;
                            },
                            child: SizedBox(
                              width: 120,
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 40,
                                    width: 40,
                                    child: Image.asset('assets/chat.png'),
                                  ),
                                  SizedBox(
                                    height: 3,
                                  ),
                                  Text(
                                    'Mesajlaşma',
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.roboto(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Text(
                      'Oyun saatlerim',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.roboto(
                          fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () async {
                          TimeRange time = await showTimeRangePicker(
                              context: context,
                              padding: 50,
                              strokeWidth: 8,
                              fromText: 'Başlangıç',
                              toText: 'Bitiş',
                              handlerColor: Colors.green[300],
                              strokeColor: Colors.purple,
                              end: TimeOfDay(
                                  hour: firebaseApi.endHour.value,
                                  minute: firebaseApi.endMinute.value),
                              handlerRadius: 15,
                              labels: [
                                ClockLabel(angle: 0, text: '18:00'),
                                ClockLabel(angle: 1.55, text: '00:00'),
                                ClockLabel(angle: 3.15, text: '06:00'),
                                ClockLabel(angle: 4.7, text: '12:00'),
                              ],
                              backgroundWidget: CircleAvatar(
                                radius: 100,
                                backgroundColor: Colors.transparent,
                                child: Padding(
                                  padding: EdgeInsets.all(20),
                                  child: Image.asset('assets/orta.png'),
                                ),
                              ),
                              ticks: 12,
                              autoAdjustLabels: true,
                              backgroundColor: Colors.red,
                              selectedColor: Colors.green,
                              disabledColor: Colors.grey,
                              start: TimeOfDay(
                                  hour: firebaseApi.startHour.value,
                                  minute: firebaseApi.startMinute.value));
                          if (time != null) {
                            firebaseApi.startHour.value = time.startTime.hour;
                            firebaseApi.startMinute.value =
                                time.startTime.minute;
                            firebaseApi.endHour.value = time.endTime.hour;
                            firebaseApi.endMinute.value = time.endTime.minute;
                            firebaseApi.chechToQuestion2();
                            // firebaseApi.firestore
                            //     .collection('Users')
                            //     .doc(firebaseApi.auth.currentUser!.uid)
                            //     .collection('Rosettes')
                            //     .where('name', isEqualTo: Utils.aktifsaatleriniduzenleme['name']!)
                            //     .get()
                            //     .then((value) {
                            //   if (value.docs.isEmpty) {
                            //     firebaseApi.exp = firebaseApi.exp + 150;
                            //     Get.snackbar('Başarı kazandın', Utils.aktifsaatleriniduzenleme['name']!,
                            //         icon: Padding(
                            //           padding: const EdgeInsets.symmetric(horizontal: 5),
                            //           child: Icon(
                            //             Icons.emoji_events_outlined,
                            //             size: 35,
                            //           ),
                            //         ));
                            //     firebaseApi.firestore.collection('Users').doc(firebaseApi.auth.currentUser!.uid).collection('Rosettes').add({
                            //       'name': Utils.aktifsaatleriniduzenleme['name']!,
                            //       'photo': Utils.aktifsaatleriniduzenleme['photo']!,
                            //     });
                            //   }
                            // });
                          }
                        },
                        child: Container(
                          child: Padding(
                            padding: const EdgeInsets.all(15),
                            child: Text(
                              firebaseApi.startMinute.value < 10
                                  ? '${firebaseApi.startHour.value}:0${firebaseApi.startMinute.value}'
                                  : '${firebaseApi.startHour.value}:${firebaseApi.startMinute.value}',
                              style: GoogleFonts.rationale(fontSize: 30),
                            ),
                          ),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: context.isDarkMode
                                  ? Colors.grey[900]
                                  : Colors.grey[300]),
                        ),
                      ),
                      Text(
                        ' - ',
                        style: GoogleFonts.rationale(fontSize: 30),
                      ),
                      GestureDetector(
                        onTap: () async {
                          TimeRange time = await showTimeRangePicker(
                              context: context,
                              padding: 50,
                              strokeWidth: 8,
                              fromText: 'Başlangıç',
                              toText: 'Bitiş',
                              handlerColor: Colors.green[300],
                              strokeColor: Colors.purple,
                              end: TimeOfDay(
                                  hour: firebaseApi.endHour.value,
                                  minute: firebaseApi.endMinute.value),
                              handlerRadius: 15,
                              labels: [
                                ClockLabel(angle: 0, text: '18:00'),
                                ClockLabel(angle: 1.55, text: '00:00'),
                                ClockLabel(angle: 3.15, text: '06:00'),
                                ClockLabel(angle: 4.7, text: '12:00'),
                              ],
                              backgroundWidget: CircleAvatar(
                                radius: 100,
                                backgroundColor: Colors.transparent,
                                child: Padding(
                                  padding: EdgeInsets.all(20),
                                  child: Image.asset('assets/orta.png'),
                                ),
                              ),
                              ticks: 12,
                              autoAdjustLabels: true,
                              backgroundColor: Colors.red,
                              selectedColor: Colors.green,
                              disabledColor: Colors.grey,
                              start: TimeOfDay(
                                  hour: firebaseApi.startHour.value,
                                  minute: firebaseApi.startMinute.value));
                          if (time != null) {
                            firebaseApi.startHour.value = time.startTime.hour;
                            firebaseApi.startMinute.value =
                                time.startTime.minute;
                            firebaseApi.endHour.value = time.endTime.hour;
                            firebaseApi.endMinute.value = time.endTime.minute;
                            firebaseApi.chechToQuestion2();
                            // firebaseApi.firestore
                            //     .collection('Users')
                            //     .doc(firebaseApi.auth.currentUser!.uid)
                            //     .collection('Rosettes')
                            //     .where('name', isEqualTo: Utils.aktifsaatleriniduzenleme['name']!)
                            //     .get()
                            //     .then((value) {
                            //   if (value.docs.isEmpty) {
                            //     firebaseApi.exp = firebaseApi.exp + 150;
                            //     Get.snackbar('Başarı kazandın', Utils.aktifsaatleriniduzenleme['name']!,
                            //         icon: Padding(
                            //           padding: const EdgeInsets.symmetric(horizontal: 5),
                            //           child: Icon(
                            //             Icons.emoji_events_outlined,
                            //             size: 35,
                            //           ),
                            //         ));
                            //     firebaseApi.firestore.collection('Users').doc(firebaseApi.auth.currentUser!.uid).collection('Rosettes').add({
                            //       'name': Utils.aktifsaatleriniduzenleme['name']!,
                            //       'photo': Utils.aktifsaatleriniduzenleme['photo']!,
                            //     });
                            //   }
                            // });
                          }
                        },
                        child: Container(
                          child: Padding(
                            padding: const EdgeInsets.all(15),
                            child: Text(
                              firebaseApi.endMinute.value < 10
                                  ? '${firebaseApi.endHour.value}:0${firebaseApi.endMinute.value}'
                                  : '${firebaseApi.endHour.value}:${firebaseApi.endMinute.value}',
                              style: GoogleFonts.rationale(fontSize: 30),
                            ),
                          ),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: context.isDarkMode
                                  ? Colors.grey[900]
                                  : Colors.grey[300]),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Material(
                          color: context.isDarkMode
                              ? Colors.grey[900]
                              : Colors.grey[200],
                          borderRadius: BorderRadius.circular(10),
                          child: InkWell(
                            onTap: firebaseApi.toQuestions2.value
                                ? () {
                                    if (firebaseApi.avatar.value ==
                                        'assets/user.png') {
                                      Get.snackbar('Avatar seçilmedi',
                                          'Devam etmek için avatar seçiniz');
                                    } else {
                                      widget.pageController.animateToPage(5,
                                          duration: Duration(milliseconds: 250),
                                          curve: Curves.linear);
                                    }
                                  }
                                : null,
                            borderRadius: BorderRadius.circular(10),
                            child: Padding(
                              padding: const EdgeInsets.all(12),
                              child: Row(
                                children: [
                                  Text(
                                    'İleri',
                                    style: TextStyle(fontSize: 20),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Icon(Icons.arrow_forward_ios_rounded),
                                ],
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  firebaseApi.country.value == 'Ülke' ||
                          firebaseApi.city.value == 'Şehir'
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 2),
                              child: Icon(
                                Icons.error_outline,
                                color: Colors.red[800],
                              ),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text('Lütfen konum girin',
                                style: GoogleFonts.roboto(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red[800])),
                            SizedBox(
                              width: 20,
                            ),
                          ],
                        )
                      : Container(),
                  SizedBox(
                    height: 5,
                  ),
                  !firebaseApi.pc.value &&
                          !firebaseApi.ps.value &&
                          !firebaseApi.mobile.value
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 2),
                              child: Icon(
                                Icons.error_outline,
                                color: Colors.red[800],
                              ),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text('Lütfen platform seçin',
                                style: GoogleFonts.roboto(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red[800])),
                            SizedBox(
                              width: 20,
                            ),
                          ],
                        )
                      : Container(),
                  SizedBox(
                    height: 5,
                  ),
                  firebaseApi.startHour.value == 00 &&
                          firebaseApi.startMinute.value == 00 &&
                          firebaseApi.endHour.value == 00 &&
                          firebaseApi.endMinute.value == 00
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 2),
                              child: Icon(
                                Icons.error_outline,
                                color: Colors.red[800],
                              ),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text('Lütfen oyun saati seçin',
                                style: GoogleFonts.roboto(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red[800])),
                            SizedBox(
                              width: 20,
                            ),
                          ],
                        )
                      : Container(),
                  SizedBox(
                    height: 5,
                  ),
                  !firebaseApi.headpressed.value
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 2),
                              child: Icon(
                                Icons.error_outline,
                                color: Colors.red[800],
                              ),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text('Lütfen oyun içi iletişim seçin',
                                style: GoogleFonts.roboto(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red[800])),
                            SizedBox(
                              width: 20,
                            ),
                          ],
                        )
                      : Container(),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
              physics: BouncingScrollPhysics(),
            ),
          )),
    );
  }
}
