

import 'package:transport_dashboard/constants/constants.dart';
import 'package:flutter/material.dart';

class ContentInvoice extends StatelessWidget {
  const ContentInvoice({super.key});

  @override
  Widget build(BuildContext context) {


    final size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),


      child: Container(
        constraints: const BoxConstraints(maxWidth: 450),
        child: Row(
        
              children: [
        
        
                    
                Container(
                width: 50,
                height: 50,
                decoration: decorationDriversOnline(),
                child: const Icon(
                Icons.account_balance_wallet_rounded,
                size: 38,
                
                ),
              ),
              
              const SizedBox(width: 12),
              
              
              Column(
                    
                children:[                
                  
                    
                    
                  Container(
                  color:  Colors.white, 
                  child: Text("01-02-2023",
                  style: size.width < 1144 ? h7 : h6,
                   ),
                ),
                
                if(size.width < 1403)
              
                Container(
                  width: 100,
                  height: 30,
                  decoration: decorationButton(),
                  child: OutlinedButton(
                    onPressed: (){},
                   child: Center(child: Text('completo', style: h11))
                         ),
                        )
              
                
                    
              ],
                        ),
        
                Container(
                  width: 10,
                ),
        
                if(size.width >= 1403)
                
                Container(
                  width: 115,
                  height: 35,
                  decoration: decorationButton(),
                  child: OutlinedButton(
                    onPressed: (){},
                   child: Text('completado', style: h11)
                         ),
                        )
          ],
        ),
      ),
    );
  }

  BoxDecoration decorationButton() => BoxDecoration(
    color: titleColor,
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
