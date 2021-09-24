import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:gamehub/getx/mainGetx.dart';
import 'package:gamehub/screens/login/email.dart';
import 'package:gamehub/screens/login/finish.dart';
import 'package:gamehub/screens/login/home.dart';
import 'package:gamehub/screens/login/login.dart';
import 'package:gamehub/screens/login/questions.dart';
import 'package:gamehub/screens/login/second.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  MainGetX mainGetX = Get.find();
  PageController pageController = PageController();
  List<Color> colors = [
    Color.fromRGBO(170, 95, 239, 1),
    Color.fromRGBO(130, 100, 246, 1),
    Color.fromRGBO(102, 119, 223, 1),
    Color.fromRGBO(103, 166, 246, 1),
    Color.fromRGBO(84, 202, 242, 1)
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            controller: pageController,
            onPageChanged: (index) {
              mainGetX.pageIndex.value = index;
            },
            itemCount: 5,
            itemBuilder: (context, index) {
              return Container(
                color: colors[index],
                child: Padding(
                  padding: const EdgeInsets.all(50),
                  child: Image.asset(
                    'assets/splash/${index + 1}.jpg',
                    fit: BoxFit.fitWidth,
                  ),
                ),
              );
            },
          ),
          Positioned(
            child: Obx(
              () => GestureDetector(
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.grey[900],
                      borderRadius: BorderRadius.circular(15)),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Text(
                      mainGetX.pageIndex.value == 4 ? 'Bitir' : 'Sonraki',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
                ),
                onTap: () {
                  if (mainGetX.pageIndex.value == 4) {
                    Get.off(() => ModeSelect(), transition: Transition.fade);
                  } else {
                    pageController.nextPage(
                        duration: Duration(milliseconds: 300),
                        curve: Curves.linear);
                  }
                },
              ),
            ),
            bottom: 25,
            right: 40,
          ),
          Positioned(
            child: Obx(
              () => Container(
                child: Center(
                  child: SizedBox(
                    width: 85,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: List.generate(
                          5,
                          (index) => Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 2.5),
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(90),
                                      color: mainGetX.pageIndex.value == index
                                          ? Colors.white
                                          : Colors.black.withOpacity(0.2)),
                                  height: 12,
                                  width: 12,
                                ),
                              )),
                    ),
                  ),
                ),
              ),
            ),
            bottom: 40,
            right: 0,
            left: 0,
          )
        ],
      ),
    );
  }
}

class ModeSelect extends StatelessWidget {
  ModeSelect({Key? key}) : super(key: key);

  MainGetX mainGetX = Get.find();
  dynamic white;
  dynamic black;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          SizedBox(
            height: 12,
          ),
          Text(
            'Tarafını Seç',
            style: GoogleFonts.roboto(
                fontSize: 27,
                color: context.isDarkMode ? Colors.white : Colors.grey[900]),
          ),
          Expanded(
              child: Row(
            children: [
              Expanded(
                  child: Stack(
                fit: StackFit.expand,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: OpenContainer(
                      closedShape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      tappable: false,
                      openBuilder: (context, action) {
                        Future.delayed(Duration(milliseconds: 100), () {
                          Get.off(() => Login(), transition: Transition.fade);
                        });
                        return Container(
                          child: Image.asset(
                            'assets/modes/white.jpg',
                            fit: BoxFit.cover,
                          ),
                        );
                      },
                      closedBuilder: (context, action) {
                        white = action;
                        return ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.asset(
                            'assets/modes/white.jpg',
                            fit: BoxFit.cover,
                          ),
                        );
                      },
                    ),
                  ),
                  Obx(
                    () => mainGetX.themeSelected.value
                        ? Container()
                        : Center(
                            child: Material(
                              color: Colors.black.withOpacity(0.85),
                              borderRadius: BorderRadius.circular(5),
                              child: InkWell(
                                onTap: () {
                                  if (Get.isDarkMode) {
                                    Get.changeTheme(ThemeData.light());
                                    GetStorage().write("isDark", false);
                                  }
                                  Future.delayed(Duration(milliseconds: 100),
                                      () {
                                    Get.off(() => Login(),
                                        transition: Transition.fade);
                                  });
                                },
                                borderRadius: BorderRadius.circular(5),
                                child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Text(
                                    'Beyaz mod',
                                    style: GoogleFonts.roboto(
                                        fontSize: 20, color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                          ),
                  )
                ],
              )),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
                child: Container(
                  height: double.infinity,
                  width: 3,
                  color: Colors.grey[300],
                ),
              ),
              Expanded(
                  child: Stack(
                fit: StackFit.expand,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: OpenContainer(
                      closedShape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      tappable: false,
                      openBuilder: (context, action) {
                        Future.delayed(Duration(milliseconds: 100), () {
                          Get.off(() => Login(), transition: Transition.fade);
                        });
                        return Container(
                          child: Image.asset(
                            'assets/modes/black.jpg',
                            fit: BoxFit.cover,
                          ),
                        );
                      },
                      closedBuilder: (context, action) {
                        black = action;
                        return ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.asset(
                            'assets/modes/black.jpg',
                            fit: BoxFit.cover,
                          ),
                        );
                      },
                    ),
                  ),
                  Obx(
                    () => mainGetX.themeSelected.value
                        ? Container()
                        : Center(
                            child: Material(
                              color: Colors.black.withOpacity(0.85),
                              borderRadius: BorderRadius.circular(5),
                              child: InkWell(
                                onTap: () {
                                  if (!Get.isDarkMode) {
                                    Get.changeTheme(ThemeData.dark());
                                    GetStorage().write("isDark", true);
                                  }
                                  Future.delayed(Duration(milliseconds: 100),
                                      () {
                                    Get.off(() => Login(),
                                        transition: Transition.fade);
                                  });
                                },
                                borderRadius: BorderRadius.circular(5),
                                child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Text(
                                    'Koyu mod',
                                    style: GoogleFonts.roboto(
                                        fontSize: 20, color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                          ),
                  )
                ],
              )),
            ],
          ))
        ],
      )),
    );
  }
}

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  PageController controller = PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: controller,
        physics: NeverScrollableScrollPhysics(),
        children: [
          LoginHome(
            controller: controller,
          ),
          RegisterEmail(
            controller: controller,
          ),
          LoginEmail(
            controller: controller,
          ),
          FinishProfile(
            controller: controller,
          ),
          Second(pageController: controller),
          Questions(controller: controller)
        ],
      ),
    );
  }
}
