import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gamehub/api/firebase.dart';
import 'package:gamehub/getx/filterGetx.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'package:tcard/tcard.dart';

class FilterPage extends StatefulWidget {
  final TCardController controller;
  const FilterPage({Key? key, required this.controller}) : super(key: key);

  @override
  _FilterPageState createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
  FilterGetx filterGetx = Get.find();
  FirebaseApi firebaseApi = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Get.isDarkMode ? Colors.black : Colors.white,
      appBar: AppBar(
        title: Text(
          'Filtreler',
          style: GoogleFonts.roboto(
              color: context.isDarkMode ? Colors.white : Colors.black,
              fontWeight: FontWeight.w600,
              fontSize: 25),
        ),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(20))),
        centerTitle: true,
        backgroundColor: context.isDarkMode ? Colors.grey[900] : Colors.white,
      ),
      body: Center(
        child: Container(
          width: Get.width * 0.85,
          height: Get.height,
          child: Column(
            children: [
              Expanded(
                flex: 4,
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Yaş aralığı',
                          style: GoogleFonts.roboto(
                              fontSize: 22, fontWeight: FontWeight.w500),
                        ),
                      ),
                      Obx(
                        () => Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: context.isDarkMode
                                ? Colors.grey[900]
                                : Colors.grey[200],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SfRangeSlider(
                              values: filterGetx.age.value,
                              onChanged: (value) {
                                filterGetx.age.value = value;
                                filterGetx.filtered.value = true;
                              },
                              max: 51.0,
                              min: 16.0,
                              interval: 5.0,
                              showTicks: true,
                              activeColor: Colors.green,
                              enableTooltip: true,
                              minorTicksPerInterval: 1,
                              showLabels: true,
                              stepSize: 1.0,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 5),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Cinsiyet',
                          style: GoogleFonts.roboto(
                              fontSize: 22, fontWeight: FontWeight.w500),
                        ),
                      ),
                      Obx(
                        () => Container(
                          child: Row(
                            children: [
                              Flexible(
                                child: GestureDetector(
                                  onTap: () {
                                    filterGetx.sex.value = 'f';
                                    filterGetx.filtered.value = true;
                                  },
                                  child: Container(
                                    height: 50,
                                    child: Center(
                                      child: Padding(
                                        padding: const EdgeInsets.all(5),
                                        child: AutoSizeText(
                                          'Kadın',
                                          minFontSize: 14,
                                          maxLines: 2,
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.roboto(
                                              fontSize: 16,
                                              color: filterGetx.sex.value == 'f'
                                                  ? Colors.white
                                                  : Colors.black),
                                        ),
                                      ),
                                    ),
                                    decoration: BoxDecoration(
                                        color: filterGetx.sex.value == 'f'
                                            ? Colors.green
                                            : Colors.transparent,
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                  ),
                                ),
                                flex: 1,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Flexible(
                                child: GestureDetector(
                                  onTap: () {
                                    filterGetx.sex.value = 'n';
                                    filterGetx.filtered.value = true;
                                  },
                                  child: Container(
                                    height: 50,
                                    child: Center(
                                      child: Padding(
                                        padding: const EdgeInsets.all(5),
                                        child: AutoSizeText(
                                          'Herkes',
                                          maxLines: 2,
                                          minFontSize: 14,
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.roboto(
                                              fontSize: 16,
                                              color: filterGetx.sex.value == 'n'
                                                  ? Colors.white
                                                  : Colors.black),
                                        ),
                                      ),
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: filterGetx.sex.value == 'n'
                                          ? Colors.green
                                          : Colors.transparent,
                                    ),
                                  ),
                                ),
                                flex: 1,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Flexible(
                                child: GestureDetector(
                                  onTap: () {
                                    filterGetx.sex.value = 'o';
                                    filterGetx.filtered.value = true;
                                  },
                                  child: Container(
                                    height: 50,
                                    child: Center(
                                      child: Padding(
                                        padding: const EdgeInsets.all(5),
                                        child: AutoSizeText(
                                          'Diğer',
                                          maxLines: 2,
                                          minFontSize: 14,
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.roboto(
                                              fontSize: 16,
                                              color: filterGetx.sex.value == 'o'
                                                  ? Colors.white
                                                  : Colors.black),
                                        ),
                                      ),
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: filterGetx.sex.value == 'o'
                                          ? Colors.green
                                          : Colors.transparent,
                                    ),
                                  ),
                                ),
                                flex: 1,
                              ),
                              const SizedBox(width: 5),
                              Flexible(
                                child: GestureDetector(
                                  onTap: () {
                                    filterGetx.sex.value = 'm';
                                    filterGetx.filtered.value = true;
                                  },
                                  child: Container(
                                    height: 50,
                                    child: Center(
                                      child: Padding(
                                        padding: const EdgeInsets.all(5),
                                        child: AutoSizeText(
                                          'Erkek',
                                          maxLines: 2,
                                          minFontSize: 14,
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.roboto(
                                              fontSize: 16,
                                              color: filterGetx.sex.value == 'm'
                                                  ? Colors.white
                                                  : Colors.black),
                                        ),
                                      ),
                                    ),
                                    decoration: BoxDecoration(
                                        color: filterGetx.sex.value == 'm'
                                            ? Colors.green
                                            : Colors.transparent,
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                  ),
                                ),
                                flex: 1,
                              ),
                            ],
                          ),
                          width: double.maxFinite,
                          height: 50,
                          decoration: BoxDecoration(
                              color: context.isDarkMode
                                  ? Colors.grey[700]
                                  : Colors.grey[300],
                              borderRadius: BorderRadius.circular(20)),
                        ),
                      ),
                      const SizedBox(height: 5),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Oyunlar',
                          style: GoogleFonts.roboto(
                              fontSize: 22, fontWeight: FontWeight.w500),
                        ),
                      ),
                      Obx(
                        () => Material(
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
                                              const SizedBox(width: 10),
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
                                                        color:
                                                            context.isDarkMode
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
                                                    future: firebaseApi
                                                        .firestore
                                                        .collection('Users')
                                                        .doc(firebaseApi.auth
                                                            .currentUser!.uid)
                                                        .collection('Games')
                                                        .get(),
                                                    builder:
                                                        (context, snapshot) {
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
                                                                      Image
                                                                          .asset(
                                                                        'assets/about/game.png',
                                                                        height:
                                                                            70,
                                                                        width:
                                                                            70,
                                                                        color: context.isDarkMode
                                                                            ? Colors.white
                                                                            : Colors.black,
                                                                      ),
                                                                      Text(
                                                                        'Oyun eklenmedi',
                                                                        style: GoogleFonts.roboto(
                                                                            fontSize:
                                                                                25,
                                                                            color: context.isDarkMode
                                                                                ? Colors.white
                                                                                : Colors.black),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                )
                                                              : ListView
                                                                  .builder(
                                                                  itemCount:
                                                                      snapshot
                                                                          .data!
                                                                          .docs
                                                                          .length,
                                                                  physics:
                                                                      BouncingScrollPhysics(),
                                                                  itemBuilder:
                                                                      (context,
                                                                          index) {
                                                                    return Padding(
                                                                      padding:
                                                                          const EdgeInsets.all(
                                                                              8.0),
                                                                      child:
                                                                          Material(
                                                                        borderRadius:
                                                                            BorderRadius.circular(20),
                                                                        color: context.isDarkMode
                                                                            ? Colors.grey[900]
                                                                            : Colors.grey[200],
                                                                        child:
                                                                            InkWell(
                                                                          onTap:
                                                                              () {
                                                                            filterGetx.game.value =
                                                                                snapshot.data!.docs[index].data()['name'];
                                                                            filterGetx.filtered.value =
                                                                                true;
                                                                            Get.back();
                                                                          },
                                                                          borderRadius:
                                                                              BorderRadius.circular(20),
                                                                          child:
                                                                              Container(
                                                                            child:
                                                                                Row(
                                                                              children: [
                                                                                SizedBox(
                                                                                  width: 10,
                                                                                ),
                                                                                CircleAvatar(
                                                                                  backgroundColor: Colors.grey[300],
                                                                                  backgroundImage: NetworkImage(snapshot.data!.docs[index].data()['photo'] == null ? '' : snapshot.data!.docs[index].data()['photo']),
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
                                                                                            snapshot.data!.docs[index].data()['name'],
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
                                                                            height:
                                                                                70,
                                                                            decoration:
                                                                                BoxDecoration(
                                                                              borderRadius: BorderRadius.circular(20),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    );
                                                                  },
                                                                )
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
                                SizedBox(
                                  height: 45,
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width: 10,
                                      ),
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width -
                                                180,
                                        child: Text(
                                          filterGetx.game.value,
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w600,
                                              color: context.isDarkMode
                                                  ? Colors.white
                                                  : Colors.black),
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 2,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                filterGetx.game.value == 'Oyun seçin'
                                    ? const SizedBox()
                                    : Align(
                                        alignment: Alignment.centerRight,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10),
                                          child: IconButton(
                                            onPressed: () {
                                              filterGetx.game.value =
                                                  'Oyun seçin';
                                            },
                                            icon: Icon(Icons.cancel),
                                            iconSize: 22,
                                          ),
                                        ),
                                      )
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 5),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Oyun içi iletişim',
                          style: GoogleFonts.roboto(
                              fontSize: 22, fontWeight: FontWeight.w500),
                        ),
                      ),
                      Obx(
                        () => Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  color: filterGetx.headphone.value &&
                                          filterGetx.headpressed.value
                                      ? Colors.green
                                      : context.isDarkMode
                                          ? Colors.grey[900]
                                          : Colors.grey[200],
                                  borderRadius: BorderRadius.circular(20)),
                              child: InkWell(
                                onTap: () {
                                  if (!filterGetx.headpressed.value) {
                                    filterGetx.headpressed.value = true;
                                    filterGetx.filtered.value = true;
                                    filterGetx.headphone.value = true;
                                  } else {
                                    if (filterGetx.headphone.value) {
                                      filterGetx.headpressed.value = false;
                                      filterGetx.filtered.value = false;
                                    } else {
                                      filterGetx.headpressed.value = true;
                                      filterGetx.filtered.value = true;
                                      filterGetx.headphone.value = true;
                                    }
                                  }
                                },
                                child: SizedBox(
                                  width: 120,
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 40,
                                        width: 40,
                                        child:
                                            Image.asset('assets/headset.png'),
                                      ),
                                      const SizedBox(height: 3),
                                      Text(
                                        'Sesli',
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.roboto(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              child: Text(
                                'V',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  color: !filterGetx.headphone.value &&
                                          filterGetx.headpressed.value
                                      ? Colors.green
                                      : context.isDarkMode
                                          ? Colors.grey[900]
                                          : Colors.grey[200],
                                  borderRadius: BorderRadius.circular(20)),
                              child: Padding(
                                padding: EdgeInsets.all(10),
                                child: InkWell(
                                  onTap: () {
                                    if (!filterGetx.headpressed.value) {
                                      filterGetx.headpressed.value = true;
                                      filterGetx.filtered.value = true;
                                      filterGetx.headphone.value = false;
                                    } else {
                                      if (!filterGetx.headphone.value) {
                                        filterGetx.headpressed.value = false;
                                        filterGetx.filtered.value = false;
                                      } else {
                                        filterGetx.headpressed.value = true;
                                        filterGetx.filtered.value = true;
                                        filterGetx.headphone.value = false;
                                      }
                                    }
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
                                              fontSize: 18,
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
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 5),
              Expanded(
                child: Column(
                  children: [
                    Material(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(15),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(15),
                        onTap: () {
                          filterGetx.generateCard().then((value) {
                            if (widget.controller.state != null) {
                              widget.controller.state!
                                  .reset(cards: filterGetx.cards.value);

                              Get.back();
                            }
                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Uygula',
                                style: GoogleFonts.roboto(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 5),
                    TextButton(
                        onPressed: () {
                          filterGetx.resetFilter();
                          filterGetx.filtered.value = false;
                        },
                        style:
                            ButtonStyle(splashFactory: NoSplash.splashFactory),
                        child: Text(
                          'Filtreleri sıfırla',
                          style: TextStyle(
                              fontSize: 17,
                              color: context.isDarkMode
                                  ? Colors.white
                                  : Colors.black),
                        )),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
