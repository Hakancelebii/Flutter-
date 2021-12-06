// @dart=2.9
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:kisileruygulamasi/kisidetaysayfa.dart';
import 'package:kisileruygulamasi/kisikayitsayfasi.dart';
import 'package:kisileruygulamasi/kisiler.dart';
import 'package:kisileruygulamasi/kisilerdao.dart';

void main() {
  runApp( MyApp());
}

class MyApp extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:  AnaSayfa(),
    );
  }
}

class AnaSayfa extends StatefulWidget {
  @override
  State<AnaSayfa> createState() => _AnaSayfaState();
}

class _AnaSayfaState extends State<AnaSayfa> {

  bool aramaYapiliyorMu = false;
  String aramaKelimesi ="";
  Future<List<Kisiler>> tumKisileriGoster() async {
    var kisilerListesi= await Kisilerdao().tumKisiler();
    return kisilerListesi;
  }
  Future<List<Kisiler>> aramaYap(String aramaKelimesi) async {
    var kisilerListesi= await Kisilerdao().kisiArama(aramaKelimesi);
    return kisilerListesi;
  }
  Future<void> sil(int kisi_id) async {
    await Kisilerdao().kisisil(kisi_id);
    setState(() {
    });
  }
  Future<bool> uygulamayiKapat() async {
    await exit(0);
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading:IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: (){
         uygulamayiKapat();
          },
        ) ,
        title: aramaYapiliyorMu ?
            TextField(
              decoration: InputDecoration(hintText:"Arama için Birşeyler Yazınız"),
              onChanged: (aramaSonucu){
                print("Arama Sonucu : $aramaSonucu");
                setState(() {
                  aramaKelimesi=aramaSonucu;
                });
              },
            )
            :  Text("Kişiler Uygulaması"),
        actions: [
          aramaYapiliyorMu ?
          IconButton(
            icon: Icon(Icons.cancel_rounded),
            onPressed: (){
              setState(() {
                aramaYapiliyorMu =false;
                aramaKelimesi="";
              });
            },
          )
              : IconButton(
            icon: Icon(Icons.search),
            onPressed: (){
              setState(() {
                aramaYapiliyorMu =true;
              });
            },
          ),
        ],
      ),
      body: WillPopScope(
        onWillPop: uygulamayiKapat,
        child: FutureBuilder<List<Kisiler>>(
          future: aramaYapiliyorMu ? aramaYap(aramaKelimesi): tumKisileriGoster(),
          builder: (context,snapshot){
            if(snapshot.hasData){
              var kisilerListesi=snapshot.data;
              return ListView.builder(
                itemCount: kisilerListesi.length,
                itemBuilder: (context,indeks){
                  var kisi=kisilerListesi[indeks];
                  return GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> KisiDetaySayfa(kisi: kisi,)));
                    },
                    child: Card(
                      child: SizedBox(
                        height: 62,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(" ${kisi.kisi_ad}",style: TextStyle(fontWeight: FontWeight.bold),),
                            Text(" ${kisi.kisi_tel} "),
                            IconButton(
                              icon: Icon(Icons.delete,color: Colors.black54,),
                              onPressed: (){
                                sil(kisi.kisi_id);
                              },
                            ),

                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            }else{
              return Center();
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=> KisiKayitSayfa()));
        },
        tooltip: 'Kişi Ekle ',
        child: const Icon(Icons.add),
      ),
    );
  }
}
