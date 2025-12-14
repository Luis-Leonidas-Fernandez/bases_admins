import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:transport_dashboard/l10n/app_localizations.dart';

class TittleRegister extends StatelessWidget {
  
  final Size size;
  const TittleRegister({super.key, required this.size});


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric( horizontal: 2 ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        

          FittedBox(
            fit: BoxFit.contain,
            child: Text(
              AppLocalizations.of(context)?.registerTitle ?? 'REGISTRARME',
              style: GoogleFonts.montserratAlternates(
                fontSize: 60,
                color: Colors.white,
                fontWeight: FontWeight.bold
              ),
            ),
          ),
         
           // Center(
           //   child: Image(
           //     image: const AssetImage('assets/logo.png'),
           //     width: size.width < 1100 ? 200 : 300,
           //   ),
           // ),
        ],
      ),
    );
  }
}