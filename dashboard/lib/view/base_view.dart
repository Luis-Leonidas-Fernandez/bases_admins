import 'package:dashborad/blocs/base/base_bloc.dart';
import 'package:dashborad/blocs/user/auth_bloc.dart';
import 'package:dashborad/models/bases.dart';
import 'package:dashborad/responsive/responsive_ui.dart';
import 'package:dashborad/service/storage_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class BasePage extends StatefulWidget {


  const BasePage({super.key});

  @override
  State<BasePage> createState() => _BasePageState(); 

}

class _BasePageState extends State<BasePage> {



  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    return Scaffold(
      
      body: Center(
        child: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) { 
           
             return MapZonas(size: size); 
           
          }
          )
      ),
    );
  }
}

class MapZonas extends StatefulWidget {
 
  final Size size;
  const MapZonas({super.key, required this.size});

  @override
  State<MapZonas> createState() => _MapZonasState();
}

class _MapZonasState extends State<MapZonas> {
  
   @override
  void initState() {
    super.initState();

   BlocProvider.of<BaseBloc>(context);
    
  }

  @override
  void dispose() {    
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(


        children: [

          SelectArea(size: widget.size),

          const ButtonGoHome()

          


        ] 
      ),
    );
  }
}

class TittleAddZona extends StatelessWidget {
  
  final Size size;
  const TittleAddZona({super.key, required this.size});

  @override
  Widget build(BuildContext context) {

    return Column(
      children: [

        const SizedBox(height: 50),
        Center(
          child: Container(
              color: Colors.transparent,
              width: size.width * 0.9,
              height: size.height * 0.1,
              child: Text(
                'Crea tu Base en la Zona que quieras',
                style:  GoogleFonts.satisfy(
                  fontSize: size.width > 1100 ? 43 : 25,
                  fontWeight: FontWeight.w600,
                  color: const Color.fromARGB(255, 2, 31, 192),
                  letterSpacing: .7
                   ),
              ),
          ),
        ),
      ],
    );
  }
}

class SelectArea extends StatelessWidget {

  final Size size;
  const SelectArea({super.key, required this.size});

  @override
  Widget build(BuildContext context) {

    late ResponsiveUtil responsiveUtil = ResponsiveUtil(context);
    double responsiveTop = responsiveUtil.getResponsiveHeight(0.28);
    double responsiveLeft = responsiveUtil.getResponsiveWidth(0.18); // Adjust the value to fit your design
    double responsiveRight = responsiveUtil.getResponsiveWidth(0.18);
    
    return  ListView(
      children: [
        
        const SizedBox(height: 15),

        TittleAddZona(size: size),
        
        Stack(
          children: [

          Container(
          color: Colors.transparent,
          width: size.width * 0.85,
          height: size.width > 1100 ? size.height * 1.15 : size.height * 0.55,
          child: Image.asset('assets/map.webp',
          fit: BoxFit.fill,
          ),        
         ),

          Positioned(
            top: responsiveTop,
            left: responsiveLeft,
            child: const DroopButton()),

           Positioned(
            top: responsiveTop,
            right: responsiveRight,
            child: const DroopButtonB()), 

           Positioned(
            top: responsiveUtil.getResponsiveHeight(0.82),
            left: responsiveLeft,
            child: const DroopButtonC()), 

           Positioned(
            top:responsiveUtil.getResponsiveHeight(0.82),
            right: responsiveRight,
            child: const DroopButtonD()), 
          ]
        ),
      
      Container(width: size.width, height: 15, color: Colors.transparent,),
    
      Stack(
        children: [
             Container(
          color: Colors.transparent,
          width: size.width * 0.85,
          height:  size.width > 1100 ? size.height * 1.15 : size.height * 0.55,
          child: Image.asset('assets/fontana.webp',
          fit: BoxFit.fill,
          )
         ),

         Positioned(
            top: responsiveUtil.getResponsiveHeight(0.70),
            left: size.width * 0.40,         
            child: const DroopButtonE() ),
        ] 
      ),

       Container(width: size.width, height: 15, color: Colors.transparent,),

       Stack(
        children: [
             Container(
          color: Colors.transparent,
          width: size.width * 0.85,
          height:  size.width > 1100 ? size.height * 1.15 : size.height * 0.55,
          child: Image.asset('assets/barranqueras.webp',
          fit: BoxFit.fill,
          )
         ),

         Positioned(
            top: responsiveUtil.getResponsiveHeight(0.70),
            left:size.width * 0.38,
            child: const DroopButtonF() ),
        ] 
      ),


       

        Container(width: size.width, height: 50, color: Colors.transparent,),   
      ] 
    );
  }
}

class ButtonGoHome extends StatelessWidget {

 

  const ButtonGoHome({super.key, });
  


  @override
  Widget build(BuildContext context) {
    
    final basebloc = BlocProvider.of<BaseBloc>(context);   
   

    return Positioned(
       bottom: 25,
       right: 25,
       left: 25,
      child: BlocBuilder<BaseBloc, BaseState>(
        builder: (context, state) {
          return ElevatedButton(
            onPressed: () async{
          
              final uid = StorageService.prefs.getString('uid');
              final base = basebloc.state.baseModel?? {} as BaseModel; 
              
             
              // POST CREAR BASE
              final registerOk = await basebloc.createBase(base,uid!);                    
  
              
              
              //RESPUESTA
              if(registerOk == true && context.mounted){          
                           
              GoRouter.of(context).push('/dialog');
             
              }else if(registerOk == false && context.mounted){
            
               
                GoRouter.of(context).push('/error');

               } 
              

            },

            style: ButtonStyle(
            overlayColor: WidgetStateProperty.all(
            const Color.fromARGB(255, 122, 140, 241)
             ),
             backgroundColor: WidgetStateProperty.all(
              const Color.fromARGB(255, 11, 38, 192))
            ),
            child: const Text(
              'SIGUIENTE',
               style: TextStyle(
               color: Colors.white,
               fontSize: 18 
                ),)
            );
        }
      ),
    );
  }
}

class DroopButton extends StatefulWidget {

  const DroopButton({super.key});

  @override
  State<DroopButton> createState() => _DroopButtonState();
}

class _DroopButtonState extends State<DroopButton> {

  String dropdownValue = '1';
  String a = 'A';
  List<double>? ubicacion = [-58.65748235, -27.3254869];

  BaseModel? baseModel;
  BaseBloc? baseBloc;

  @override
  void initState() {
    super.initState();

   BlocProvider.of<BaseBloc>(context);
    
  }

  @override
  void dispose() {    
    super.dispose();
  }





  @override
  Widget build(BuildContext context) {

    final baseBloc = BlocProvider.of<BaseBloc>(context);   

    return BlocBuilder<BaseBloc, BaseState>(
      builder: (context, state) {
        return Container(
               width: 65,
               height: 45,
               decoration: BoxDecoration(
               color: const Color.fromARGB(255, 159, 173, 252),
               borderRadius: BorderRadius.circular(10)
             ),
              child: Center(
                    child: DropdownButton<String>(
                    value: dropdownValue,             
                    style: const TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
                    icon: const Icon(Icons.arrow_drop_down, color: Colors.black,),
                    onChanged: (String? newValue) async {                
            
                    dropdownValue = newValue!;                
                              
           
                    final value = {"zonaName": a, "base": dropdownValue, "ubicacion": ubicacion}; 


                    final data = BaseModel.fromJson(value);
                    //final result = data.toMap();
                    
         
           
                    baseBloc.add(AddBaseEvent(data));
                    Future.delayed(const Duration(seconds: 10)); 
                    
                    

           
         
         
          },
          items: const [
           DropdownMenuItem(
             value: '1',
             child: Text('1') 
             ),
             DropdownMenuItem(
             value: '2',
             child: Text('2') 
             ),
             DropdownMenuItem(
             value: '3',
             child: Text('3') 
             ),
             DropdownMenuItem(
             value: '4',
             child: Text('4') 
             )
          ],
             ),
           ),
         );
      }
    );
    
    
    
  }
}

class DroopButtonB extends StatefulWidget {

  const DroopButtonB({super.key});

  @override
  State<DroopButtonB> createState() => _DroopButtonBState();
}

class _DroopButtonBState extends State<DroopButtonB> {

  String dropdownValue = '1';
  String b = 'B';
  List<double>? ubicacion = [-58.65748235,-27.3254869];

  BaseModel? baseModel;
  BaseBloc? baseBloc;

  @override
  void initState() {
    super.initState();

   BlocProvider.of<BaseBloc>(context);
    
  }

  @override
  void dispose() {    
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final baseBloc = BlocProvider.of<BaseBloc>(context);

    return BlocBuilder<BaseBloc, BaseState>(
      builder: (context, state) {
        return Container(
               width: 65,
               height: 45,
               decoration: BoxDecoration(
               color: const Color.fromARGB(255, 159, 173, 252),
               borderRadius: BorderRadius.circular(10)
             ),
              child: Center(
                    child: DropdownButton<String>(
                    value: dropdownValue,             
                    style: const TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
                    icon: const Icon(Icons.arrow_drop_down, color: Colors.black,),
                    onChanged: (String? newValue) async {                
            
                    dropdownValue = newValue!;                
                              
           
                    final value = {"zonaName": b, "base": dropdownValue , "ubicacion": ubicacion}; 
                    final data = BaseModel.fromJson(value);
         
        
           
                    baseBloc.add(AddBaseEvent(data));
                    Future.delayed(const Duration(seconds: 10));                  
           
         
         
          },
          items: const [
           DropdownMenuItem(
             value: '1',
             child: Text('1') 
             ),
             DropdownMenuItem(
             value: '2',
             child: Text('2') 
             ),
             DropdownMenuItem(
             value: '3',
             child: Text('3') 
             ),
             DropdownMenuItem(
             value: '4',
             child: Text('4') 
             )
          ],
             ),
           ),
         );
      }
    );
    
    
    
  }
}

class DroopButtonC extends StatefulWidget {

  const DroopButtonC({super.key});

  @override
  State<DroopButtonC> createState() => _DroopButtonCState();
}

class _DroopButtonCState extends State<DroopButtonC> {



  String dropdownValue = '1';
  String c = 'C';
  List<double>? ubicacion = [-58.65748235,-27.3254869];

  BaseModel? baseModel;
  BaseBloc? baseBloc;

  @override
  void initState() {
    super.initState();

   BlocProvider.of<BaseBloc>(context);
    
  }

  @override
  void dispose() {    
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final baseBloc = BlocProvider.of<BaseBloc>(context);

    return BlocBuilder<BaseBloc, BaseState>(
      builder: (context, state) {
        return Container(
               width: 65,
               height: 45,
               decoration: BoxDecoration(
               color: const Color.fromARGB(255, 159, 173, 252),
               borderRadius: BorderRadius.circular(10)
             ),
              child: Center(
                    child: DropdownButton<String>(
                    value: dropdownValue,             
                    style: const TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
                    icon: const Icon(Icons.arrow_drop_down, color: Colors.black,),
                    onChanged: (String? newValue) async {                
            
                    dropdownValue = newValue!;                
                              
           
                    final value = {"zonaName": c, "base": dropdownValue, "ubicacion": ubicacion}; 
                    final data = BaseModel.fromJson(value);
         
        
           
                    baseBloc.add(AddBaseEvent(data));
                    Future.delayed(const Duration(seconds: 10));                  
           
         
         
          },
          items: const [
           DropdownMenuItem(
             value: '1',
             child: Text('1') 
             ),
             DropdownMenuItem(
             value: '2',
             child: Text('2') 
             ),
             DropdownMenuItem(
             value: '3',
             child: Text('3') 
             ),
             DropdownMenuItem(
             value: '4',
             child: Text('4') 
             )
          ],
             ),
           ),
         );
      }
    );
    
    
    
  }
}

class DroopButtonD extends StatefulWidget {

  const DroopButtonD({super.key});

  @override
  State<DroopButtonD> createState() => _DroopButtonDState();
}

class _DroopButtonDState extends State<DroopButtonD> {

  String dropdownValue = '1';
  String d = 'D';
  List<double>? ubicacion = [-58.65748235,-27.3254869];

  BaseModel? baseModel;
  BaseBloc? baseBloc;

  @override
  void initState() {
    super.initState();

   BlocProvider.of<BaseBloc>(context);
    
  }

  @override
  void dispose() {    
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final baseBloc = BlocProvider.of<BaseBloc>(context);

    return BlocBuilder<BaseBloc, BaseState>(
      builder: (context, state) {
        return Container(
               width: 65,
               height: 45,
               decoration: BoxDecoration(
               color: const Color.fromARGB(255, 159, 173, 252),
               borderRadius: BorderRadius.circular(10)
             ),
              child: Center(
                    child: DropdownButton<String>(
                    value: dropdownValue,             
                    style: const TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
                    icon: const Icon(Icons.arrow_drop_down, color: Colors.black,),
                    onChanged: (String? newValue) async {                
            
                    dropdownValue = newValue!;                
                              
           
                    final value = {"zonaName": d, "base": dropdownValue, "ubicacion": ubicacion}; 
                    final data = BaseModel.fromJson(value);
         
        
           
                    baseBloc.add(AddBaseEvent(data));
                    Future.delayed(const Duration(seconds: 10));                  
           
         
         
          },
          items: const [
           DropdownMenuItem(
             value: '1',
             child: Text('1') 
             ),
             DropdownMenuItem(
             value: '2',
             child: Text('2') 
             ),
             DropdownMenuItem(
             value: '3',
             child: Text('3') 
             ),
             DropdownMenuItem(
             value: '4',
             child: Text('4') 
             )
          ],
             ),
           ),
         );
      }
    );
    
    
    
  }
}

class DroopButtonE extends StatefulWidget {

  const DroopButtonE({super.key});

  @override
  State<DroopButtonE> createState() => _DroopButtonEState();
}

class _DroopButtonEState extends State<DroopButtonE> {

  String dropdownValue = '1';
  String e = 'E';
  List<double>? ubicacion = [-58.65748235,-27.3254869];

  BaseModel? baseModel;
  BaseBloc? baseBloc;

  @override
  void initState() {
    super.initState();

   BlocProvider.of<BaseBloc>(context);
    
  }

  @override
  void dispose() {    
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final baseBloc = BlocProvider.of<BaseBloc>(context);

    return BlocBuilder<BaseBloc, BaseState>(
      builder: (context, state) {
        return Container(
               width: 65,
               height: 45,
               decoration: BoxDecoration(
               color: const Color.fromARGB(255, 159, 173, 252),
               borderRadius: BorderRadius.circular(10)
             ),
              child: Center(
                    child: DropdownButton<String>(
                    value: dropdownValue,             
                    style: const TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
                    icon: const Icon(Icons.arrow_drop_down, color: Colors.black,),
                    onChanged: (String? newValue) async {                
            
                    dropdownValue = newValue!;                
                              
           
                    final value = {"zonaName": e, "base": dropdownValue, "ubicacion": ubicacion}; 
                    final data = BaseModel.fromJson(value);
         
        
           
                    baseBloc.add(AddBaseEvent(data));
                    Future.delayed(const Duration(seconds: 10));                  
           
         
         
          },
          items: const [
           DropdownMenuItem(
             value: '1',
             child: Text('1') 
             ),
             DropdownMenuItem(
             value: '2',
             child: Text('2') 
             ),
             DropdownMenuItem(
             value: '3',
             child: Text('3') 
             ),
             DropdownMenuItem(
             value: '4',
             child: Text('4') 
             )
          ],
             ),
           ),
         );
      }
    );
    
    
    
  }
}


class DroopButtonF extends StatefulWidget {

  const DroopButtonF({super.key});

  @override
  State<DroopButtonF> createState() => _DroopButtonFState();
}

class _DroopButtonFState extends State<DroopButtonF> {

  String dropdownValue = '1';
  String f = 'F';
  List<double>? ubicacion = [-58.65748235,-27.3254869];

  BaseModel? baseModel;
  BaseBloc? baseBloc;

  @override
  void initState() {
    super.initState();

   BlocProvider.of<BaseBloc>(context);
    
  }

  @override
  void dispose() {    
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final baseBloc = BlocProvider.of<BaseBloc>(context);

    return BlocBuilder<BaseBloc, BaseState>(
      builder: (context, state) {
        return Container(
               width: 65,
               height: 45,
               decoration: BoxDecoration(
               color: const Color.fromARGB(255, 159, 173, 252),
               borderRadius: BorderRadius.circular(10)
             ),
              child: Center(
                    child: DropdownButton<String>(
                    value: dropdownValue,             
                    style: const TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
                    icon: const Icon(Icons.arrow_drop_down, color: Colors.black,),
                    onChanged: (String? newValue) async {                
            
                    dropdownValue = newValue!;                
                              
           
                    final value = {"zonaName": f, "base": dropdownValue, "ubicacion": ubicacion}; 
                    final data = BaseModel.fromJson(value);
         
         
           
                    baseBloc.add(AddBaseEvent(data));
                    Future.delayed(const Duration(seconds: 10));                  
           
         
         
          },
          items: const [
           DropdownMenuItem(
             value: '1',
             child: Text('1') 
             ),
             DropdownMenuItem(
             value: '2',
             child: Text('2') 
             ),
             DropdownMenuItem(
             value: '3',
             child: Text('3') 
             ),
             DropdownMenuItem(
             value: '4',
             child: Text('4') 
             )
          ],
             ),
           ),
         );
      }
    );
    
    
    
  }
}