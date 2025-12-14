import 'package:transport_dashboard/widgets/all_invoice.dart';
import 'package:transport_dashboard/widgets/month_invoice.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FacturaView extends StatelessWidget {
  const FacturaView({super.key});

  @override
  Widget build(BuildContext context) {

     final size = MediaQuery.of(context).size;
    return size.width < 860 ?

    mobileFactura(size):
    
    
    Row(

      children: [
        
        Expanded(
          flex: 2,
          child: Container(
            width: 950,
            height: 1000,
            color: Colors.white,
            child: Column(

              children: [

                 
                 
                 const SizedBox(height: 40),

                  
                 
                 Row(
                   children: [
                     Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5.0),
                       child: Align(
                         alignment: const Alignment( - 1.0, 0.0, ), 
                         child: Text("FACTURA ONLINE",
                         style: GoogleFonts.merienda(color: Colors.black, fontSize: 35, fontWeight: FontWeight.w900),
                                  ),
                       ),
                     ),

                     const SizedBox(width: 5),
                     
                     const Icon(
                      Icons.waving_hand_rounded,
                      color: Color.fromARGB(255, 240, 217, 15),
                      ),

                   ],
                 ),

                
                    
               const SizedBox(height: 80),   
               
                
               Expanded(
                flex: size.width < 911 ? 1 :2,
                child: const MonthInvoice()),              
                    
              ],
            ),
          ),
        ),       

        
        const Expanded(
          flex: 1,
          child:AllInvoices()),


       
      ],
    );
      
    
  }


  Widget mobileFactura(Size size){
    
    return SingleChildScrollView(

     scrollDirection: Axis.vertical,
      child: Column(
          children: [
      
              
                  const SizedBox(height: 55),
                  
                  Row(
                   children: [
                     Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5.0),
                       child: Align(
                         alignment: const Alignment( - 1.0, 0.0, ), 
                         child: Text("FACTURA ONLINE",
                         style: GoogleFonts.merienda(
                          color: Colors.black,
                           fontSize: size.width < 500 ? 25 : 35,
                           fontWeight: FontWeight.w900),
                           ),
                       ),
                     ),

                     const SizedBox(width: 5),
                     
                     const Icon(
                      Icons.waving_hand_rounded,
                      color: Color.fromARGB(255, 240, 217, 15),
                      ),

                   ],
                 ),

                  Container(
                    color: Colors.transparent,
                    constraints: const BoxConstraints(minWidth: 350, minHeight: 625),
                    child: const MonthInvoice(),),


                    Container(
                    color: Colors.transparent,
                    width: size.width,
                    height: 1100,
                    child: const AllInvoices()),


                 
          ],
      ),
    );
  }
}