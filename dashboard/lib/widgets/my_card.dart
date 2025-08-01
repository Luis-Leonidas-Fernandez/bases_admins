
import 'package:dashborad/constants/constants.dart';
import 'package:dashborad/models/drivers.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyCard extends StatelessWidget {

  final Data? data;
  const MyCard({super.key, this.data});

  @override
  Widget build(BuildContext context) {
  
    final size = MediaQuery.of(context).size; 

    return Row(
    
         children: [
    
          Expanded(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 300, maxHeight: 200),
              child: Container(            
                 width: 300,
                height: size.width < 856 ? 150 : 200,
                
                decoration: decorationContainer(),
                child: Stack(
                  children: [
                   
                     contentContainerBlue(size, data)               
                  
                  ],) ),
            ),
          ),   
    
    
           Container(
            color: Colors.transparent,
            width: 20,
            height: 200,
           ), 
          
    
          
           Expanded(
             child: ConstrainedBox(
               constraints: const BoxConstraints(maxWidth: 300, maxHeight: 200),
               child: Container(            
                width: 300,
                height: size.width < 856 ? 150 : 200,
                decoration: decorationContainerOrange(),
                child:  Stack(
                  children: [
                         
                         contentContainerOrange(size, data)
                    
                  ],
                )
                         ),
             ),
           ),
    
          Container(
            color: Colors.transparent,
            width: 20,
            height: 200,
           ), 
    
           Expanded(
             child: ConstrainedBox(
               constraints: const BoxConstraints(maxWidth: 300, maxHeight: 200),
               child: Container(            
                width: 300,
                height: size.width < 856 ? 150 : 200,
                decoration: decorationContainerLigth(),
                child: Stack(
                  children: [
                      
                      contentContainerPink(size, data)
                    
                  ],
                )
                         ),
             ),
           ),
         ],
    );
   }

  BoxDecoration decorationContainerLigth() => BoxDecoration(
    color: containerColor,
     borderRadius: BorderRadius.circular(20.0),
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

  BoxDecoration decorationContainerOrange() => BoxDecoration(
    color: containerColor,
     borderRadius: BorderRadius.circular(20.0),
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

  BoxDecoration decorationContainer() => BoxDecoration(
    color: containerColor,
     borderRadius: BorderRadius.circular(20.0),
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

Widget contentContainerPink(Size size, Data? data){

  final vehiculos =  data?.drivers?.length.toString() ?? "0";

  return Column(
    children: [

      const SizedBox(height: 20),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 9.0),
            child: FittedBox(
              fit: BoxFit.contain,
              child: Align(
                       alignment: const Alignment(-0.4, 0.7),
                       child: Text( size.width < 856 ? "VEHICULOS" : "VEHICULOS ACTIVOS",
                       style: GoogleFonts.roboto(
                   color:Colors.white,
                   fontSize: size.width < 856 ? 18 : 24,
                   fontWeight: FontWeight.w500
                  ),
                       )),
            ),
          ),
         
         const  SizedBox(height: 10),
         Align(
                   alignment: const Alignment(-0.4,  -0.4  ),
                   child: Container(
                   color: Colors.white38,
                   width: 240,
                   height: 2,
                  ),
                ),

                const SizedBox(height: 30),

                Align(
                  alignment: const Alignment(-0.1,  0.4  ),
                  child: Text( vehiculos,
                  style: GoogleFonts.roboto(
                    color:Colors.white,
                    fontSize: size.width < 856 ? 22  : 48,
                    fontWeight: FontWeight.w500
                    ),
                   )
                 ),
    ],
  );
}

Widget contentContainerOrange(Size size, Data? data){

  final drivers = data?.drivers?.length.toString() ?? "0";

  return Column(    
           children: [
            
            const SizedBox(height: 20),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6.0),
              child: FittedBox(
                fit: BoxFit.contain,
                child: Align(
                 alignment: const Alignment(-0.4, -0.7),
                   child: Text( size.width < 856 ? "CONDUCTOR" : "CONDUCTORES ACTIVOS",
                   style: GoogleFonts.roboto(
                   color:Colors.white,
                   fontSize: size.width < 856 ? 18 : 24,
                   fontWeight: FontWeight.w500
                  ),
                 )
                ),
              ),
            ),
           
           const  SizedBox(height: 10),

                 Align(
                   alignment: const Alignment(-0.4,  -0.4  ),
                   child: Container(
                   color: Colors.white38,
                   width: 240,
                   height: 2,
                  ),
                ),

                const SizedBox(height: 30),

                Align(
                  alignment: const Alignment(-0.1,  0.4  ),
                  child: Text( drivers,
                  style: GoogleFonts.roboto(
                    color:Colors.white,
                    fontSize: size.width < 856? 22 : 48,
                    fontWeight: FontWeight.w500
                    ),
                   )
                 ),

    ],
  );
}


Widget contentContainerBlue(Size size, Data? data){
  
  final viajes = data?.viajes.toString() ?? "210";

  return  Column(        

          children: [
              const SizedBox(height: 20),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 9.0),
                child: FittedBox(
                  fit: BoxFit.contain,
                  child: Align(
                    alignment: const Alignment(-0.7,  -0.7  ),
                      child: Text(size.width < 856 ? "VIAJES" : "VIAJES REALIZADOS",
                       style: GoogleFonts.roboto(
                       color:Colors.white,
                       fontSize: size.width < 856? 18 : 24,
                       fontWeight: FontWeight.w500
                        ),
                       )
                      ),
                ),
              ),

                 const  SizedBox(height: 10),

                 Align(
                   alignment: const Alignment(-0.4,  -0.4  ),
                   child: Container(
                   color: Colors.white38,
                   width: 240,
                   height: 2,
                  ),
                ),

                const SizedBox(height: 30),

                Align(
                  alignment: const Alignment(-0.1,  0.4  ),
                  child: Text( viajes,
                  style: GoogleFonts.roboto(
                    color:Colors.white,
                    fontSize: size.width < 856? 22 : 48,
                    fontWeight: FontWeight.w500
                    ),
                   )
                 ),
    ],
  );
                  
                  
}