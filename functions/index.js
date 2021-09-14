const functions = require("firebase-functions");
const admin = require("firebase-admin");
admin.initializeApp();
const firestore = admin.firestore();

exports.onPaired = functions.firestore.document('Pairs/{pairId}').onUpdate(async(snap, context)=>{
const pairId = context.params.pairId;

const before = snap.before.data();

const after = snap.after.data();

if(!before['visible'] && after['visible']){
    return;
}

if(!before['paired'] && after['paired']){
    await firestore.collection('Users').doc(after['from']).get().then(async(value)=>{

        await firestore.collection('Users').doc(after['to']).get().then(async(sender)=>{


            var payload = {
                notification: {
                    title: `${sender.data()['name']} ile eşleştin`,
                    body: `İlk mesajı hemen gönder`,
                    click_action: "FLUTTER_NOTIFICATION_CLICK"
                },
                data: {
                    "type": "pair",
                }
            }

            if(value.data()["n_newPair"]){
                admin.messaging().sendToDevice(value.data()["token"], payload);
            }
    
            
        });
    });
  }else{

    var user1 = after['from'];
    var user2 = after['to'];
    var reciever = "";
    var sender = "";

    if(user1 == after['lastSender']){
        reciever = user2;
        sender = user1;
    }else{
        reciever = user1;
        sender = user2;
    }

    await firestore.collection('Users').doc(reciever).get().then(async(value)=>{

        await firestore.collection('Users').doc(sender).get().then(async(senderData)=>{

            if(before[value.id]==after[value.id] && before[senderData.id]==after[senderData.id]){

                var avatarIsAsset = "";

                if(senderData.data()['avatarIsAsset']){
                    avatarIsAsset = "true";
                }else{
                    avatarIsAsset = "false";
                }

                var payload1 = {
                    notification: {
                        title: `${after['lastName']}`,
                        body: `${after['lastMessage']}`,
                        click_action: "FLUTTER_NOTIFICATION_CLICK"
                    },
                    data: {
                        "type": "message",
                        "pairId": snap.after.id,
                        "id": sender,
                        "avatar": `${senderData.data()['avatar']}`,
                        "avatarIsAsset": avatarIsAsset,
                        "name": `${senderData.data()['name']}`
                    }
                }

                if(value.data()["n_message"]){
                    admin.messaging().sendToDevice(value.data()["token"], payload1);
                }
        
                

            }else{

                if(before[value.id] == false && after[value.id]){

                    var payload2 = {
                        notification: {
                            title: `${value.data()["name"]} resim gönderimine izin verdi`,
                            body: `Sen izin vermediğin sürece resim gönderilemez`,
                            click_action: "FLUTTER_NOTIFICATION_CLICK"
                        },
                        data: {
                            "type": "photo",
                        }
                    }

                    if(senderData.data()["n_photos"]){
                        admin.messaging().sendToDevice(senderData.data()["token"], payload2);
                    }

                    
                } else{

                    if(before[senderData.id] == false && after[senderData.id]){

                        var payload3 = {
                            notification: {
                                title: `${senderData.data()["name"]} resim gönderimine izin verdi`,
                                body: `Sen izin vermediğin sürece resim gönderilemez`,
                                click_action: "FLUTTER_NOTIFICATION_CLICK"
                            },
                            data: {
                                "type": "photo",
                            }
                        }
    
                        if(value.data()["n_photos"]){
                            admin.messaging().sendToDevice(value.data()["token"], payload3);
                        }
                    }

                   



                }

            }


        });
    });

  }
})

exports.updateLimit = functions.pubsub.schedule('5 00 * * *').timeZone('Asia/Istanbul').onRun((context)=>{

    return admin.firestore().collection("Users").get().then(snapshot => {
        const promises = [];
        snapshot.forEach(doc => {
          promises.push(doc.ref.update({
            "limit": 20,
          }));
        });
        return Promise.all(promises)
    })
    .catch(error => {
      console.log(error);
      return null;
    });
  
    
    // firestore.collection('Users').get().then((data)=>{

    //     data.docs.forEach(async(data)=>{

    //         await firestore.collection('Users').doc(data.id).update({
    //             "limit": 20
    //         });




    //     });


    // });

})

exports.newPair = functions.firestore.document('Pairs/{pairId}').onCreate(async(snap,context)=>{
    var member1 = [];
    var member2 = [];
    var data = [];
    await admin.firestore().collection("Pairs").get().then(snapshot => {
        var list = snapshot.docs;
        list.forEach(item => {
            if(item.id==snap.id){
                var index = list.indexOf(item);
                list.splice(index,1);
            }
        });
        list.forEach(doc => {
          member1.push(doc.data()["members"][0]);
          member2.push(doc.data()["members"][1]);
          data.push([doc.data()["members"][0],doc.data()["members"][1]]);
        });
        var users = [];
        users = snap.data()["members"];

        member1.forEach(element=>{
            if(element==users[0]){
                member2.forEach(element2=>{
                    if(element2==users[1]){
                        console.log('sil');
                        // snap.ref.delete();
                        return;
                    }
                });
            }
        });


        // data.forEach(element => {
        //     var list = [];
        //     list = element;
        //     if(list[0]==users[0] && list[1]==users[1]){
        //         snap.ref.delete();
        //         return;
        //     }else if(list[0]==users[1] && list[1]==users[0]){
        //         snap.ref.delete();
        //         return;
        //     }
            
        // });
    })
    .catch(error => {
      console.log(error);
    });
})