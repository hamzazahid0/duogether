import 'dart:io';
import 'dart:math';
import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:gamehub/api/api.dart';
import 'package:gamehub/model/gifModel.dart';
import 'package:gamehub/utils/utils.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:photo_view/photo_view.dart';
import 'package:flutter/material.dart';
import 'package:gamehub/api/firebase.dart';
import 'package:gamehub/getx/infosGetx.dart';
import 'package:gamehub/getx/messageGetX.dart';
import 'package:gamehub/screens/userprofile.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animations/animations.dart';
import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:uuid/uuid.dart';

class Message extends StatefulWidget {
  final String name;
  final String avatar;
  final String pairId;
  final String id;
  final bool avatarIsAsset;

  const Message(
      {Key? key,
      required this.name,
      required this.avatar,
      required this.avatarIsAsset,
      required this.pairId,
      required this.id})
      : super(key: key);

  @override
  _MessageState createState() => _MessageState();
}

MessageGetX messageGetX = Get.put(MessageGetX());
FirebaseApi firebaseApi = Get.find();

class _MessageState extends State<Message> {
  @override
  void dispose() {
    firebaseApi.pairId = '';
    messageGetX.expandGif(false);
    messageGetX.expandPhoto(false);
    messageGetX.expandSocial(false);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    InfosGetx infosGetx = Get.find();
    var padding = MediaQuery.of(context).padding.bottom;
    return Scaffold(
      backgroundColor: context.isDarkMode ? Colors.black : Colors.white,
      appBar: AppBar(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(20))),
        actions: [
          StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
              stream: firebaseApi.firestore
                  .collection('Pairs')
                  .doc(widget.pairId)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data!
                          .data()![firebaseApi.auth.currentUser!.uid] &&
                      snapshot.data!.data()![widget.id]) {
                    messageGetX.imageAllowed.value = true;
                  } else {
                    messageGetX.imageAllowed.value = false;
                  }
                  if (snapshot.data!.data()!['new'] != null) {
                    if (snapshot.data!.data()!['lastSender'] !=
                            firebaseApi.auth.currentUser!.uid &&
                        snapshot.data!.data()!['new']) {
                      snapshot.data!.reference.update({'new': false});
                    }
                  }
                }
                return snapshot.hasData
                    ? IconButton(
                        onPressed: () async {
                          showModalBottomSheet(
                            isScrollControlled: true,
                            context: context,
                            builder: (context) {
                              return Container(
                                width: double.infinity,
                                color: context.isDarkMode
                                    ? Colors.grey[900]
                                    : Colors.white,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 30, horizontal: 10),
                                  child: SingleChildScrollView(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        SizedBox(
                                          width: 170,
                                          height: 110,
                                          child: Stack(
                                            children: [
                                              Positioned(
                                                top: 0,
                                                left: 0,
                                                child: infosGetx
                                                        .avatarIsAsset.value
                                                    ? CircleAvatar(
                                                        radius: 45,
                                                        backgroundImage:
                                                            AssetImage(infosGetx
                                                                .avatar.value),
                                                      )
                                                    : CircleAvatar(
                                                        radius: 45,
                                                        backgroundImage:
                                                            NetworkImage(
                                                                infosGetx.avatar
                                                                    .value),
                                                      ),
                                              ),
                                              Positioned(
                                                top: 0,
                                                right: 0,
                                                child: widget.avatarIsAsset
                                                    ? CircleAvatar(
                                                        radius: 45,
                                                        backgroundColor:
                                                            Colors.transparent,
                                                        backgroundImage:
                                                            AssetImage(
                                                                widget.avatar),
                                                      )
                                                    : CircleAvatar(
                                                        radius: 45,
                                                        backgroundColor:
                                                            Colors.transparent,
                                                        backgroundImage:
                                                            NetworkImage(
                                                                widget.avatar),
                                                      ),
                                              ),
                                              Positioned(
                                                bottom: 0,
                                                left: 0,
                                                right: 0,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 30),
                                                  child: Container(
                                                    child: CircleAvatar(
                                                      radius: 28,
                                                      backgroundColor:
                                                          Colors.white,
                                                      child: CircleAvatar(
                                                        backgroundColor:
                                                            Colors.blue[900],
                                                        radius: 26,
                                                        child: CircleAvatar(
                                                          backgroundColor:
                                                              Colors.white,
                                                          radius: 24,
                                                          child: Center(
                                                            child: Icon(
                                                              snapshot.data!.data()![firebaseApi
                                                                          .auth
                                                                          .currentUser!
                                                                          .uid] &&
                                                                      snapshot.data!
                                                                              .data()![
                                                                          widget
                                                                              .id]
                                                                  ? Icons.shield
                                                                  : Icons
                                                                      .security_rounded,
                                                              color: Colors
                                                                  .blue[900],
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 25,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 40),
                                          child: Text(
                                            snapshot.data!.data()![firebaseApi
                                                    .auth.currentUser!.uid]
                                                ? 'Resim paylaşımına izin verdin'
                                                : 'Resim paylaşımına izin ver',
                                            maxLines: 2,
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontSize: 30,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 25),
                                          child: Text(
                                            snapshot.data!.data()![firebaseApi
                                                        .auth
                                                        .currentUser!
                                                        .uid] &&
                                                    snapshot.data!
                                                        .data()![widget.id]
                                                ? 'Artık resim paylaşımı yapılabilir. Eğer bunu istemiyorsanız izni geri çekebilirsiniz'
                                                : 'Karşılıklı resim paylaşımı yapılması için her iki tarafın buna izin vermesi gerek',
                                            maxLines: 4,
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontSize: 17,
                                                fontWeight: FontWeight.w300),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 22,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 40),
                                          child: Material(
                                            color: snapshot.data!.data()![
                                                    firebaseApi
                                                        .auth.currentUser!.uid]
                                                ? Colors.red
                                                : Colors.blue,
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            child: InkWell(
                                              onTap: snapshot.data!.data()![
                                                      firebaseApi.auth
                                                          .currentUser!.uid]
                                                  ? () async {
                                                      await firebaseApi
                                                          .firestore
                                                          .collection('Pairs')
                                                          .doc(widget.pairId)
                                                          .update({
                                                        firebaseApi
                                                            .auth
                                                            .currentUser!
                                                            .uid: false
                                                      });
                                                      Get.back();
                                                    }
                                                  : () async {
                                                      await firebaseApi
                                                          .firestore
                                                          .collection('Pairs')
                                                          .doc(widget.pairId)
                                                          .update({
                                                        firebaseApi
                                                            .auth
                                                            .currentUser!
                                                            .uid: true
                                                      });
                                                      Get.back();
                                                    },
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(18),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      snapshot.data!.data()![
                                                              firebaseApi
                                                                  .auth
                                                                  .currentUser!
                                                                  .uid]
                                                          ? 'İzni geri al'
                                                          : 'İzin ver',
                                                      style: TextStyle(
                                                          fontSize: 22,
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.bold),
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
                                ),
                              );
                            },
                          );
                        },
                        icon: snapshot.data!.data()![
                                    firebaseApi.auth.currentUser!.uid] &&
                                snapshot.data!.data()![widget.id]
                            ? Icon(Icons.shield)
                            : Icon(Icons.security_rounded))
                    : Container();
              }),
          IconButton(
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  builder: (context) {
                    return Container(
                      width: double.infinity,
                      color:
                          context.isDarkMode ? Colors.grey[900] : Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 30, horizontal: 10),
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Image.asset(
                                'assets/report.png',
                                height: 150,
                                width: 150,
                              ),
                              SizedBox(
                                height: 25,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 40),
                                child: Text(
                                  'Kullanıcıyı şikayet et',
                                  maxLines: 2,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 25),
                                child: Text(
                                  'Eğer bu kullanıcı rahatsız edici davranışlarda bulunuyorsa şikayet et',
                                  maxLines: 4,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w300),
                                ),
                              ),
                              SizedBox(
                                height: 22,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 40),
                                child: Material(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(15),
                                  child: InkWell(
                                    onTap: () async {
                                      Get.back();
                                      showModalBottomSheet(
                                        isDismissible: false,
                                        context: context,
                                        isScrollControlled: true,
                                        builder: (context) => Container(
                                          color: context.isDarkMode
                                              ? Colors.black
                                              : Colors.white,
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 15, vertical: 50),
                                            child: SingleChildScrollView(
                                              physics: BouncingScrollPhysics(),
                                              child: SingleChildScrollView(
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Material(
                                                          color: context
                                                                  .isDarkMode
                                                              ? Colors.grey[900]
                                                              : Colors
                                                                  .grey[200],
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                          child: InkWell(
                                                            onTap: () {
                                                              messageGetX
                                                                  .selected
                                                                  .value = 0;
                                                              Get.back();
                                                            },
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(12),
                                                              child: Text(
                                                                'Geri',
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        20),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        Obx(
                                                          () => Material(
                                                            color: context
                                                                    .isDarkMode
                                                                ? Colors
                                                                    .grey[900]
                                                                : messageGetX
                                                                            .selected
                                                                            .value ==
                                                                        0
                                                                    ? Colors.grey[
                                                                        100]
                                                                    : Colors.grey[
                                                                        200],
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                            child: InkWell(
                                                              onTap: messageGetX
                                                                          .selected
                                                                          .value ==
                                                                      0
                                                                  ? null
                                                                  : () async {
                                                                      switch (messageGetX
                                                                          .selected
                                                                          .value) {
                                                                        case 1:
                                                                          await firebaseApi
                                                                              .firestore
                                                                              .collection('Reports')
                                                                              .add({
                                                                            'from':
                                                                                firebaseApi.auth.currentUser!.uid,
                                                                            'to':
                                                                                widget.id,
                                                                            'pairID':
                                                                                widget.pairId,
                                                                            'time':
                                                                                DateTime.now(),
                                                                            'reason':
                                                                                'Sahte profil'
                                                                          });
                                                                          Get.back();
                                                                          Get.back();
                                                                          firebaseApi
                                                                              .firestore
                                                                              .collection('Pairs')
                                                                              .doc(widget.pairId)
                                                                              .delete();
                                                                          Get.snackbar(
                                                                              'Kullanıcı şikayet edildi',
                                                                              'Ekibimiz şikayeti incelemeye alıp araştırmalar yapacaktır',
                                                                              colorText: Colors.black);

                                                                          break;
                                                                        case 2:
                                                                          await firebaseApi
                                                                              .firestore
                                                                              .collection('Reports')
                                                                              .add({
                                                                            'from':
                                                                                firebaseApi.auth.currentUser!.uid,
                                                                            'to':
                                                                                widget.id,
                                                                            'time':
                                                                                DateTime.now(),
                                                                            'pairID':
                                                                                widget.pairId,
                                                                            'reason':
                                                                                'Uygunsuz mesajlar'
                                                                          });
                                                                          Get.back();
                                                                          Get.back();
                                                                          firebaseApi
                                                                              .firestore
                                                                              .collection('Pairs')
                                                                              .doc(widget.pairId)
                                                                              .delete();
                                                                          Get.snackbar(
                                                                              'Kullanıcı şikayet edildi',
                                                                              'Ekibimiz şikayeti incelemeye alıp araştırmalar yapacaktır',
                                                                              colorText: Colors.black);
                                                                          break;
                                                                        case 3:
                                                                          await firebaseApi
                                                                              .firestore
                                                                              .collection('Reports')
                                                                              .add({
                                                                            'from':
                                                                                firebaseApi.auth.currentUser!.uid,
                                                                            'to':
                                                                                widget.id,
                                                                            'time':
                                                                                DateTime.now(),
                                                                            'pairID':
                                                                                widget.pairId,
                                                                            'reason':
                                                                                'Uygunsuz fotoğraflar'
                                                                          });
                                                                          Get.back();
                                                                          Get.back();
                                                                          firebaseApi
                                                                              .firestore
                                                                              .collection('Pairs')
                                                                              .doc(widget.pairId)
                                                                              .delete();
                                                                          Get.snackbar(
                                                                              'Kullanıcı şikayet edildi',
                                                                              'Ekibimiz şikayeti incelemeye alıp araştırmalar yapacaktır',
                                                                              colorText: Colors.black);
                                                                          break;
                                                                        case 4:
                                                                          await firebaseApi
                                                                              .firestore
                                                                              .collection('Reports')
                                                                              .add({
                                                                            'from':
                                                                                firebaseApi.auth.currentUser!.uid,
                                                                            'to':
                                                                                widget.id,
                                                                            'time':
                                                                                DateTime.now(),
                                                                            'pairID':
                                                                                widget.pairId,
                                                                            'reason':
                                                                                'Uygunsuz hakkında metni'
                                                                          });
                                                                          Get.back();
                                                                          Get.back();
                                                                          firebaseApi
                                                                              .firestore
                                                                              .collection('Pairs')
                                                                              .doc(widget.pairId)
                                                                              .delete();
                                                                          Get.snackbar(
                                                                              'Kullanıcı şikayet edildi',
                                                                              'Ekibimiz şikayeti incelemeye alıp araştırmalar yapacaktır',
                                                                              colorText: Colors.black);
                                                                          break;
                                                                        case 5:
                                                                          await firebaseApi
                                                                              .firestore
                                                                              .collection('Reports')
                                                                              .add({
                                                                            'from':
                                                                                firebaseApi.auth.currentUser!.uid,
                                                                            'to':
                                                                                widget.id,
                                                                            'time':
                                                                                DateTime.now(),
                                                                            'pairID':
                                                                                widget.pairId,
                                                                            'reason':
                                                                                'Reşit olmayan kullanıcı'
                                                                          });
                                                                          Get.back();
                                                                          Get.back();
                                                                          firebaseApi
                                                                              .firestore
                                                                              .collection('Pairs')
                                                                              .doc(widget.pairId)
                                                                              .delete();
                                                                          Get.snackbar(
                                                                              'Kullanıcı şikayet edildi',
                                                                              'Ekibimiz şikayeti incelemeye alıp araştırmalar yapacaktır',
                                                                              colorText: Colors.black);
                                                                          break;
                                                                        case 6:
                                                                          await firebaseApi
                                                                              .firestore
                                                                              .collection('Reports')
                                                                              .add({
                                                                            'from':
                                                                                firebaseApi.auth.currentUser!.uid,
                                                                            'to':
                                                                                widget.id,
                                                                            'time':
                                                                                DateTime.now(),
                                                                            'pairID':
                                                                                widget.pairId,
                                                                            'reason':
                                                                                'Tehdit ve zarar verme'
                                                                          });
                                                                          Get.back();
                                                                          Get.back();
                                                                          firebaseApi
                                                                              .firestore
                                                                              .collection('Pairs')
                                                                              .doc(widget.pairId)
                                                                              .delete();
                                                                          Get.snackbar(
                                                                              'Kullanıcı şikayet edildi',
                                                                              'Ekibimiz şikayeti incelemeye alıp araştırmalar yapacaktır',
                                                                              colorText: Colors.black);
                                                                          break;
                                                                        case 7:
                                                                          await firebaseApi
                                                                              .firestore
                                                                              .collection('Reports')
                                                                              .add({
                                                                            'from':
                                                                                firebaseApi.auth.currentUser!.uid,
                                                                            'to':
                                                                                widget.id,
                                                                            'time':
                                                                                DateTime.now(),
                                                                            'pairID':
                                                                                widget.pairId,
                                                                            'reason':
                                                                                'Fotoğraf veya bilgi gönderimine zorlama'
                                                                          });
                                                                          Get.back();
                                                                          Get.back();
                                                                          firebaseApi
                                                                              .firestore
                                                                              .collection('Pairs')
                                                                              .doc(widget.pairId)
                                                                              .delete();
                                                                          Get.snackbar(
                                                                              'Kullanıcı şikayet edildi',
                                                                              'Ekibimiz şikayeti incelemeye alıp araştırmalar yapacaktır',
                                                                              colorText: Colors.black);
                                                                          break;
                                                                        case 8:
                                                                          await firebaseApi
                                                                              .firestore
                                                                              .collection('Reports')
                                                                              .add({
                                                                            'from':
                                                                                firebaseApi.auth.currentUser!.uid,
                                                                            'to':
                                                                                widget.id,
                                                                            'pairID':
                                                                                widget.pairId,
                                                                            'time':
                                                                                DateTime.now(),
                                                                            'reason':
                                                                                'Kendine zarar verme'
                                                                          });
                                                                          Get.back();
                                                                          Get.back();
                                                                          firebaseApi
                                                                              .firestore
                                                                              .collection('Pairs')
                                                                              .doc(widget.pairId)
                                                                              .delete();
                                                                          Get.snackbar(
                                                                              'Kullanıcı şikayet edildi',
                                                                              'Ekibimiz şikayeti incelemeye alıp araştırmalar yapacaktır',
                                                                              colorText: Colors.black);
                                                                          break;
                                                                        case 9:
                                                                          await firebaseApi
                                                                              .firestore
                                                                              .collection('Reports')
                                                                              .add({
                                                                            'from':
                                                                                firebaseApi.auth.currentUser!.uid,
                                                                            'to':
                                                                                widget.id,
                                                                            'pairID':
                                                                                widget.pairId,
                                                                            'time':
                                                                                DateTime.now(),
                                                                            'reason':
                                                                                'Birileri tehlikede'
                                                                          });
                                                                          Get.back();
                                                                          Get.back();
                                                                          firebaseApi
                                                                              .firestore
                                                                              .collection('Pairs')
                                                                              .doc(widget.pairId)
                                                                              .delete();
                                                                          Get.snackbar(
                                                                              'Kullanıcı şikayet edildi',
                                                                              'Ekibimiz şikayeti incelemeye alıp araştırmalar yapacaktır',
                                                                              colorText: Colors.black);
                                                                          break;
                                                                        default:
                                                                      }
                                                                      messageGetX
                                                                          .selected
                                                                          .value = 0;
                                                                    },
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10),
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .all(12),
                                                                child: Opacity(
                                                                  opacity:
                                                                      messageGetX.selected.value ==
                                                                              0
                                                                          ? 0.5
                                                                          : 1,
                                                                  child: Text(
                                                                    'Gönder',
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            20),
                                                                  ),
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
                                                    Text(
                                                      'Şikayet nedeni',
                                                      style: GoogleFonts.roboto(
                                                          fontSize: 40,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                    Text(
                                                      'Karşı taraf bunu bilmeyecek*',
                                                      style: GoogleFonts.roboto(
                                                          fontSize: 25,
                                                          fontWeight:
                                                              FontWeight.w600),
                                                    ),
                                                    SizedBox(
                                                      height: 15,
                                                    ),
                                                    Obx(
                                                      () => Material(
                                                        color: messageGetX
                                                                    .selected
                                                                    .value ==
                                                                1
                                                            ? Colors.green
                                                            : context.isDarkMode
                                                                ? Colors
                                                                    .grey[900]
                                                                : Colors
                                                                    .grey[200],
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15),
                                                        child: InkWell(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(15),
                                                          onTap: () async {
                                                            messageGetX.selected
                                                                .value = 1;
                                                          },
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Padding(
                                                                padding: const EdgeInsets
                                                                        .symmetric(
                                                                    horizontal:
                                                                        20,
                                                                    vertical:
                                                                        15),
                                                                child: Row(
                                                                  children: [
                                                                    Text(
                                                                      'Sahte profil',
                                                                      style: TextStyle(
                                                                          color: messageGetX.selected.value == 1
                                                                              ? Colors.white
                                                                              : context.isDarkMode
                                                                                  ? Colors.white
                                                                                  : Colors.black),
                                                                    )
                                                                  ],
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                    Obx(
                                                      () => Material(
                                                        color: messageGetX
                                                                    .selected
                                                                    .value ==
                                                                2
                                                            ? Colors.green
                                                            : context.isDarkMode
                                                                ? Colors
                                                                    .grey[900]
                                                                : Colors
                                                                    .grey[200],
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15),
                                                        child: InkWell(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(15),
                                                          onTap: () async {
                                                            messageGetX.selected
                                                                .value = 2;
                                                          },
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Padding(
                                                                padding: const EdgeInsets
                                                                        .symmetric(
                                                                    horizontal:
                                                                        20,
                                                                    vertical:
                                                                        15),
                                                                child: Row(
                                                                  children: [
                                                                    Text(
                                                                      'Uygunsuz mesajlar',
                                                                      style: TextStyle(
                                                                          color: messageGetX.selected.value == 2
                                                                              ? Colors.white
                                                                              : context.isDarkMode
                                                                                  ? Colors.white
                                                                                  : Colors.black),
                                                                    )
                                                                  ],
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                    Obx(
                                                      () => Material(
                                                        color: messageGetX
                                                                    .selected
                                                                    .value ==
                                                                3
                                                            ? Colors.green
                                                            : context.isDarkMode
                                                                ? Colors
                                                                    .grey[900]
                                                                : Colors
                                                                    .grey[200],
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15),
                                                        child: InkWell(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(15),
                                                          onTap: () async {
                                                            messageGetX.selected
                                                                .value = 3;
                                                          },
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Padding(
                                                                padding: const EdgeInsets
                                                                        .symmetric(
                                                                    horizontal:
                                                                        20,
                                                                    vertical:
                                                                        15),
                                                                child: Row(
                                                                  children: [
                                                                    Text(
                                                                      'Uygunsuz fotoğraflar',
                                                                      style: TextStyle(
                                                                          color: messageGetX.selected.value == 3
                                                                              ? Colors.white
                                                                              : context.isDarkMode
                                                                                  ? Colors.white
                                                                                  : Colors.black),
                                                                    )
                                                                  ],
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                    Obx(
                                                      () => Material(
                                                        color: messageGetX
                                                                    .selected
                                                                    .value ==
                                                                4
                                                            ? Colors.green
                                                            : context.isDarkMode
                                                                ? Colors
                                                                    .grey[900]
                                                                : Colors
                                                                    .grey[200],
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15),
                                                        child: InkWell(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(15),
                                                          onTap: () async {
                                                            messageGetX.selected
                                                                .value = 4;
                                                          },
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Padding(
                                                                padding: const EdgeInsets
                                                                        .symmetric(
                                                                    horizontal:
                                                                        20,
                                                                    vertical:
                                                                        15),
                                                                child: Row(
                                                                  children: [
                                                                    Text(
                                                                      'Uygunsuz hakkında metni',
                                                                      style: TextStyle(
                                                                          color: messageGetX.selected.value == 4
                                                                              ? Colors.white
                                                                              : context.isDarkMode
                                                                                  ? Colors.white
                                                                                  : Colors.black),
                                                                    )
                                                                  ],
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                    Obx(
                                                      () => Material(
                                                        color: messageGetX
                                                                    .selected
                                                                    .value ==
                                                                5
                                                            ? Colors.green
                                                            : context.isDarkMode
                                                                ? Colors
                                                                    .grey[900]
                                                                : Colors
                                                                    .grey[200],
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15),
                                                        child: InkWell(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(15),
                                                          onTap: () async {
                                                            messageGetX.selected
                                                                .value = 5;
                                                          },
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Padding(
                                                                padding: const EdgeInsets
                                                                        .symmetric(
                                                                    horizontal:
                                                                        20,
                                                                    vertical:
                                                                        15),
                                                                child: Row(
                                                                  children: [
                                                                    Text(
                                                                      'Reşit olmayan kullanıcı',
                                                                      style: TextStyle(
                                                                          color: messageGetX.selected.value == 5
                                                                              ? Colors.white
                                                                              : context.isDarkMode
                                                                                  ? Colors.white
                                                                                  : Colors.black),
                                                                    )
                                                                  ],
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                    Obx(
                                                      () => Material(
                                                        color: messageGetX
                                                                    .selected
                                                                    .value ==
                                                                6
                                                            ? Colors.green
                                                            : context.isDarkMode
                                                                ? Colors
                                                                    .grey[900]
                                                                : Colors
                                                                    .grey[200],
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15),
                                                        child: InkWell(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(15),
                                                          onTap: () async {
                                                            messageGetX.selected
                                                                .value = 6;
                                                          },
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Padding(
                                                                padding: const EdgeInsets
                                                                        .symmetric(
                                                                    horizontal:
                                                                        20,
                                                                    vertical:
                                                                        15),
                                                                child: Row(
                                                                  children: [
                                                                    Text(
                                                                      'Tehdit ve zarar verme',
                                                                      style: TextStyle(
                                                                          color: messageGetX.selected.value == 6
                                                                              ? Colors.white
                                                                              : context.isDarkMode
                                                                                  ? Colors.white
                                                                                  : Colors.black),
                                                                    )
                                                                  ],
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                    Obx(
                                                      () => Material(
                                                        color: messageGetX
                                                                    .selected
                                                                    .value ==
                                                                7
                                                            ? Colors.green
                                                            : context.isDarkMode
                                                                ? Colors
                                                                    .grey[900]
                                                                : Colors
                                                                    .grey[200],
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15),
                                                        child: InkWell(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(15),
                                                          onTap: () async {
                                                            messageGetX.selected
                                                                .value = 7;
                                                          },
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Padding(
                                                                padding: const EdgeInsets
                                                                        .symmetric(
                                                                    horizontal:
                                                                        20,
                                                                    vertical:
                                                                        15),
                                                                child: Row(
                                                                  children: [
                                                                    SizedBox(
                                                                      width: MediaQuery.of(context)
                                                                              .size
                                                                              .width -
                                                                          150,
                                                                      child:
                                                                          Text(
                                                                        'Fotoğraf veya bilgi gönderimine zorlama',
                                                                        maxLines:
                                                                            2,
                                                                        overflow:
                                                                            TextOverflow.ellipsis,
                                                                        style: TextStyle(
                                                                            color: messageGetX.selected.value == 7
                                                                                ? Colors.white
                                                                                : context.isDarkMode
                                                                                    ? Colors.white
                                                                                    : Colors.black),
                                                                      ),
                                                                    )
                                                                  ],
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                    Obx(
                                                      () => Material(
                                                        color: messageGetX
                                                                    .selected
                                                                    .value ==
                                                                8
                                                            ? Colors.green
                                                            : context.isDarkMode
                                                                ? Colors
                                                                    .grey[900]
                                                                : Colors
                                                                    .grey[200],
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15),
                                                        child: InkWell(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(15),
                                                          onTap: () async {
                                                            messageGetX.selected
                                                                .value = 8;
                                                          },
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Padding(
                                                                padding: const EdgeInsets
                                                                        .symmetric(
                                                                    horizontal:
                                                                        20,
                                                                    vertical:
                                                                        15),
                                                                child: Row(
                                                                  children: [
                                                                    Text(
                                                                      'Kendine zarar verme',
                                                                      style: TextStyle(
                                                                          color: messageGetX.selected.value == 8
                                                                              ? Colors.white
                                                                              : context.isDarkMode
                                                                                  ? Colors.white
                                                                                  : Colors.black),
                                                                    )
                                                                  ],
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                    Obx(
                                                      () => Material(
                                                        color: messageGetX
                                                                    .selected
                                                                    .value ==
                                                                9
                                                            ? Colors.green
                                                            : context.isDarkMode
                                                                ? Colors
                                                                    .grey[900]
                                                                : Colors
                                                                    .grey[200],
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15),
                                                        child: InkWell(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(15),
                                                          onTap: () async {
                                                            messageGetX.selected
                                                                .value = 9;
                                                          },
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Padding(
                                                                padding: const EdgeInsets
                                                                        .symmetric(
                                                                    horizontal:
                                                                        20,
                                                                    vertical:
                                                                        15),
                                                                child: Row(
                                                                  children: [
                                                                    Text(
                                                                      'Birileri tehlikede',
                                                                      style: TextStyle(
                                                                          color: messageGetX.selected.value == 9
                                                                              ? Colors.white
                                                                              : context.isDarkMode
                                                                                  ? Colors.white
                                                                                  : Colors.black),
                                                                    )
                                                                  ],
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                    // TextButton(
                                                    //     onPressed: () {
                                                    //       Get.back();
                                                    //     },
                                                    //     child: Text(
                                                    //       'Geri',
                                                    //       style: TextStyle(
                                                    //           fontSize: 17),
                                                    //     ))
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                    borderRadius: BorderRadius.circular(15),
                                    child: Padding(
                                      padding: const EdgeInsets.all(18),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Expanded(
                                            child: Text(
                                              'Şikayet et ve kaldır',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontSize: 22,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              TextButton(
                                  onPressed: () {
                                    Get.back();
                                    Get.back();
                                    firebaseApi.firestore
                                        .collection('Pairs')
                                        .doc(widget.pairId)
                                        .delete();
                                  },
                                  child: Text(
                                    'Sadece kaldır',
                                    style: GoogleFonts.roboto(
                                        fontSize: 20,
                                        color: context.isDarkMode
                                            ? Colors.white
                                            : Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ))
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
              icon: Icon(Icons.campaign_outlined))
        ],
        brightness: Brightness.dark,
        backgroundColor: Colors.grey[900],
        title: GestureDetector(
          onTap: () {
            Get.to(() => UserProfile(userId: widget.id),
                transition: Transition.cupertino);
          },
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 5, 10, 5),
                child: widget.avatarIsAsset
                    ? CircleAvatar(
                        backgroundColor: Colors.transparent,
                        backgroundImage: AssetImage(widget.avatar),
                      )
                    : CircleAvatar(
                        backgroundColor: Colors.transparent,
                        backgroundImage: NetworkImage(widget.avatar),
                      ),
              ),
              Text(widget.name),
            ],
          ),
        ),
        centerTitle: false,
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        behavior: HitTestBehavior.translucent,
        child: Obx(
          () => Container(
            decoration: BoxDecoration(
                gradient: context.isDarkMode
                    ? LinearGradient(
                        colors: [Colors.cyan[900]!, Colors.black],
                        begin: Alignment.bottomRight,
                        end: Alignment.topCenter)
                    : LinearGradient(
                        colors: [
                            Colors.cyan[100]!.withOpacity(0.3),
                            Colors.white,
                          ],
                        begin: Alignment.bottomRight,
                        end: Alignment.topCenter)),
            child: Column(
              children: [
                Expanded(
                    child: Container(
                  child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                    stream: firebaseApi.firestore
                        .collection('Pairs')
                        .doc(widget.pairId)
                        .collection('Messages')
                        .orderBy('date', descending: true)
                        .snapshots(),
                    builder: (context, snapshot) {
                      // WidgetsBinding.instance!.addPostFrameCallback((_) {
                      //   if (scroll.hasClients) {
                      //     scroll.jumpTo(scroll.position.maxScrollExtent);
                      //   } else {}
                      // });
                      return snapshot.hasData
                          ? Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5),
                              child: ListView.builder(
                                reverse: true,
                                itemCount: snapshot.data!.docs.length,
                                physics: BouncingScrollPhysics(),
                                shrinkWrap: true,
                                cacheExtent: 200,
                                itemBuilder: (context, index) {
                                  Timestamp timestamp =
                                      snapshot.data!.docs[index].data()['date'];
                                  var date =
                                      new DateTime.fromMicrosecondsSinceEpoch(
                                          timestamp.microsecondsSinceEpoch);
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 3.5),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        snapshot.data!.docs[index]
                                                .data()['isSocial']
                                            ? Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 30,
                                                        vertical: 5),
                                                child: GestureDetector(
                                                  onTap: () async {
                                                    String link =
                                                        "${snapshot.data!.docs[index].data()['launch']}${snapshot.data!.docs[index].data()['content']}";
                                                    if (await canLaunch(link)) {
                                                      await launch(link,
                                                          universalLinksOnly:
                                                              true);
                                                    } else {
                                                      print('cant');
                                                    }
                                                  },
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20),
                                                        color: Colors.white
                                                            .withOpacity(0.3)),
                                                    child: Align(
                                                      alignment:
                                                          Alignment.center,
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                vertical: 10),
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          mainAxisSize:
                                                              MainAxisSize.min,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          children: [
                                                            SizedBox(
                                                              height: 7,
                                                            ),
                                                            Image.network(
                                                              snapshot.data!
                                                                      .docs[index]
                                                                      .data()[
                                                                  'photoLink']!,
                                                              height: 70,
                                                            ),
                                                            SizedBox(
                                                              height: 5,
                                                            ),
                                                            Text(
                                                              snapshot.data!
                                                                      .docs[index]
                                                                      .data()[
                                                                  'socialName']!,
                                                              style: GoogleFonts.roboto(
                                                                  fontSize: 22,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500),
                                                            ),
                                                            SizedBox(
                                                              height: 5,
                                                            ),
                                                            Text(
                                                              snapshot.data!
                                                                      .docs[index]
                                                                      .data()[
                                                                  'content']!,
                                                              style: GoogleFonts.roboto(
                                                                  fontSize: 26,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w700),
                                                            ),
                                                            SizedBox(
                                                              height: 3,
                                                            ),
                                                            Text(
                                                              snapshot
                                                                          .data!
                                                                          .docs[
                                                                              index]
                                                                          .data()['from'] ==
                                                                      widget.id
                                                                  ? '${widget.name} tarafından gönderildi'
                                                                  : 'Sizin tarafınızdan gönderildi',
                                                              style: GoogleFonts.roboto(
                                                                  fontSize: 17,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w300),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              )
                                            : Align(
                                                alignment: snapshot
                                                            .data!.docs[index]
                                                            .data()['from'] ==
                                                        widget.id
                                                    ? Alignment.centerLeft
                                                    : Alignment.centerRight,
                                                child: Container(
                                                  constraints: BoxConstraints(
                                                      maxWidth:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width /
                                                              3 *
                                                              2),
                                                  // width: MediaQuery.of(context)
                                                  //         .size
                                                  //         .width /
                                                  //     2,
                                                  decoration: BoxDecoration(
                                                      color: snapshot.data!
                                                                      .docs[index]
                                                                      .data()[
                                                                  'from'] ==
                                                              widget.id
                                                          ? Colors.grey
                                                              .withOpacity(0.25)
                                                          : Colors.blue,
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  20))),
                                                  child:
                                                      snapshot.data!.docs[index]
                                                              .data()['isText']
                                                          ? GestureDetector(
                                                              onLongPress: () {
                                                                showCupertinoModalPopup(
                                                                  filter: ImageFilter
                                                                      .blur(
                                                                          sigmaX:
                                                                              3,
                                                                          sigmaY:
                                                                              3),
                                                                  context:
                                                                      context,
                                                                  builder:
                                                                      (context) {
                                                                    return Container(
                                                                      child:
                                                                          Padding(
                                                                        padding: const EdgeInsets.symmetric(
                                                                            vertical:
                                                                                10,
                                                                            horizontal:
                                                                                15),
                                                                        child:
                                                                            Material(
                                                                          color: context.isDarkMode
                                                                              ? Colors.grey[900]
                                                                              : Colors.grey[200],
                                                                          borderRadius:
                                                                              BorderRadius.circular(15),
                                                                          child:
                                                                              InkWell(
                                                                            borderRadius:
                                                                                BorderRadius.circular(15),
                                                                            onTap:
                                                                                () {
                                                                              Clipboard.setData(ClipboardData(text: snapshot.data!.docs[index].data()['content']));
                                                                              Get.back();
                                                                            },
                                                                            child:
                                                                                Row(
                                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                              children: [
                                                                                Padding(
                                                                                  padding: const EdgeInsets.symmetric(horizontal: 20),
                                                                                  child: Row(
                                                                                    children: [
                                                                                      Icon(Icons.copy),
                                                                                      SizedBox(
                                                                                        width: 10,
                                                                                      ),
                                                                                      Text('Kopyala')
                                                                                    ],
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      height:
                                                                          80,
                                                                      width: double
                                                                          .maxFinite,
                                                                      color: Get.isDarkMode
                                                                          ? Colors
                                                                              .black
                                                                          : Colors
                                                                              .white,
                                                                    );
                                                                  },
                                                                );
                                                              },
                                                              child: Padding(
                                                                padding: const EdgeInsets
                                                                        .symmetric(
                                                                    horizontal:
                                                                        15,
                                                                    vertical:
                                                                        9),
                                                                child: ClipRect(
                                                                  child: Row(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .min,
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .end,
                                                                    children: [
                                                                      // snapshot.data!.docs[index]
                                                                      //                 .data()[
                                                                      //             'from'] ==
                                                                      //         widget.id
                                                                      //     ? SizedBox(
                                                                      //         width: 8,
                                                                      //       )
                                                                      //     : Container(),
                                                                      Flexible(
                                                                        child:
                                                                            Padding(
                                                                          padding:
                                                                              const EdgeInsets.only(bottom: 2.5),
                                                                          child:
                                                                              Linkify(
                                                                            linkStyle: TextStyle(
                                                                                fontWeight: FontWeight.bold,
                                                                                color: snapshot.data!.docs[index].data()['from'] == widget.id
                                                                                    ? context.isDarkMode
                                                                                        ? Colors.white
                                                                                        : Colors.black
                                                                                    : Colors.white,
                                                                                fontSize: 17),
                                                                            onOpen:
                                                                                (link) async {
                                                                              if (await canLaunch(link.url)) {
                                                                                await launch(link.url);
                                                                              } else {}
                                                                            },
                                                                            text:
                                                                                snapshot.data!.docs[index].data()['content'],
                                                                            style: TextStyle(
                                                                                color: snapshot.data!.docs[index].data()['from'] == widget.id
                                                                                    ? context.isDarkMode
                                                                                        ? Colors.white
                                                                                        : Colors.black
                                                                                    : Colors.white,
                                                                                fontSize: 17),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      SizedBox(
                                                                        width:
                                                                            8,
                                                                      ),
                                                                      snapshot.data!.docs[index].data()['from'] ==
                                                                              widget.id
                                                                          ? Align(
                                                                              alignment: Alignment.bottomRight,
                                                                              child: Text(
                                                                                date.minute < 10 ? '${date.hour}:0${date.minute}' : '${date.hour}:${date.minute}',
                                                                                style: TextStyle(
                                                                                    color: snapshot.data!.docs[index].data()['from'] == widget.id
                                                                                        ? context.isDarkMode
                                                                                            ? Colors.white
                                                                                            : Colors.black
                                                                                        : Colors.white,
                                                                                    fontSize: 12),
                                                                              ),
                                                                            )
                                                                          : Container(),
                                                                      snapshot.data!.docs[index].data()['from'] ==
                                                                              widget.id
                                                                          ? Container()
                                                                          : Align(
                                                                              alignment: Alignment.bottomRight,
                                                                              child: Text(
                                                                                date.minute < 10 ? '${date.hour}:0${date.minute}' : '${date.hour}:${date.minute}',
                                                                                style: TextStyle(
                                                                                    color: snapshot.data!.docs[index].data()['from'] == widget.id
                                                                                        ? context.isDarkMode
                                                                                            ? Colors.white
                                                                                            : Colors.black
                                                                                        : Colors.white,
                                                                                    fontSize: 12),
                                                                              ),
                                                                            ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                            )
                                                          : Container(
                                                              height: 180,
                                                              // constraints: BoxConstraints(
                                                              //     maxHeight: 180),
                                                              decoration:
                                                                  BoxDecoration(),
                                                              child: ClipRRect(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10),
                                                                child:
                                                                    OpenContainer(
                                                                  closedBuilder:
                                                                      (context,
                                                                          action) {
                                                                    return FadeInImage(
                                                                      fadeInDuration:
                                                                          Duration(
                                                                              milliseconds: 1),
                                                                      placeholder:
                                                                          AssetImage(
                                                                              'assets/loading.gif'),
                                                                      fit: BoxFit
                                                                          .cover,
                                                                      image:
                                                                          NetworkImage(
                                                                        snapshot
                                                                            .data!
                                                                            .docs[index]
                                                                            .data()['content'],
                                                                      ),
                                                                    );
                                                                  },
                                                                  openBuilder:
                                                                      (context,
                                                                          action) {
                                                                    return Scaffold(
                                                                      appBar:
                                                                          AppBar(
                                                                        backgroundColor:
                                                                            Colors.transparent,
                                                                        elevation:
                                                                            0,
                                                                      ),
                                                                      extendBodyBehindAppBar:
                                                                          true,
                                                                      body: PhotoView(
                                                                          imageProvider: NetworkImage(snapshot
                                                                              .data!
                                                                              .docs[index]
                                                                              .data()['content'])),
                                                                    );
                                                                  },
                                                                ),
                                                              ),
                                                            ),
                                                ),
                                              )
                                      ],
                                    ),
                                  );
                                },
                              ),
                            )
                          : Container();
                    },
                  ),
                )),
                ClipRRect(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 13, sigmaY: 19),
                    child: AnimatedContainer(
                      duration: Duration(milliseconds: 250),
                      decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.04),
                          border: Border.symmetric(
                              horizontal: BorderSide(
                                  color: Colors.white.withOpacity(0.076)))),
                      height: messageGetX.socialExpanded.value
                          ? 180 + padding
                          : messageGetX.gifExpanded.value
                              ? 250 + padding
                              : messageGetX.photoExpanded.value
                                  ? 190 + padding
                                  : messageGetX.wordsExpanded.value
                                      ? 180 + padding
                                      : 130 + padding,
                      width: MediaQuery.of(context).size.width,
                      child: Padding(
                        padding: const EdgeInsets.all(0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Visibility(
                              visible: messageGetX.wordsExpanded.value,
                              child: Flexible(
                                flex: 1,
                                child: Container(
                                  // color: Colors.green,
                                  decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                          colors: [
                                        Colors.transparent,
                                        Colors.transparent,
                                        Colors.purple.withOpacity(0.01),
                                        // Colors.green.withOpacity(0.2),
                                        Colors.purple.withOpacity(0.5),
                                        Colors.purple.withOpacity(0.9),
                                        Colors.purple.withOpacity(1)
                                      ],
                                          begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter)),
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 5),
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      shrinkWrap: true,
                                      itemCount: infosGetx.words.length + 1,
                                      itemBuilder: (context, index) {
                                        return Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8, vertical: 3),
                                          child: Material(
                                            elevation: 2,
                                            borderRadius:
                                                BorderRadius.circular(30),
                                            color: context.isDarkMode
                                                ? Colors.grey[900]
                                                : Colors.white,
                                            child: InkWell(
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                              onTap: () async {
                                                if (index ==
                                                    infosGetx.words.length) {
                                                  messageGetX.wordsExpanded
                                                      .value = false;
                                                  infosGetx.updateWords();
                                                  return;
                                                }
                                                await firebaseApi.firestore
                                                    .collection('Pairs')
                                                    .doc(widget.pairId)
                                                    .update({
                                                  'hasMessage': true,
                                                  'lastDate': DateTime.now(),
                                                  'new': true,
                                                  'lastSender': firebaseApi
                                                      .auth.currentUser!.uid,
                                                  'lastName':
                                                      infosGetx.name.value,
                                                  'lastMessage':
                                                      infosGetx.words[index]
                                                });
                                                await firebaseApi.firestore
                                                    .collection('Pairs')
                                                    .doc(widget.pairId)
                                                    .collection('Messages')
                                                    .add({
                                                  'content':
                                                      infosGetx.words[index],
                                                  'isText': true,
                                                  'socialName': '',
                                                  'isSocial': false,
                                                  'photoLink': '',
                                                  'launch': '',
                                                  'from': firebaseApi
                                                      .auth.currentUser!.uid,
                                                  'date': DateTime.now()
                                                });
                                              },
                                              child:
                                                  index ==
                                                          infosGetx.words.length
                                                      ? Container(
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .symmetric(
                                                                    horizontal:
                                                                        10),
                                                            child: Center(
                                                              child: Icon(Icons
                                                                  .refresh_rounded),
                                                            ),
                                                          ),
                                                        )
                                                      : Container(
                                                          child: Center(
                                                            child: Padding(
                                                              padding: const EdgeInsets
                                                                      .symmetric(
                                                                  horizontal:
                                                                      12,
                                                                  vertical: 2),
                                                              child: Row(
                                                                children: [
                                                                  Row(
                                                                    children: [
                                                                      Text(
                                                                        infosGetx
                                                                            .words[index],
                                                                        style: TextStyle(
                                                                            fontWeight:
                                                                                FontWeight.bold),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                          decoration:
                                                              BoxDecoration(
                                                                  // boxShadow: [
                                                                  //   BoxShadow(
                                                                  //       color: Colors.grey
                                                                  //           .withOpacity(0.3),
                                                                  //       blurRadius: 2,
                                                                  //       spreadRadius: 1,
                                                                  //       offset: Offset(2, 2))
                                                                  // ],
                                                                  color: Colors
                                                                      .transparent,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              30)),
                                                        ),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Visibility(
                              visible: messageGetX.socialExpanded.value,
                              child: Flexible(
                                flex: 1,
                                child: Container(
                                  // color: Colors.green,
                                  decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                          colors: [
                                        Colors.transparent,
                                        Colors.transparent,
                                        Colors.green.withOpacity(0.01),
                                        // Colors.green.withOpacity(0.2),
                                        Colors.green.withOpacity(0.5),
                                        Colors.green.withOpacity(0.9),
                                        Colors.green.withOpacity(1)
                                      ],
                                          begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter)),
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 5),
                                    child: infosGetx.social.length == 0
                                        ? Center(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 20,
                                                      vertical: 3),
                                              child: Material(
                                                elevation: 2,
                                                borderRadius:
                                                    BorderRadius.circular(30),
                                                color: context.isDarkMode
                                                    ? Colors.grey[900]
                                                    : Colors.white,
                                                child: InkWell(
                                                  borderRadius:
                                                      BorderRadius.circular(30),
                                                  child: Container(
                                                    child: Center(
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                horizontal: 12,
                                                                vertical: 2),
                                                        child: Text(
                                                          'Sosyal platform eklenmedi',
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      ),
                                                    ),
                                                    decoration: BoxDecoration(
                                                        // boxShadow: [
                                                        //   BoxShadow(
                                                        //       color: Colors.grey
                                                        //           .withOpacity(0.3),
                                                        //       blurRadius: 2,
                                                        //       spreadRadius: 1,
                                                        //       offset: Offset(2, 2))
                                                        // ],
                                                        color:
                                                            Colors.transparent,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(30)),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          )
                                        : ListView.builder(
                                            scrollDirection: Axis.horizontal,
                                            itemCount: infosGetx.social.length,
                                            itemBuilder: (context, index) {
                                              return Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 8,
                                                        vertical: 3),
                                                child: Material(
                                                  elevation: 2,
                                                  borderRadius:
                                                      BorderRadius.circular(30),
                                                  color: context.isDarkMode
                                                      ? Colors.grey[900]
                                                      : Colors.white,
                                                  child: InkWell(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            30),
                                                    onTap: () async {
                                                      String content =
                                                          '${infosGetx.social[index]['name']}: ${infosGetx.social[index]['data']}';
                                                      await firebaseApi
                                                          .firestore
                                                          .collection('Pairs')
                                                          .doc(widget.pairId)
                                                          .update({
                                                        'hasMessage': true,
                                                        'lastDate':
                                                            DateTime.now(),
                                                        'new': true,
                                                        'lastMessage': content,
                                                        'lastSender':
                                                            firebaseApi
                                                                .auth
                                                                .currentUser!
                                                                .uid,
                                                        'lastName':
                                                            infosGetx.name.value
                                                      });
                                                      await firebaseApi
                                                          .firestore
                                                          .collection('Pairs')
                                                          .doc(widget.pairId)
                                                          .collection(
                                                              'Messages')
                                                          .add({
                                                        'content': infosGetx
                                                                .social[index]
                                                            ['data'],
                                                        'socialName': infosGetx
                                                                .social[index]
                                                            ['name'],
                                                        'isSocial': true,
                                                        'launch': infosGetx
                                                                .social[index]
                                                            ['launch'],
                                                        'photoLink': infosGetx
                                                                .social[index]
                                                            ['icon'],
                                                        'isText': true,
                                                        'from': firebaseApi.auth
                                                            .currentUser!.uid,
                                                        'date': DateTime.now()
                                                      });
                                                    },
                                                    child: Container(
                                                      child: Center(
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  horizontal:
                                                                      12,
                                                                  vertical: 2),
                                                          child: Row(
                                                            children: [
                                                              CircleAvatar(
                                                                backgroundColor:
                                                                    Colors
                                                                        .transparent,
                                                                backgroundImage:
                                                                    NetworkImage(
                                                                  infosGetx.social[
                                                                          index]
                                                                      ['icon'],
                                                                ),
                                                                radius: 15,
                                                              ),
                                                              SizedBox(
                                                                width: 5,
                                                              ),
                                                              Row(
                                                                children: [
                                                                  // Text(
                                                                  //     '${snapshot.data!.docs[index]['name']}: '),
                                                                  // Text(
                                                                  //     '${infosGetx.social[index]['name']}: '),
                                                                  Text(
                                                                    infosGetx.social[
                                                                            index]
                                                                        [
                                                                        'data'],
                                                                    style: TextStyle(
                                                                        fontWeight:
                                                                            FontWeight.bold),
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      decoration: BoxDecoration(
                                                          // boxShadow: [
                                                          //   BoxShadow(
                                                          //       color: Colors.grey
                                                          //           .withOpacity(0.3),
                                                          //       blurRadius: 2,
                                                          //       spreadRadius: 1,
                                                          //       offset: Offset(2, 2))
                                                          // ],
                                                          color: Colors
                                                              .transparent,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      30)),
                                                    ),
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                  ),
                                ),
                              ),
                            ),
                            Visibility(
                              visible: messageGetX.gifExpanded.value,
                              child: Flexible(
                                flex: 5,
                                child: Container(
                                  // color: Colors.redAccent,
                                  decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                          colors: [
                                        Colors.transparent,
                                        Colors.transparent,
                                        Colors.redAccent.withOpacity(0.1),
                                        Colors.redAccent.withOpacity(0.4),
                                        Colors.redAccent.withOpacity(0.7),
                                        Colors.redAccent.withOpacity(1)
                                      ],
                                          begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter)),
                                  child: Obx(
                                    () => Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 5),
                                      child: FutureBuilder<Gif?>(
                                          future: Api().getGifs(
                                              messageGetX.search.value),
                                          builder: (context, snapshot) {
                                            List<String> links = [];
                                            return snapshot.hasData
                                                ? ListView.builder(
                                                    physics:
                                                        BouncingScrollPhysics(),
                                                    scrollDirection:
                                                        Axis.horizontal,
                                                    itemCount: snapshot
                                                        .data!.results.length,
                                                    itemBuilder:
                                                        (context, index) {
                                                      snapshot.data!
                                                          .results[index].media
                                                          .forEach((element) {
                                                        if (!links.contains(
                                                            element['tinygif']!
                                                                .url)) {
                                                          links.add(element[
                                                                  'tinygif']!
                                                              .url);
                                                        }
                                                      });
                                                      return Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                horizontal: 8,
                                                                vertical: 3),
                                                        child: ClipRRect(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(20),
                                                          child: Container(
                                                            child:
                                                                GestureDetector(
                                                              onTap: () async {
                                                                await firebaseApi
                                                                    .firestore
                                                                    .collection(
                                                                        'Pairs')
                                                                    .doc(widget
                                                                        .pairId)
                                                                    .update({
                                                                  'hasMessage':
                                                                      true,
                                                                  'lastDate':
                                                                      DateTime
                                                                          .now(),
                                                                  'new': true,
                                                                  'lastSender':
                                                                      firebaseApi
                                                                          .auth
                                                                          .currentUser!
                                                                          .uid,
                                                                  'lastName':
                                                                      infosGetx
                                                                          .name
                                                                          .value,
                                                                  'lastMessage':
                                                                      'Gif'
                                                                });
                                                                await firebaseApi
                                                                    .firestore
                                                                    .collection(
                                                                        'Pairs')
                                                                    .doc(widget
                                                                        .pairId)
                                                                    .collection(
                                                                        'Messages')
                                                                    .add({
                                                                  'content':
                                                                      links[
                                                                          index],
                                                                  'isText':
                                                                      false,
                                                                  'socialName':
                                                                      '',
                                                                  'photoLink':
                                                                      '',
                                                                  'launch': '',
                                                                  'isSocial':
                                                                      false,
                                                                  'from': firebaseApi
                                                                      .auth
                                                                      .currentUser!
                                                                      .uid,
                                                                  'date':
                                                                      DateTime
                                                                          .now()
                                                                });
                                                              },
                                                              child:
                                                                  FadeInImage(
                                                                placeholder:
                                                                    AssetImage(
                                                                        'assets/loading.gif'),
                                                                image: NetworkImage(
                                                                    links[
                                                                        index]),
                                                                fit: BoxFit
                                                                    .cover,
                                                              ),
                                                              // child:
                                                              //     Image.network(
                                                              //   links[index],
                                                              //   fit: BoxFit.cover,
                                                              // ),
                                                            ),
                                                            decoration: BoxDecoration(
                                                                color: Colors
                                                                    .white,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            30)),
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                  )
                                                : Center(
                                                    child:
                                                        CircularPercentIndicator(
                                                      radius: 20,
                                                    ),
                                                  );
                                          }),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Visibility(
                              visible: messageGetX.photoExpanded.value,
                              child: Flexible(
                                flex: 2,
                                child: Container(
                                  // color: Colors.orange,
                                  decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                          colors: [
                                        Colors.transparent,
                                        Colors.transparent,
                                        Colors.orange.withOpacity(0.01),
                                        // Colors.green.withOpacity(0.2),
                                        Colors.orange.withOpacity(0.5),
                                        Colors.orange.withOpacity(0.9),
                                        Colors.orange.withOpacity(1)
                                      ],
                                          begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter)),
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 2),
                                    child: Center(
                                      child: Row(
                                        children: [
                                          Flexible(
                                            child: Padding(
                                              padding: const EdgeInsets.all(10),
                                              child: Material(
                                                color: context.isDarkMode
                                                    ? Colors.grey[900]
                                                    : Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(30),
                                                elevation: 2,
                                                child: InkWell(
                                                  onTap: () async {
                                                    if (!messageGetX
                                                        .imageAllowed.value) {
                                                      Get.snackbar(
                                                          'Resim izin verilmedi',
                                                          'Resim göndermek için her iki tarafın izin vermesi gerek',
                                                          colorText:
                                                              Colors.white);
                                                      return;
                                                    }

                                                    await Permission.camera
                                                        .request();
                                                    if (await Permission
                                                        .camera.isGranted) {
                                                      var image =
                                                          await ImagePicker()
                                                              .getImage(
                                                                  source:
                                                                      ImageSource
                                                                          .camera,
                                                                  imageQuality:
                                                                      40);
                                                      if (image != null) {
                                                        var task = firebaseApi
                                                            .storage
                                                            .ref()
                                                            .child(
                                                                'images/${Uuid().v1()}')
                                                            .putFile(File(
                                                                image.path));
                                                        task.then((v) async {
                                                          String link = await v
                                                              .ref
                                                              .getDownloadURL();

                                                          await firebaseApi
                                                              .firestore
                                                              .collection(
                                                                  'Pairs')
                                                              .doc(
                                                                  widget.pairId)
                                                              .update({
                                                            'hasMessage': true,
                                                            'lastDate':
                                                                DateTime.now(),
                                                            'new': true,
                                                            'lastName':
                                                                infosGetx
                                                                    .name.value,
                                                            'lastSender':
                                                                firebaseApi
                                                                    .auth
                                                                    .currentUser!
                                                                    .uid,
                                                            'lastMessage':
                                                                'Resim'
                                                          });
                                                          await firebaseApi
                                                              .firestore
                                                              .collection(
                                                                  'Pairs')
                                                              .doc(
                                                                  widget.pairId)
                                                              .collection(
                                                                  'Messages')
                                                              .add({
                                                            'content': link,
                                                            'isText': false,
                                                            'socialName': '',
                                                            'isSocial': false,
                                                            'launch': '',
                                                            'photoLink': '',
                                                            'from': firebaseApi
                                                                .auth
                                                                .currentUser!
                                                                .uid,
                                                            'date':
                                                                DateTime.now()
                                                          });
                                                        });
                                                      }
                                                    }
                                                  },
                                                  borderRadius:
                                                      BorderRadius.circular(30),
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                        // boxShadow: [
                                                        //   BoxShadow(
                                                        //       color: Colors.purple
                                                        //           .withOpacity(
                                                        //               0.3),
                                                        //       blurRadius: 2,
                                                        //       spreadRadius: 1,
                                                        //       offset:
                                                        //           Offset(2, 2))
                                                        // ],
                                                        // gradient: LinearGradient(
                                                        //     colors: [
                                                        //       Colors.purple,
                                                        //       Colors.deepPurple
                                                        //     ]),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(30)),
                                                    child: Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 5,
                                                          vertical: 8),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          // Icon(Icons.camera_alt_rounded),
                                                          // SizedBox(
                                                          //   width: 5,
                                                          // ),
                                                          Text('Kamera',
                                                              style: GoogleFonts.roboto(
                                                                  fontSize: 20,
                                                                  color: context
                                                                          .isDarkMode
                                                                      ? Colors
                                                                          .white
                                                                      : Colors.grey[
                                                                          900]))
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            flex: 1,
                                          ),
                                          Flexible(
                                            child: Padding(
                                              padding: const EdgeInsets.all(10),
                                              child: Material(
                                                color: context.isDarkMode
                                                    ? Colors.grey[900]
                                                    : Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(30),
                                                elevation: 2,
                                                child: InkWell(
                                                  onTap: () async {
                                                    if (!messageGetX
                                                        .imageAllowed.value) {
                                                      Get.snackbar(
                                                          'Resim izin verilmedi',
                                                          'Resim göndermek için her iki tarafın izin vermesi gerek',
                                                          colorText:
                                                              Colors.white);
                                                      return;
                                                    }
                                                    await Permission.storage
                                                        .request();
                                                    await Permission.photos
                                                        .request();
                                                    if (await Permission.storage
                                                            .isGranted &&
                                                        await Permission
                                                            .photos.isGranted) {
                                                      var image =
                                                          await ImagePicker()
                                                              .getImage(
                                                                  source:
                                                                      ImageSource
                                                                          .gallery,
                                                                  imageQuality:
                                                                      40);
                                                      if (image != null) {
                                                        var task = firebaseApi
                                                            .storage
                                                            .ref()
                                                            .child(
                                                                'images/${Uuid().v1()}')
                                                            .putFile(File(
                                                                image.path));
                                                        task.then((v) async {
                                                          String link = await v
                                                              .ref
                                                              .getDownloadURL();

                                                          await firebaseApi
                                                              .firestore
                                                              .collection(
                                                                  'Pairs')
                                                              .doc(
                                                                  widget.pairId)
                                                              .update({
                                                            'hasMessage': true,
                                                            'lastDate':
                                                                DateTime.now(),
                                                            'new': true,
                                                            'lastName':
                                                                infosGetx
                                                                    .name.value,
                                                            'lastSender':
                                                                firebaseApi
                                                                    .auth
                                                                    .currentUser!
                                                                    .uid,
                                                            'lastMessage':
                                                                'Resim'
                                                          });
                                                          await firebaseApi
                                                              .firestore
                                                              .collection(
                                                                  'Pairs')
                                                              .doc(
                                                                  widget.pairId)
                                                              .collection(
                                                                  'Messages')
                                                              .add({
                                                            'content': link,
                                                            'isText': false,
                                                            'photoLink': '',
                                                            'socialName': '',
                                                            'isSocial': false,
                                                            'launch': '',
                                                            'from': firebaseApi
                                                                .auth
                                                                .currentUser!
                                                                .uid,
                                                            'date':
                                                                DateTime.now()
                                                          });
                                                        });
                                                      }
                                                    }
                                                  },
                                                  borderRadius:
                                                      BorderRadius.circular(30),
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                        // boxShadow: [
                                                        //   BoxShadow(
                                                        //       color: Colors.purple
                                                        //           .withOpacity(
                                                        //               0.3),
                                                        //       blurRadius: 2,
                                                        //       spreadRadius: 1,
                                                        //       offset:
                                                        //           Offset(2, 2))
                                                        // ],
                                                        // gradient: LinearGradient(
                                                        //     colors: [
                                                        //       Colors.purple,
                                                        //       Colors.deepPurple
                                                        //     ]),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(30)),
                                                    child: Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 5,
                                                          vertical: 8),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          // Icon(Icons.camera_alt_rounded),
                                                          // SizedBox(
                                                          //   width: 5,
                                                          // ),
                                                          Text('Galeri',
                                                              style: GoogleFonts.roboto(
                                                                  fontSize: 20,
                                                                  color: context
                                                                          .isDarkMode
                                                                      ? Colors
                                                                          .white
                                                                      : Colors.grey[
                                                                          900]))
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            flex: 1,
                                          ),
                                          // Flexible(
                                          //   child: Padding(
                                          //     padding: const EdgeInsets.all(10),
                                          //     child: Container(
                                          //       decoration: BoxDecoration(
                                          //           boxShadow: [
                                          //             BoxShadow(
                                          //                 color: Colors.green
                                          //                     .withOpacity(0.3),
                                          //                 blurRadius: 2,
                                          //                 spreadRadius: 1,
                                          //                 offset: Offset(2, 2))
                                          //           ],
                                          //           gradient: LinearGradient(
                                          //               colors: [
                                          //                 Colors.green,
                                          //                 Colors.lightGreen
                                          //               ]),
                                          //           borderRadius:
                                          //               BorderRadius.circular(
                                          //                   30)),
                                          //       child: Padding(
                                          //         padding:
                                          //             const EdgeInsets.symmetric(
                                          //                 horizontal: 5,
                                          //                 vertical: 8),
                                          //         child: Row(
                                          //           mainAxisAlignment:
                                          //               MainAxisAlignment.center,
                                          //           children: [
                                          //             // Icon(Icons.photo_library_rounded),
                                          //             // SizedBox(
                                          //             //   width: 5,
                                          //             // ),
                                          //             Text('Galeri',
                                          //                 style: GoogleFonts.acme(
                                          //                     fontSize: 20,
                                          //                     color:
                                          //                         Colors.white))
                                          //           ],
                                          //         ),
                                          //       ),
                                          //     ),
                                          //   ),
                                          //   flex: 1,
                                          // ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              height: 50,
                              child: Padding(
                                padding: const EdgeInsets.all(0),
                                child: ListView(
                                  scrollDirection: Axis.horizontal,
                                  children: [
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Padding(
                                      padding: messageGetX.gifExpanded.value
                                          ? EdgeInsets.only(
                                              bottom: 5, left: 5, right: 5)
                                          : const EdgeInsets.all(5),
                                      child: Material(
                                        borderRadius:
                                            messageGetX.gifExpanded.value
                                                ? BorderRadius.vertical(
                                                    bottom: Radius.circular(30))
                                                : BorderRadius.circular(30),
                                        color: Colors.redAccent,
                                        child: InkWell(
                                          onTap: () {
                                            messageGetX.expandSocial(false);
                                            messageGetX.expandWords(false);
                                            messageGetX.expandPhoto(false);
                                            messageGetX.expandGif(
                                                !messageGetX.gifExpanded.value);
                                          },
                                          borderRadius: messageGetX
                                                  .gifExpanded.value
                                              ? BorderRadius.vertical(
                                                  bottom: Radius.circular(30))
                                              : BorderRadius.circular(30),
                                          child: Icon(
                                            Icons.gif,
                                            color: Colors.white,
                                            size: 40,
                                          ),
                                        ),
                                      ),
                                    ),
                                    // CircleAvatar(
                                    //   backgroundColor: Colors.redAccent,
                                    //   radius: 20,
                                    //   child: Icon(Icons.gif),
                                    // ),
                                    // SizedBox(
                                    //   width: 5,
                                    // ),
                                    Padding(
                                      padding: messageGetX.socialExpanded.value
                                          ? EdgeInsets.only(
                                              bottom: 5, left: 5, right: 5)
                                          : const EdgeInsets.all(5),
                                      child: Material(
                                        borderRadius:
                                            messageGetX.socialExpanded.value
                                                ? BorderRadius.vertical(
                                                    bottom: Radius.circular(30))
                                                : BorderRadius.circular(30),
                                        color: Colors.green,
                                        child: InkWell(
                                          onTap: () {
                                            messageGetX.expandGif(false);
                                            messageGetX.expandWords(false);
                                            messageGetX.expandPhoto(false);
                                            messageGetX.expandSocial(
                                                !messageGetX
                                                    .socialExpanded.value);
                                          },
                                          borderRadius: messageGetX
                                                  .socialExpanded.value
                                              ? BorderRadius.vertical(
                                                  bottom: Radius.circular(30))
                                              : BorderRadius.circular(30),
                                          child: Padding(
                                            padding: const EdgeInsets.all(7.5),
                                            child: Icon(
                                              Icons.contact_page_outlined,
                                              color: Colors.white,
                                              size: 25,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    // SizedBox(
                                    //   width: 5,
                                    // ),
                                    Padding(
                                      padding: messageGetX.photoExpanded.value
                                          ? EdgeInsets.only(
                                              bottom: 5, left: 5, right: 5)
                                          : const EdgeInsets.all(5),
                                      child: Material(
                                        borderRadius:
                                            messageGetX.photoExpanded.value
                                                ? BorderRadius.vertical(
                                                    bottom: Radius.circular(30))
                                                : BorderRadius.circular(30),
                                        color: Colors.orange,
                                        child: InkWell(
                                          onTap: () {
                                            messageGetX.expandGif(false);
                                            messageGetX.expandWords(false);
                                            messageGetX.expandSocial(false);
                                            messageGetX.expandPhoto(!messageGetX
                                                .photoExpanded.value);
                                          },
                                          borderRadius: messageGetX
                                                  .photoExpanded.value
                                              ? BorderRadius.vertical(
                                                  bottom: Radius.circular(30))
                                              : BorderRadius.circular(30),
                                          child: Padding(
                                            padding: const EdgeInsets.all(7.5),
                                            child: Icon(
                                              Icons.image_outlined,
                                              color: Colors.white,
                                              size: 25,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: messageGetX.wordsExpanded.value
                                          ? EdgeInsets.only(
                                              bottom: 5, left: 5, right: 5)
                                          : const EdgeInsets.all(5),
                                      child: Material(
                                        borderRadius:
                                            messageGetX.wordsExpanded.value
                                                ? BorderRadius.vertical(
                                                    bottom: Radius.circular(30))
                                                : BorderRadius.circular(30),
                                        color: Colors.purple,
                                        child: InkWell(
                                          onTap: () {
                                            messageGetX.expandSocial(false);
                                            messageGetX.expandGif(false);
                                            messageGetX.expandPhoto(false);
                                            messageGetX.expandWords(!messageGetX
                                                .wordsExpanded.value);
                                          },
                                          borderRadius: messageGetX
                                                  .wordsExpanded.value
                                              ? BorderRadius.vertical(
                                                  bottom: Radius.circular(30))
                                              : BorderRadius.circular(30),
                                          child: Padding(
                                            padding: const EdgeInsets.all(7.5),
                                            child: Icon(
                                              Icons.create_outlined,
                                              color: Colors.white,
                                              size: 25,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Obx(
                              () => Container(
                                height: 72.1,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: Row(
                                    children: [
                                      Expanded(
                                          child: Padding(
                                        padding: const EdgeInsets.only(
                                            right: 10,
                                            left: 0,
                                            top: 10,
                                            bottom: 10),
                                        child: TextField(
                                          maxLines:
                                              messageGetX.gifExpanded.value
                                                  ? 1
                                                  : 5,
                                          onChanged: (text) {
                                            messageGetX.query.value = text;
                                          },
                                          controller:
                                              messageGetX.gifExpanded.value
                                                  ? messageGetX.gif
                                                  : messageGetX.message,
                                          cursorColor: context.isDarkMode
                                              ? Colors.white.withOpacity(0.8)
                                              : Colors.grey[900],
                                          scrollPadding: EdgeInsets.all(0),
                                          decoration: InputDecoration(
                                              hintMaxLines: 1,
                                              helperMaxLines: 1,
                                              suffixIcon: GestureDetector(
                                                onTap: () {
                                                  List<String> temp =
                                                      Utils.words.toList();
                                                  int index = Random()
                                                      .nextInt(temp.length - 1);
                                                  messageGetX.message.text =
                                                      temp[index];
                                                },
                                                child: Icon(
                                                  Icons.shuffle_rounded,
                                                  color: context.isDarkMode
                                                      ? Colors.white
                                                      : Colors.black,
                                                ),
                                              ),
                                              hintText:
                                                  messageGetX.gifExpanded.value
                                                      ? "Tenor'da gif arayın"
                                                      : 'Mesaj girin',
                                              focusColor: Colors.black,
                                              isDense: true,
                                              focusedBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: context.isDarkMode
                                                          ? Colors.white
                                                              .withOpacity(0.95)
                                                          : Colors.black,
                                                      width: 2),
                                                  borderRadius:
                                                      BorderRadius.circular(30),
                                                  gapPadding: 0),
                                              border: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: context.isDarkMode
                                                          ? Colors.white
                                                              .withOpacity(0.5)
                                                          : Colors.black,
                                                      width: 2),
                                                  borderRadius:
                                                      BorderRadius.circular(30),
                                                  gapPadding: 0)),
                                        ),
                                      )),
                                      Material(
                                        borderRadius: BorderRadius.circular(30),
                                        color: Colors.blue,
                                        child: InkWell(
                                          onTap: messageGetX.gifExpanded.value
                                              ? () {
                                                  messageGetX.search.value =
                                                      messageGetX.query.value;
                                                }
                                              : () async {
                                                  if (messageGetX.message.text
                                                      .trim()
                                                      .isEmpty) {
                                                    return;
                                                  }
                                                  String content =
                                                      messageGetX.message.text;
                                                  messageGetX.message.text = '';
                                                  await firebaseApi.firestore
                                                      .collection('Pairs')
                                                      .doc(widget.pairId)
                                                      .update({
                                                    'hasMessage': true,
                                                    'lastDate': DateTime.now(),
                                                    'new': true,
                                                    'lastSender': firebaseApi
                                                        .auth.currentUser!.uid,
                                                    'lastName':
                                                        infosGetx.name.value,
                                                    'lastMessage': content
                                                  });
                                                  await firebaseApi.firestore
                                                      .collection('Pairs')
                                                      .doc(widget.pairId)
                                                      .collection('Messages')
                                                      .add({
                                                    'content': content,
                                                    'isText': true,
                                                    'isSocial': false,
                                                    'socialName': '',
                                                    'launch': '',
                                                    'photoLink': '',
                                                    'from': firebaseApi
                                                        .auth.currentUser!.uid,
                                                    'date': DateTime.now()
                                                  });
                                                },
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: messageGetX.gifExpanded.value
                                                ? Icon(
                                                    Icons.search,
                                                    size: 30,
                                                    color: Colors.white,
                                                  )
                                                : RotatedBox(
                                                    quarterTurns: 1,
                                                    child: Icon(
                                                      Icons.navigation_rounded,
                                                      size: 30,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: padding,
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
        ),
      ),
    );
  }
}
