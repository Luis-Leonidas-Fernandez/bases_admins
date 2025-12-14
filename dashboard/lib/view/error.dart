import 'package:transport_dashboard/constants/constants.dart';
import 'package:flutter/material.dart';

class ErrorView extends StatelessWidget {
  const ErrorView({super.key});

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size; 
    return Container(
      color: Colors.white,
      width: size.width,
      height: size.height,
      child: Center(
        child: Text(
          "404 - PAGINA NO ENCONTRADA",
          style: h4,
          ),
      ),
    );
  }
}