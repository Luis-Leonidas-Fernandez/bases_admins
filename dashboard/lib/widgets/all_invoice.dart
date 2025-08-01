import 'package:dashborad/constants/constants.dart';
import 'package:dashborad/widgets/content_all_invoice.dart';
import 'package:flutter/material.dart';

class AllInvoices extends StatelessWidget {
  const AllInvoices({super.key});

  @override
  Widget build(BuildContext context) {

    return  Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          
          children: [        
            
            const SizedBox(height: 25),
        
            Expanded(
              flex: 1,
              child: Container(
               width: 410,
               height: 298,
               decoration: decorationTopDrivers(),
               constraints: const BoxConstraints(maxWidth: 425, maxHeight: 298),               
              child: const Stack(
                children: [
                   
                  

                   Positioned(
                    top: 30,
                    left: 30,
                    child: TittleAllInvoice()),


                   Positioned(
                    top: 60,
                    left: 30,
                    child: WalletAvatar()),

                   SizedBox(height: 10),

                    Positioned(
                      top: 118,
                      left: 30,
                      child: WalletAvatar()),

                    SizedBox(height: 10),

                    Positioned(
                      top: 178,
                      left: 30,
                      child: WalletAvatar())
   
                ],
              ),  
              ),
            ),
        
            Container(
              color: Colors.transparent,
              width: 446,
              height: 20,
            ),
        
            Expanded(
              flex: 2,
              child: Container(
               width: 410,
               height: 510,               
              decoration: decorationDriversOnline(),
              child: const AllInvoiceList(),

                
              ),
            ),
        
           
          ],
        ),
      ),
    );
  }

  BoxDecoration decorationDriversOnline() => BoxDecoration(

    color: Colors.white,
     borderRadius: BorderRadius.circular(15.0),
     boxShadow: [ 
      
      BoxShadow(
      color: Colors.grey.shade500,
      offset: const Offset(4.0, 4.0),
      blurRadius: 15,
      spreadRadius: 1.0,),
      
      const BoxShadow(
      color: Colors.white,
      offset: Offset(-4.0, -4.0),
      blurRadius: 15,
      spreadRadius: 1.0,)
      ]
  );

  BoxDecoration decorationTopDrivers() => BoxDecoration(
     color: Colors.white,
     borderRadius: BorderRadius.circular(15.0),
     boxShadow: [ 
      
      BoxShadow(
      color: Colors.grey.shade500,
      offset: const Offset(4.0, 4.0),
      blurRadius: 15,
      spreadRadius: 1.0,),
      
      const BoxShadow(
      color: Colors.white,
      offset: Offset(-4.0, -4.0),
      blurRadius: 15,
      spreadRadius: 1.0,)
      ]

  );
}

class WalletAvatar extends StatelessWidget {
  const WalletAvatar({super.key});

  @override
  Widget build(BuildContext context) {

  
   final size = MediaQuery.of(context).size;
    
    return Row(
      children: [
        
        Container(
          width: 50,
          height: 50,
          decoration: decorationDriverAvatar(),
          child: const Icon(
          Icons.account_balance_wallet_rounded,
          size: 38,
          
          ),
        ),
        
        const SizedBox(width: 20),
        
        
        Column(
        
          children:[            
                    
      
            const SizedBox(height: 7),

            Container(
            color:  Colors.transparent, 
            child: Text("01-07-2024",
            style: h6,
            ),
          ),
        
        
          if(size.width < 1403)
           
          Container(
           width: 115,
           height: 27,           
          decoration: decorationButtonPagar(),
          child: OutlinedButton(
            onPressed: (){},
            child: Text("Pagar", style: h11))
          ),
        
          ]
        
        ),
        
        
        Container(
              width: 10,
            ),
    
            if(size.width >= 1403)
            
            Container(
              width: 115,
              height: 35,
              decoration: decorationButtonPagar(),
              child: OutlinedButton(
                onPressed: (){},
               child: Text('Pagar', style: h11)
                     ),
                    )
       
        ]
        );
  }

  BoxDecoration decorationButtonPagar() => BoxDecoration(
    color: containerColor,
    borderRadius: BorderRadius.circular(15)
  );

  BoxDecoration decorationDriverAvatar() => BoxDecoration(
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

class TittleAllInvoice extends StatelessWidget {
  const TittleAllInvoice({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      width: 200,
      height: 25,
      child: Text("Facturas a Pagadar",
       style: h5,
       ),
    );
  }
}

class NameDriverTop extends StatelessWidget {
  const NameDriverTop({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: 250,
      height: 50,
      child: Text("Caceres Orlando",
      style: h6,
      ),
    );
  }
}


class AllInvoiceList extends StatelessWidget {
  const AllInvoiceList({super.key});

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;
    return ListView(
      scrollDirection: Axis.vertical,
      children: [
             
             
    
             Padding(
              padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 28),
               child: Container(
                color: Colors.transparent,
                height: 20,
                width: 200,
                child: Text('Todas Mis Facturas', style: size.width < 869 ? h8 : h5 ),
                
               ),
             ),
    
    
             const ContentInvoice(),
            
             const ContentInvoice(),  
            
             const ContentInvoice(),  
            
             const ContentInvoice(),  
            
             const ContentInvoice(),
    
             const ContentInvoice(),
    
             const ContentInvoice(),
    
             const ContentInvoice(),
    
            const ContentInvoice(),
    
            const ContentInvoice(), 
    
    
    
          ]
        );
  }

  
}