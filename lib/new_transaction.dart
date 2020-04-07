import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function newTransaction;
  NewTransaction(this.newTransaction);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime _selectedDate;

  void submitData() {
    final title = _titleController.text;
    final amount = double.parse(_amountController.text);
    if (title.isEmpty || amount <= 0||_selectedDate==null) return;
    widget.newTransaction(title, amount,_selectedDate);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
          child: Card(
        
          child: Container(
            padding:EdgeInsets.only(
              left:10,
              right:10,
              top:10,
              bottom:MediaQuery.of(context).viewInsets.bottom+10,
            ),
            
              child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          TextField(
            decoration: InputDecoration(labelText: 'Title'),
            controller: _titleController,

            //onChanged: (val){
            //  titleInput=val;
            //},
          ),
          TextField(
            decoration: InputDecoration(labelText: 'Amount'),
            controller: _amountController,
            keyboardType: TextInputType.number,
            onSubmitted: (_) => submitData(),
            //onChanged: (val){
            //  amountInput=val;
            //},
          ),
          Container(
            height: 100,
            child: Row(
              children: <Widget>[
                Text(_selectedDate==null?'No date chosen':'Date Chosen:'+DateFormat.yMMMd().format(_selectedDate)),
                FlatButton(
                  child:
                      Text('Choose date', style: Theme.of(context).textTheme.title),
                  onPressed: () {
                    showDatePicker(context: context,
                     initialDate: DateTime.now(),
                      firstDate: DateTime(2019),
                       lastDate: DateTime.now()
                       ).then((pickedDate){
                      if(pickedDate==null)
                        return;
                        else
                        setState(() {
                        _selectedDate=pickedDate;  
                        });
                        
                      
                    });
                  },
                ),
              ],
            ),
          ),
          RaisedButton(
            color: Theme.of(context).primaryColor,
              onPressed: submitData,
              child: Text("Add Transaction", style: TextStyle(color: Colors.white)),
              )
        ],
      ))),
    );
  }
}
