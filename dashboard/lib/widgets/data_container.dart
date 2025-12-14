import 'package:transport_dashboard/constants/constants.dart';
import 'package:transport_dashboard/models/drivers.dart';
import 'package:transport_dashboard/l10n/app_localizations.dart';
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
  // ❓ OPCIÓN A: mostrar solo conductores que TRAEN el campo (existe, sea true o false)
  final alldrivers = drivers.where((d) => d.online != null).toList();

  

  return  DataTable(columns: [
     
     DataColumn(label: Expanded(child: Text(AppLocalizations.of(context)?.lastName ?? 'APELLIDO', style: size.width < 858 ? h9 : h10))),
     DataColumn(label: Expanded(child: Text(AppLocalizations.of(context)?.firstName ?? 'NOMBRE', style: size.width < 858 ? h9 : h10))),     
     DataColumn(label: Expanded(child: Text(AppLocalizations.of(context)?.vehicle ?? 'VEHICULO', style: size.width < 858 ? h9 : h10))),
     DataColumn(label: Expanded(child: Text(AppLocalizations.of(context)?.tripsColumn ?? 'VIAJES', style: size.width < 858 ? h9 : h10))),
     DataColumn(label: Expanded(child: Text(AppLocalizations.of(context)?.actions ?? 'ACCIONES', style: size.width < 858 ? h9 : h10))),
     DataColumn(label: Expanded(child: Text(AppLocalizations.of(context)?.license ?? 'LICENCIA', style: size.width < 858 ? h9 : h10))),
     DataColumn(label: Expanded(child: Text(AppLocalizations.of(context)?.plate ?? 'PATENTE', style: size.width < 858 ? h9 : h10))),
     DataColumn(label: Expanded(child: Text(AppLocalizations.of(context)?.model ?? 'MODELO', style: size.width < 858 ? h9 : h10))),
     DataColumn(label: Expanded(child: Text(AppLocalizations.of(context)?.status ?? 'STATUS', style: size.width < 858 ? h9 : h10))),
    
      ], rows: alldrivers
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