import 'package:flutter/material.dart';
import 'package:gamehub/getx/mainGetx.dart';
import 'package:get/get.dart';

class Help extends StatelessWidget {
  const Help({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MainGetX mainGetX = Get.find();
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset('assets/help.jpg',fit: BoxFit.cover,),
          Positioned(child: Column(children: [
            Material(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(40),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(40),
                        onTap: () {
                          Get.back();
                          mainGetX.changeNavBar(2);
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 40),
                          child: Text(
                            "Profile git",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                color: Colors.black, fontSize: 22,fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
            TextButton(
              onPressed: (){
              Get.back();
            }, child: Text('Atla',style: TextStyle(color: Colors.white,fontSize: 19),))
          ],),bottom: 70,right: 0,left: 0,)
        ],
      ),
    );
  }
}