import 'package:flutter/material.dart';
import 'package:transport_dashboard/blocs/base/base_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BaseErrorDialog extends StatelessWidget {
  final VoidCallback? onClose; // Callback para notificar cuando se cierra
  
  const BaseErrorDialog({
    super.key,
    this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      title: Row(
        children: [
          Icon(
            Icons.error_outline,
            color: Colors.red[700],
            size: 28,
          ),
          const SizedBox(width: 12),
          const Text(
            'Error al crear base',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
        ],
      ),
      content: const Text(
        'En esta ubicacion no podes crear una base o zona por que ya ha sido ocupado por otro usuario.',
        style: TextStyle(
          fontSize: 16,
          color: Colors.black87,
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            // Limpiar el error del estado
            context.read<BaseBloc>().add(const ClearErrorEvent());
            // Cerrar el modal
            Navigator.of(context).pop();
            // Notificar que se cerró
            onClose?.call();
          },
          child: const Text(
            'Entendido',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}

