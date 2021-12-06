import 'package:flutter/material.dart';
import 'package:kisileruygulamasi/kisiler.dart';
import 'package:kisileruygulamasi/kisilerdao.dart';
import 'package:kisileruygulamasi/main.dart';

class KisiDetaySayfa extends StatefulWidget {
  Kisiler kisi;


  KisiDetaySayfa({required this.kisi});

  @override
  _KisiDetaySayfaState createState() => _KisiDetaySayfaState();
}

class _KisiDetaySayfaState extends State<KisiDetaySayfa> {
  var tfKisiAd=TextEditingController();
  var tfKisiTel=TextEditingController();
  Future<void> guncelle(int kisi_id,String kisi_ad,String kisi_tel) async {
    await Kisilerdao().kisiGuncelle(kisi_id, kisi_ad, kisi_tel);
    Navigator.push(context, MaterialPageRoute(builder: (context)=>AnaSayfa()));
  }
  @override
  void initState() {
    super.initState();
    var kisi=widget.kisi;
    tfKisiAd.text=kisi.kisi_ad;
    tfKisiTel.text=kisi.kisi_tel;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Kişi Detay"),
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
      guncelle(widget.kisi.kisi_id, tfKisiAd.text, tfKisiTel.text);
        },
        tooltip: 'Kişi Ekle ',
        icon: const Icon(Icons.update),
        label: Text("Güncelle"),
      ),
    );
  }
}
