import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class ProductCard extends StatelessWidget {
  final String name;
  final String imageurl;
  final double price;
  final String offerTag;
  final Function onTap;
  const ProductCard({super.key, required this.name, required this.imageurl, required this.price, required this.offerTag, required this.onTap});
  
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
       onTap();
      },
      child: Card(
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            Image.network(
              imageurl,
              fit:BoxFit.cover,
              width:300,
            ),
            

            SizedBox(height: 9),
            Text(name,style:TextStyle(fontSize: 16),overflow:TextOverflow.ellipsis),
            SizedBox(height: 9),
            Text('Rs.$price',style:TextStyle(fontSize: 16),overflow:TextOverflow.ellipsis),
            SizedBox(height: 4),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                color:Colors.green,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                offerTag,
                style:TextStyle(color: Colors.white,fontSize: 12),
              ),
            )
          ],),
        ),
      ),
    );
    

    
  }
}