import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {State<HomePage> createState() => _HomePageState();}

class _HomePageState extends State<HomePage> {
  int genda=0;
  final altura = TextEditingController();
  final peso = TextEditingController();
  FocusNode alturaFocus = new FocusNode(), pesoFocus = new FocusNode();
  var tablasImc=[
    "Edad  IMC\tIdeal\n16-24  19-24\n25-34  20-25\n35-44  21-26\n45-54  22-27\n55-64  23-38\n65-90  25-30",
    "Edad  IMC\tIdeal\n16\t\t   19-24\n17-18  20-25\n19-24  21-26\n25-34  22-27\n35-54  23-38\n55-64  24-29\n65-90  25-30"
  ];

  @override
  Widget build(BuildContext context) {
    alturaFocus.addListener(()=>setState(() {}));
    pesoFocus.addListener(()=>setState(() {}));

    return Scaffold(
      appBar: AppBar(
        title: Text('Calcular IMC'),
        backgroundColor: Colors.green,
        actions: <Widget>[IconButton(onPressed: (){
          genda = 0;
          altura.clear();
          peso.clear();
          setState(() {});
        }, icon: Icon(Icons.delete_forever),),]
      ),
      body: Column(children: [
        Container(height: 20,),
        Text("Ingrese sus datos para calcular el IMC", style: TextStyle(fontWeight: FontWeight.bold),),
        Row(children: [
          IconButton(onPressed: (){genda=1;setState(() {});}, icon: Icon(Icons.female, color: genda!=1?Colors.grey:Colors.pink,)),
          IconButton(onPressed: (){genda=2;setState(() {});}, icon: Icon(Icons.male, color: genda!=2?Colors.grey:Colors.indigo,)),
        ],mainAxisAlignment: MainAxisAlignment.center,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text("📐", style: TextStyle(fontSize: 20,),),
            Container(
              width: MediaQuery.of(context).size.width*0.8,
              child: TextFormField(
                controller: altura,
                focusNode: alturaFocus,
                keyboardType: TextInputType.number,
                cursorColor: Colors.green,
                decoration: InputDecoration(
                  border: OutlineInputBorder(), 
                  focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.green,width: 2)),
                  labelText: "Ingresar altura (Metros)",
                  floatingLabelStyle: TextStyle(color: alturaFocus.hasFocus?Colors.green:Colors.grey),
                ),
              ),
            ),
          ],
        ),
        Container(height: 15,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Icon(Icons.monitor_weight),
            Container(
              width: MediaQuery.of(context).size.width*0.8,
              child: TextFormField(
                controller: peso,
                focusNode: pesoFocus,
                keyboardType: TextInputType.number,
                cursorColor: Colors.green,
                decoration: InputDecoration(
                  border: OutlineInputBorder(), 
                  focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.green,width: 2)),
                  labelText: "Ingresar peso (Kg)",
                  floatingLabelStyle: TextStyle(color: pesoFocus.hasFocus?Colors.green:Colors.grey),
                ),
              ),
            ),
          ],
        ),
        Container(height: 15,),
        MaterialButton(onPressed: (){
          if(altura.value.text.length < 1 || peso.value.text.length < 1 || genda == 0) {
            showDialog(context: context, builder: (BuildContext){
              return AlertDialog(
                title: Text("Error"),
                content: Text("Favor de ingresar todos los datos necesarios y seleccionar su género."),
                actions: [TextButton(onPressed: (){Navigator.of(context).pop();}, child: Text("Aceptar", style: TextStyle(fontSize: 16,color: Colors.black,),))],
              );
            });
            return;
          }
          double d_altura = (double.parse(altura.value.text));
          double d_peso = (double.parse(peso.value.text));
          String imc = (d_peso / (d_altura*d_altura)).toStringAsFixed(2);
          String s_genda = genda == 1? "mujeres": "hombres";
          showDialog(context: context, builder: (BuildContext){
            return AlertDialog(
              title: Text("Tu IMC: $imc", style: TextStyle(fontSize: 24,),),
              content: Container(
                color: Colors.white,
                child: Column(children: [
                    Text("Tabla del IMC para $s_genda", style: TextStyle(fontSize: 18,),),
                    Container(height: 10,),
                    Text(tablasImc[genda-1], style: TextStyle(fontSize: 18,wordSpacing: 10,),),
                  ],crossAxisAlignment: CrossAxisAlignment.start,mainAxisSize: MainAxisSize.min,),
              ),actions: [
                TextButton(
                  onPressed: (){Navigator.of(context).pop();},
                  child: Text("Aceptar", style: TextStyle(fontSize: 16,color: Colors.black,),),
                ),
              ],
            );}
          );
        },
        child: Text("Calcular", style: TextStyle(fontWeight: FontWeight.bold),),
        ),
      ],),
    );
  }
}