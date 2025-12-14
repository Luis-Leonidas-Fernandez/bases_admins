import 'package:transport_dashboard/blocs/blocs.dart';
import 'package:transport_dashboard/models/drivers.dart' hide DriversState;
import 'package:transport_dashboard/widgets/data_container.dart';
import 'package:transport_dashboard/widgets/my_card.dart';
import 'package:transport_dashboard/widgets/top_drivers.dart';
import 'package:transport_dashboard/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late DriversModel driversModel;
  DriversBloc? driversBloc;
  AuthBloc? authBloc;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<AuthBloc>(context);
    final driverBloc = BlocProvider.of<DriversBloc>(context);
    driverBloc.loadingDataBase();
  }

  @override
  void dispose() {
    super.dispose();
    driversBloc?.stopPeriodicTasck();
  }

  @override
  Widget build(BuildContext context) {
    
    final size = MediaQuery.of(context).size;

    return BlocBuilder<DriversBloc, DriversState>(
           builder: (context, state) {
           final model = state.driversModelOnline;
           final data = model?.data;

          // Si no hay modelo cargado, mostrar loading
          if (model == null) {
           return const Center(
            child: CircularProgressIndicator(),
           );
         }

         // Siempre mostrar el home page, incluso si no hay datos
         // Los widgets manejarán mostrar datos vacíos o null
         if (size.width < 856) {
          return mobileBody(size, data);
        } else {
          return desktopAndWeb(size, data);
        }
       },
      );

  }

  Widget desktopAndWeb(Size size, Data? data) {
    return Row(
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
                        alignment: const Alignment(
                          -1.0,
                          0.0,
                        ),
                        child: Text(
                          AppLocalizations.of(context)?.welcome ?? "Bienvenido al Dashboard",
                          style: GoogleFonts.merienda(
                              color: Colors.black,
                              fontSize: 35,
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
                const SizedBox(height: 50),
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                    child: MyCard(data: data)),
                const SizedBox(height: 50),
                Expanded(
                    flex: size.width > 1100 ? 1 : 2,
                    child: ListView(
                      children: [DataContainer(data: data)],
                    )),
              ],
            ),
          ),
        ),
        Expanded(flex: 1, child: TopDrivers(data: data)),
      ],
    );
  }

  Widget mobileBody(Size size, Data? data) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: [
          const SizedBox(height: 55),
          Container(
              color: Colors.transparent,
              width: size.width,
              height: 100,
              child: tittle(size, context)),
          Container(
              color: Colors.transparent,
              width: size.width,
              child: MyCard(data: data)),
          Container(
              color: Colors.transparent,
              width: size.width,
              height: 1100,
              child: TopDrivers(data: data)),
          const SizedBox(height: 30),
          Container(
              color: Colors.transparent,
              width: size.width,
              height: 600,
              child: DataContainer(data: data)),
        ],
      ),
    );
  }
}

Widget tittle(Size size, BuildContext context) {
  return Row(
    children: [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5.0),
        child: Text(
          AppLocalizations.of(context)?.welcome ?? "Bienvenido al Dashboard",
          style: GoogleFonts.merienda(
              color: Colors.black,
              fontSize: size.width < 400 ? 20 : 23,
              fontWeight: FontWeight.w900),
        ),
      ),
      const SizedBox(width: 5),
      const Icon(
        Icons.waving_hand_rounded,
        color: Color.fromARGB(255, 240, 217, 15),
      ),
    ],
  );
}
