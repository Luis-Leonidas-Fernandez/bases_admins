import 'package:dashborad/constants/constants.dart';
import 'package:dashborad/models/drivers.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';


class DataContainer extends StatelessWidget {

  final Data? data;
  const DataContainer({super.key, this.data});

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;
    
    return Container(
              
           decoration: decorationDataContainer(),
           child: ConstrainedBox(
             constraints: const BoxConstraints(maxHeight: 603), 
             child: SingleChildScrollView(
               scrollDirection: Axis.horizontal,
               child: ConstrainedBox(
                constraints: BoxConstraints(minWidth: size.width),
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: _tableContent( context,size, data),
                ), 
                ) 

                
               
             ),
           ),
    );
  }

  BoxDecoration decorationDataContainer() => BoxDecoration(
   color: tableColor,
   borderRadius:  const BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))
  );
}

Widget _tableContent( BuildContext context,Size size, Data? data){
 
  
  final List<Driver> drivers = data?.drivers ?? [];

  

  return  DataTable(columns: [
     
     DataColumn(label: Expanded(child: Text('APELLIDO', style: size.width < 858 ? h9 : h10))),
     DataColumn(label: Expanded(child: Text('NOMBRE', style: size.width < 858 ? h9 : h10))),     
     DataColumn(label: Expanded(child: Text('VEHICULO', style: size.width < 858 ? h9 : h10))),
     DataColumn(label: Expanded(child: Text('VIAJES', style: size.width < 858 ? h9 : h10))),
     DataColumn(label: Expanded(child: Text('ACCIONES', style: size.width < 858 ? h9 : h10))),
     DataColumn(label: Expanded(child: Text('LICENCIA', style: size.width < 858 ? h9 : h10))),
     DataColumn(label: Expanded(child: Text('PATENTE', style: size.width < 858 ? h9 : h10))),
     DataColumn(label: Expanded(child: Text('MODELO', style: size.width < 858 ? h9 : h10))),
     DataColumn(label: Expanded(child: Text('STATUS', style: size.width < 858 ? h9 : h10))),
    
      ], rows: drivers
      .map(
        (driver) => DataRow(
          onSelectChanged: (_) {
            if (driver.id != null && driver.id!.isNotEmpty) {
              context.go('/dashboard/driver/${driver.id}');
            }
          },
          cells: [
  
           DataCell(Text(driver.apellido?? "", style: TextStyle(color: containerColor),)),
           DataCell(Text(driver.nombre ?? "", style: TextStyle(color: containerColor))),
           DataCell(Text(driver.vehiculo ?? "", style: TextStyle(color: containerColor))),
           DataCell(Text(driver.viajes.toString(), style: TextStyle(color: containerColor))),
           DataCell(Text('Activo', style: TextStyle(color: containerColor))),
           DataCell(Text(driver.licencia ?? "", style: TextStyle(color: containerColor))),
           DataCell(Text(driver.patente ?? "", style: TextStyle(color: containerColor))),
           DataCell(Text(driver.modelo?? "", style: TextStyle(color: containerColor))),
           DataCell(Text(driver.status ?? "", style: TextStyle(color: containerColor))),
  
        ],
     )
        
        ).toList(),
      
      
      );
}