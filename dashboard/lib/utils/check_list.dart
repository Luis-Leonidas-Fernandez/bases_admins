import 'package:transport_dashboard/models/drivers.dart';

class CheckList {    


  List<Driver> checkLengList(List<Driver>list) {
  

  List<Driver> primerosTres = [];

   if (list.length <= 3) {    
    
    return list;
   
  } else {
     
     final data = list.sublist(0,3);
     primerosTres.addAll(data);    

     return primerosTres;
    
   
  }
}

}