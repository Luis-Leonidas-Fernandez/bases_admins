import 'package:transport_dashboard/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomDialog extends StatefulWidget {
  const CustomDialog({super.key});

  @override
  State<CustomDialog> createState() => _CustomDialogState();
}

class _CustomDialogState extends State<CustomDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
                backgroundColor: myDashboardColor,
                title: const Text('Registro Exitoso ir a Home'),
                
                actions: [

                  ElevatedButton(
                    
                    onPressed: () => GoRouter.of(context).push('/dashboard')
                    , 
                    child: const Icon(
                      Icons.arrow_circle_right_sharp,
                      size: 50,
                      ) 
                    )
                  
                ],
                );
  }
}