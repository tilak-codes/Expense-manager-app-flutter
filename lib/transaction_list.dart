import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTx;
  TransactionList(this.transactions, this.deleteTx);
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 600,
        child: transactions.isEmpty
            ? Column(
                children: <Widget>[
                  Text('No Transactions added'),
                  Container(
                      height: 581,
                      child: Image.asset('assets/images/waiting.png',
                          fit: BoxFit.cover))
                ],
              )
            : ListView.builder(
                itemBuilder: (ctx, index) {
                  return Card(
                    elevation: 5,
                    margin: EdgeInsets.symmetric(horizontal: 5, vertical: 8),
                    child: ListTile(
                      leading: CircleAvatar(
                        radius: 30,
                        child: Container(
                            padding: EdgeInsets.all(6),
                            child: FittedBox(
                                child: Text('₹' +
                                    transactions[index].amount.toString()))),
                      ),
                      title: Text(transactions[index].title,
                          style: Theme.of(context).textTheme.title),
                      subtitle: Text(
                          DateFormat.yMMMd().format(transactions[index].date)),
                      trailing: IconButton(
                        icon: Icon(Icons.delete),
                        color: Theme.of(context).errorColor,
                        onPressed: () => deleteTx(transactions[index].id),
                      ),
                    ),
                  );
                },
                itemCount: transactions.length,
              ));
  }
}
