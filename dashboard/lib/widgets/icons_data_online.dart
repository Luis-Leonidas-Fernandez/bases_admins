import 'package:dashborad/constants/constants.dart';
import 'package:dashborad/models/drivers.dart';
import 'package:flutter/material.dart';

class IconsDriversOnline extends StatelessWidget {


  final Driver? driver;
  const IconsDriversOnline({super.key, this.driver});

  @override
  Widget build(BuildContext context) {

    final nom = driver?.nombre ?? "";
    final apell = driver?.apellido ?? "";
    final nameCompleto = '$nom  $apell';
    final nameDriver = nameCompleto.length > 10? nameCompleto.substring(0, 10) : nameCompleto; 
    
    final size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 20),
      child: Row(
      
            children: [
      
      
                  
              Container(
              width:  size.width < 1000 ? 45 : 50,
              height: size.width < 1000 ? 45 : 50,
              decoration: decorationDriversOnline(),
              child: const Icon(
              Icons.person,
              size: 38,
              
              ),
            ),
            
            const SizedBox(width: 16),
            
            
            Column(
                  
              children:[                
                
                  
                  
                Container(
                color:  Colors.white, 
                child: Text(nameDriver,
                style: h6,
                 ),
              ),
              
              if(size.width < 1403)
            
              Container(
                width: 82,
                height: 33,
                decoration: decorationButton(),
                child: OutlinedButton(
                  onPressed: (){},
                 child: Text('online', style: h11)
                       ),
                      )
            
              
                  
            ],
                      ),
      
              Container(
                width: 10,
              ),
      
              if(size.width >= 1403)
              
              Container(
                width: 85,
                height: 35,
                decoration: decorationButton(),
                child: OutlinedButton(
                  onPressed: (){},
                 child: Text('online', style: h8)
                       ),
                      )
        ],
      ),
    );
  }

  BoxDecoration decorationButton() => BoxDecoration(
    color: firstColor,
    borderRadius: BorderRadius.circular(15)
  );

  BoxDecoration decorationDriversOnline() => BoxDecoration(

    color: Colors.white,
     borderRadius: BorderRadius.circular(15.0),
     boxShadow: [ 
      
      BoxShadow(
      color: Colors.grey.shade500,
      offset: const Offset(4.0, 4.0),
      blurRadius: 10,
      spreadRadius: 1.0,),
      
      const BoxShadow(
      color: Colors.white,
      offset: Offset(-4.0, -4.0),
      blurRadius: 10,
      spreadRadius: 1.0,)
      ]
  );
}