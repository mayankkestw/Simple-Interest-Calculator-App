import 'package:flutter/material.dart';

void main(){
  runApp(
    MaterialApp(
     debugShowCheckedModeBanner: false,
     title: "Simple Interest Calculator App",
     home: SIForm(),
     theme: ThemeData(
       brightness: Brightness.dark,
       primaryColor: Colors.blue,
       accentColor: Colors.indigoAccent
     ),
    )
  );
}

class SIForm extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _SIFormState();
  }

}

class _SIFormState extends State<SIForm>{

  var _formKey = GlobalKey<FormState>();

  var _currencies = ['Rupees', 'Dollars', 'Pounds'];
  final _minimumPadding = 5.0;

  var _currentItemSelected = '';

  @override
	void initState() {
		super.initState();
		_currentItemSelected = _currencies[0];
	}
  
  TextEditingController principalController = TextEditingController();
  TextEditingController roiController = TextEditingController();
  TextEditingController termController = TextEditingController();

  String displayResult = '';

  @override
  Widget build(BuildContext context) {
    
    TextStyle textStyle = Theme.of(context).textTheme.title;
    
    return Scaffold(
      //resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text("Simple Interest Calculator")
        ),
        body: Form(
          key: _formKey,
          child: Padding(
          padding: EdgeInsets.all(_minimumPadding*2),
          child: ListView(
           //Column(
            children: <Widget>[
             getImageAsset(),           
             TextFormField(
               keyboardType: TextInputType.number,
               controller: principalController,
               validator: (String value){
                 if(value.isEmpty){
                   return "Please enter principal amount";
                 }
               },
               decoration: InputDecoration(
                 labelText: "Principal",
                 hintText: "Enter Principal e.g. 12000",
                 labelStyle: textStyle,
                 errorStyle: TextStyle(color: Colors.yellowAccent, fontSize: 15.0),
                 border: OutlineInputBorder(
                   borderRadius: BorderRadius.circular(5.0)
                 )
               )
             ),
             Padding(padding: EdgeInsets.only(top:_minimumPadding, bottom: _minimumPadding),),
             TextFormField(
               keyboardType: TextInputType.number,
               controller: roiController,
               validator: (String value){
                 if(value.isEmpty){
                   return "Please enter rate of interest";
                 }
               },
               decoration: InputDecoration(
                 labelText: "Rate of Interest",
                 labelStyle: textStyle,
                 errorStyle: TextStyle(color:Colors.yellowAccent, fontSize: 15.0),
                 hintText: "In percent",
                 border: OutlineInputBorder(
                   borderRadius: BorderRadius.circular(5.0)
                 )
               )
             ),

Padding(
   padding: EdgeInsets.only(top:_minimumPadding, bottom: _minimumPadding),
            child: Row(
              children: <Widget>[
             Expanded(child: TextFormField(
               keyboardType: TextInputType.number,
               controller: termController,
               validator: (String value){
                 if(value.isEmpty){
                   return "Please enter time";
                 }
               },
               decoration: InputDecoration(
                 labelText: "Term",
                 labelStyle: textStyle,
                 hintText: "Time in years",
                 errorStyle: TextStyle(color: Colors.yellowAccent, fontSize: 15.0),
                 border: OutlineInputBorder(
                   borderRadius: BorderRadius.circular(5.0)
                 )
               )
             ) ,),  

             Container(width: _minimumPadding*5,),

      Expanded( 
        child:
             DropdownButton<String>(
               items: _currencies.map((String value){
                  return DropdownMenuItem<String>(
                    child: Text(value),
                    value: value,
                    );
               }).toList(),
               value: _currentItemSelected,
               onChanged: (String newValueSelected){
                  _onDropDownItemSelected(newValueSelected);
               }
             )
             )
              ],
             ),)
            ,
            Padding(
              padding: EdgeInsets.only(bottom: _minimumPadding, top: _minimumPadding),
              child:
              Row(
             children: <Widget>[

               Expanded(
                 child: RaisedButton(
                   color: Theme.of(context).accentColor,
                   textColor: Theme.of(context).primaryColorDark,
                   child: Text("Calculate", textScaleFactor: 1.5),
                   onPressed: (){
                       setState(() {
                         if(_formKey.currentState.validate()){
                         this.displayResult = _calculateTotalReturn();
                         }
                       });
                   },
                 ),

               ),
               Expanded(
                 child: RaisedButton(
                   color: Theme.of(context).primaryColorDark,
                   textColor: Theme.of(context).primaryColorLight,
                   child: Text("Reset"),
                   onPressed: (){
                     setState(() {
                       _reset();
                     });
                   },
                 ),

               )


             ],

            )),

            Padding(
              padding: EdgeInsets.all(_minimumPadding*2),
              child: Text(this.displayResult),
            )
            
            ],
         // ),
          )
    ))
    );
  }

  Widget getImageAsset(){

     AssetImage assetImage = AssetImage('images/money.png');
     Image image = Image(image: assetImage, width: 135.0, height: 165.0,);
     return Container(
        child : image,
        margin: EdgeInsets.all(_minimumPadding*10),
     );

  }


void _onDropDownItemSelected(String newValueSelected) {
		setState(() {
		  this._currentItemSelected = newValueSelected;
		});
  }

String _calculateTotalReturn(){
  double principal = double.parse(principalController.text);
  double roi = double.parse(roiController.text);
  double term = double.parse(termController.text);

  double totalAmount = (principal*roi*term)/100;
  
  String result = "After $term years, your investment will be worth $totalAmount $_currentItemSelected";
  return result;
}

void _reset(){
  principalController.text = '';
  roiController.text= '';
  termController.text = '';
  displayResult = '';
  _currentItemSelected = _currencies[0];
}
}

