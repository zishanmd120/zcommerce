import 'package:flutter/material.dart';


class DetailScreen extends StatefulWidget {
  // const DetailScreen({Key? key}) : super(key: key);

  final name, tk, img, qty, des;

  const DetailScreen({super.key, this.name, this.tk, this.img, this.qty, this.des});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(widget.img, height: 400, width: double.infinity, fit: BoxFit.cover,),
              Text(widget.name, style: const TextStyle(fontSize: 45, color: Colors.deepPurple),),
              const SizedBox(height: 30,),
              Text(widget.des, style: const TextStyle(fontSize: 20),),
              const SizedBox(height: 50,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Availabe: ${widget.tk}', style: const TextStyle(fontSize: 20),),
                  Text('Price: ${widget.qty} Tk.', style: const TextStyle(fontSize: 20),),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
