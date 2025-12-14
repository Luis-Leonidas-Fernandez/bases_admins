import 'package:transport_dashboard/constants/constants.dart';
import 'package:transport_dashboard/models/drivers.dart';
import 'package:transport_dashboard/utils/check_list.dart';
import 'package:transport_dashboard/widgets/icons_data_online.dart';
import 'package:transport_dashboard/l10n/app_localizations.dart';
import 'package:flutter/material.dart';



class TopDrivers extends StatelessWidget {

  final Data? data;
  const TopDrivers({super.key, this.data});

  @override
  Widget build(BuildContext context) {

    return  Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          
          children: [        
            
            const SizedBox(height: 35),
        
            Expanded(
              flex: 1,
              child: Container(
               width: 425,
               height: 298,
               decoration: decorationTopDrivers(),
               constraints: const BoxConstraints(maxWidth: 425, maxHeight: 298),               
              child: Stack(
                children: [
                   
                  

                   const Positioned(
                    top: 30,
                    left: 30,
                    child: TittleTopDrivers()),


                   Positioned(
                    top: 60,
                    left: 30,
                    child: DriverAvatar(data: data )),

                   
   
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
               width: 428,
               height: 510,               
              decoration: decorationDriversOnline(),
              child: DriversOnline(data: data),

                
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

class DriverAvatar extends StatelessWidget {


  final Data? data;
  const DriverAvatar({super.key, this.data});
  
  

  @override
  Widget build(BuildContext context) {

    final List<Driver> listDrivers = data?.drivers ?? [];

    final drivers = CheckList().checkLengList(listDrivers);       
    
    return Container(
      
      constraints: const BoxConstraints(maxWidth: 410, maxHeight: 200),
      child: Row(
        children: [   
          
          Container(
            height: 15,
            color: Colors.transparent
                      
          ),
          
          
          Align(
            alignment: const Alignment(-0.2, 0.5),
            child: Container(
              color: Colors.transparent,
              width: 300,
              height: 520,  
              child: ListView.builder(
                itemCount: drivers.length,
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index)   

                    => TopDriverContent (driver: drivers[index])                
                                 

                            
              ),
            ),
          ),
          
         
          ]
          )
    
         
      
    );
  }

  
}

class TittleTopDrivers extends StatelessWidget {
  const TittleTopDrivers({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      width: 200,
      height: 25,
      child: Text(
        AppLocalizations.of(context)?.topMonthlyDrivers ?? "Top Mensual Conductores",
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


class DriversOnline extends StatelessWidget {
  
  final Data? data;
  const DriversOnline({super.key, this.data});

  @override
  Widget build(BuildContext context) {


    final List<Driver> driver = data?.drivers ?? [];

    final size = MediaQuery.of(context).size;

    return Column(
      children: [
        
        const SizedBox(height: 20),
        Align(
          alignment: const Alignment(-0.1, 0.0),
          child: Container(
          color: Colors.transparent,
          height: 20,
          width: 200,
            child: Text(
              AppLocalizations.of(context)?.connectedDrivers ?? 'Conductores Conectados',
              style: size.width < 869 ? h5 : h5,
            ),
                    
            ),
        ),



        ListView.builder(
          
          scrollDirection: Axis.vertical,
          itemCount: driver.length,
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index)
          
          => IconsDriversOnline(driver: driver[index]) 
            ),
      ],
    );
  }

  
}

class TopDriverContent extends StatelessWidget {

  final Driver? driver;
  const TopDriverContent({super.key, this.driver});  

  @override
  Widget build(BuildContext context) {

    final nombre = driver?.nombre ?? "";
    final apellido = driver?.apellido ?? "";

    final nombreDri = '$nombre $apellido';

    return Column(
      children: [
        Row(
          children: [
           
           Container(
            width: 50,
            height: 50,
            decoration: decorationDriverAvatar(),
            child: const Icon(
            Icons.person,
            size: 38,            
            ),
           ), 
              
           const SizedBox(width: 20),


           Column(
             children: [
               Text(nombreDri, style: h6),

               const SizedBox(height: 5),

               const Row(
                 children: [

                   Icon(
                    Icons.star,
                    color: Color.fromARGB(255, 248, 224, 8),
                    shadows: <Shadow>[Shadow(color: Color.fromARGB(255, 94, 93, 93), blurRadius: 4.0)],
                    size: 19.0,
                    ),
                    Icon(
                    Icons.star,
                    color: Color.fromARGB(255, 248, 224, 8),
                    shadows: <Shadow>[Shadow(color: Color.fromARGB(255, 94, 93, 93), blurRadius: 4.0)],
                    size: 19.0,
                    ),
                    Icon(
                    Icons.star,
                    color: Color.fromARGB(255, 248, 224, 8),
                    shadows: <Shadow>[Shadow(color: Color.fromARGB(255, 94, 93, 93), blurRadius: 4.0)],
                    size: 19.0,
                    ),
                    Icon(
                    Icons.star,
                    color: Color.fromARGB(255, 248, 224, 8),
                    shadows: <Shadow>[Shadow(color: Color.fromARGB(255, 94, 93, 93), blurRadius: 4.0)],
                    size: 19.0,
                    ),
                    Icon(
                    Icons.star,
                    color: Color.fromARGB(255, 248, 224, 8),
                    shadows: <Shadow>[Shadow(color: Color.fromARGB(255, 94, 93, 93), blurRadius: 4.0)],
                    size: 19.0,
                    ),

                 ],
               ),
             ],
           ),
                     
          ] ),
          

          const SizedBox(height: 20),
      ],
    );


      
    
    
  }
  
  decorationTopDriverAvatar() => BoxDecoration(

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