import 'package:client_application/controller/home_controller.dart';
import 'package:client_application/pages/login_page.dart';
import 'package:client_application/pages/product_description_page.dart';
import 'package:client_application/widget/drop_down_btn.dart';
import 'package:client_application/widget/multi_select_drop_down.dart';
import 'package:client_application/widget/product_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
     return GetBuilder<HomeController>(builder: (ctrl){
    return  RefreshIndicator(
      onRefresh:() async{
       ctrl.fetchProducts();
      },
      child: Scaffold(
      appBar: AppBar(
        title: const Text('Footware Store',style:TextStyle(
          fontWeight: FontWeight.bold,
        )),
        actions: [
          IconButton(onPressed: (){
            GetStorage box =GetStorage();
            box.erase();
            Get.offAll(const LoginPage());
          }, icon: const Icon(Icons.logout)),
        ],
      ),
      
      body:Column(children: [
      
        SizedBox(height: 50,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: ctrl.productCategories.length,
          itemBuilder: (context,index){
            return InkWell(
              onTap: (){
                ctrl.filterByCategory(ctrl.productCategories[index].name??'name');
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Chip(label:Text(ctrl.productCategories[index].name??'Error') ),
              ),
            );
        })
        ),
      
      
         Row(
          children: [
            Flexible(
           child: DropDownBtn(
              items:const ['Price low to high','Price high to low'],
              SelectedItemText:'Sort',
             onSelecetd: (selected ) { 
              ctrl.sortByPrice(ascending:selected=='Price low to high' ?true:false, );
              },
            ),
            ),
           Flexible(
            child: MultiSelectDropDown(items:const ['Adidas','Puma','Sketchers','Sparks'],
           onSelecetionChanged: (selectedItems) {  
            ctrl.filterByBrand(selectedItems);
           },)
           ),   
          ],
        ),
      
      
        
          
      Expanded(
            child: GridView.builder(gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,
            childAspectRatio: 0.8,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8
            ),
            itemCount: ctrl. productShowInUI.length,
             itemBuilder: (context,index){
              return ProductCard(
                name: ctrl. productShowInUI[index].name ?? '',
                imageurl: ctrl. productShowInUI[index].image??'url',
                price: ctrl. productShowInUI[index].price??00,
                 offerTag: '30% Off',
                  onTap: (){
                   Get.to(const ProductDescriptionPage(),arguments: {'data':ctrl.productShowInUI[index]});
                  },);
             }),
        ),
        
        
      ],)
      ),
    );
     });
  }
}