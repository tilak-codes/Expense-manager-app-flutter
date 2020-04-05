import 'package:expense_app/transaction_list.dart';
import 'package:flutter/material.dart';
import 'transaction.dart';
import 'new_transaction.dart';
import 'transaction_list.dart';
import 'chart.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "Smart Khata",
        theme: ThemeData(
          
          primarySwatch: Colors.pink,
          fontFamily: 'PatrickHand',
          textTheme: ThemeData.light().textTheme.copyWith(
              title: TextStyle(
                  color: Colors.pink[300],
                  fontFamily: 'PatrickHand',
                  fontWeight: FontWeight.bold,
                  fontSize: 22)),
          appBarTheme: AppBarTheme(
              textTheme: ThemeData.light().textTheme.copyWith(
                      title: TextStyle(
                    color: Colors.white,
                    fontFamily: 'PatrickHand',
                    fontSize: 30,
                  ))),
        ),
        home: MyHomePage());
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _userTransaction = [];
  List<Transaction> get _recentTransactions {
    return _userTransaction.where((tx) {
      return tx.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  void _addNewTransaction(String txtitle, double txamount,DateTime chosenDate) {
    final newTx = Transaction(
        id: DateTime.now().toString(),
        date: chosenDate,
        title: txtitle,

        amount: txamount);

    setState(() {
      _userTransaction.add(newTx);
    });
  }

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return GestureDetector(
            onTap: () {},
            child: NewTransaction(_addNewTransaction),
            behavior: HitTestBehavior.opaque,
          );
        });
  }
  void _deleteTransaction(String id){
    setState(() {
      _userTransaction.removeWhere((tx) => tx.id==id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Smart Khata app"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => _startAddNewTransaction(context),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Chart(_recentTransactions),
            TransactionList(_userTransaction,_deleteTransaction),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _startAddNewTransaction(context),
      ),
    );
  }
}
