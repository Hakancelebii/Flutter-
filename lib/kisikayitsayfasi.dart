import 'package:flutter/material.dart';
import 'package:kisileruygulamasi/kisilerdao.dart';
import 'package:kisileruygulamasi/main.dart';

class KisiKayitSayfa extends StatefulWidget {

  @override
  _KisiKayitSayfaState createState() => _KisiKayitSayfaState();
}

class _KisiKayitSayfaState extends State<KisiKayitSayfa> {
  var tfKisiAd=TextEditingController();
  var tfKisiTel=TextEditingController();
  Future<void> kayit(String kisi_ad,String kisi_tel) async {
    await Kisilerdao().kisiekle(kisi_ad, kisi_tel);
    Navigator.push(context, MaterialPageRoute(builder: (context)=>AnaSayfa()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Kişi Kayıt "),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(right: 50 , left: 50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              TextField(
                decoration: InputDecoration(hintText: "Kişi Ad"),
                controller: tfKisiAd,
              ),
              TextField(
                decoration: InputDecoration(hintText: "Kişi Tel"),
                controller: tfKisiTel,
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: (){
        kayit(tfKisiAd.text, tfKisiTel.text);
        },
        tooltip: 'Kişi Ekle ',
        icon: const Icon(Icons.save),
        label: Text("Kaydet"),
      ),
    );
  }
}
