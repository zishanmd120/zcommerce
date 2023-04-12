import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:zcommerce/Screens/product.dart';

class Dashboard extends StatefulWidget {
  final token;
  const Dashboard({@required this.token,Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {

  late String email;
  List? items;
  @override
  void initState() {
    super.initState();
    Map<String,dynamic> jwtDecodedToken = JwtDecoder.decode(widget.token);
    email = jwtDecodedToken['email'];
    readProducts();
  }

  List _products = [];
  Future<void> readProducts() async{
    final String response = await rootBundle.loadString('assets/data.json');
    final data = await json.decode(response);
    setState(() {
      _products = data["products"];
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Hello, Sir',style: TextStyle(fontSize: 30.0,fontWeight: FontWeight.w700),),
                      const SizedBox(height: 8.0),
                      Text('@$email',style: const TextStyle(fontSize: 20),),
                    ],
                  ),
                  const Icon(Icons.notifications_none_outlined, size: 50,),
                ],
              ),
            ),
            const Divider(),
            const SizedBox(height: 20,),
            _products.isNotEmpty ? Expanded(
              child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 4.0,
                      mainAxisSpacing: 4.0
                  ),
                  itemCount: _products.length,
                  itemBuilder: (context,index){
                    return InkWell(
                      key: ValueKey(_products[index]["id"]),
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>DetailScreen(
                          name : _products[index]["name"],
                          img : _products[index]["img"],
                          tk : _products[index]["tk"],
                          des : _products[index]["des"],
                          qty : _products[index]["qty"]
                        )));
                      },
                      child: Column(
                              children: [
                                Flexible(
                                  child: SizedBox(
                                    height: 250,
                                    width: 200,
                                    child: Image.network(
                                      _products[index]["img"],
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Text(_products[index]["name"], style: const TextStyle(fontSize: 25),),
                              ],
                            ),
                    );
                        }
              ),
            ) : const SizedBox()
          ],
        ),
      ),
    );
  }
}