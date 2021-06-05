
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:portfolio/portfoliomodel.dart';
import 'package:flutter/material.dart';

//Dummy Application 

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;


   void addPortfolio(String userid, PortfolioModel portfolioName , PortfolioModel data ,PortfolioModel stocks ,PortfolioModel id ) async{
    try {
      Map<String, dynamic> val = <String, dynamic>{
        'id': id,
        "data": data,
        "stocks": stocks,
        "portfolio_name": portfolioName,
      };
      await firestore.collection('users').doc(userid).collection('portfolios').doc().set(val);
    } catch (e) {
      print(e);
    }
  }

  void getPortfolio(String userid, String portfolioId) async {
    DocumentSnapshot documentSnapshot;
    try {
      documentSnapshot = await firestore.collection('users').doc(userid).collection('portfolios').doc(portfolioId).get();
      print(documentSnapshot.data);
    } catch (e) {
      print(e);
    }
  }


  void getPortfolios(String userid) async {
    DocumentSnapshot documentSnapshot;
    try {
      documentSnapshot = await firestore.collection('users').doc(userid).get();
      print(documentSnapshot.data);
    } catch (e) {
      print(e);
    }
  }

  /*static Stream<QuerySnapshot> readItems() {
  CollectionReference notesItemCollection =
      firestore.collection('users').doc(userUid).collection('items').snapshots();
}*/

  void  updatePortfolio(String userid, PortfolioModel portfolio ,PortfolioModel data ,PortfolioModel stocks) async {

    Map<String, dynamic> val = <String, dynamic>{
       "data": data,
        "stocks": stocks,
  };

    try {
     await firestore.collection('users').doc(userid).collection('portfolios').doc(portfolio.id).update(val);
    } catch (e) {
      print(e);
    }
  }

  void deletePortfolio(String userid, PortfolioModel portfolio) async {
    try {
      firestore.collection('users').doc(userid).collection('portfolios').doc(portfolio.id).delete();
    } catch (e) {
      print(e);
    }
  }

   void deleteStock(String userid, PortfolioModel portfolio, List stock) async {
    try {
      var val= [];
      val.add(stock);
      firestore.collection('users').doc(userid).collection('portfolios').doc(portfolio.id).update({"Stocks":FieldValue.arrayRemove(val)});
    } catch (e) {
      print(e);
    }
  }

   void addStock(String userid, PortfolioModel portfolio, List stock) async {
    try {
      firestore.collection('users').doc(userid).collection('portfolios').doc(portfolio.id).update({"Stocks":FieldValue.arrayUnion(stock)});
    } catch (e) {
      print(e);
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter Firebase"),
      ),
    );
  }
}