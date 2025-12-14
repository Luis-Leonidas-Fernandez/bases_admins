import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:transport_dashboard/blocs/language/language_bloc.dart';
import 'package:transport_dashboard/models/app_language.dart';

class LanguageSelector extends StatelessWidget {
  final bool showLabel;
  final EdgeInsets? padding;
  final bool isDropdown;

  const LanguageSelector({
    super.key,
    this.showLabel = true,
    this.padding,
    this.isDropdown = true,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LanguageBloc, LanguageState>(
      builder: (context, state) {
        if (isDropdown) {
          return _buildDropdown(context, state);
        } else {
          return _buildList(context, state);
        }
      },
    );
  }

  Widget _buildDropdown(BuildContext context, LanguageState state) {
    return Padding(
      padding: padding ?? EdgeInsets.zero,
      child: DropdownButton<AppLanguage>(
        value: state.language,
        underline: const SizedBox.shrink(),
        icon: const Icon(Icons.arrow_drop_down, color: Colors.white),
        selectedItemBuilder: (BuildContext context) {
          return AppLanguage.values.map((language) {
            return Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  _getFlagEmoji(language.flagCode),
                  style: const TextStyle(fontSize: 20),
                ),
                const SizedBox(width: 8),
                Text(
                  language.name,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.white,
                  ),
                ),
              ],
            );
          }).toList();
        },
        items: AppLanguage.values.map((language) {
          return DropdownMenuItem<AppLanguage>(
            value: language,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  _getFlagEmoji(language.flagCode),
                  style: const TextStyle(fontSize: 20),
                ),
                const SizedBox(width: 8),
                Text(
                  language.name,
                  style: const TextStyle(fontSize: 14),
                ),
              ],
            ),
          );
        }).toList(),
        onChanged: (AppLanguage? newLanguage) {
          if (newLanguage != null) {
            context.read<LanguageBloc>().add(
                  ChangeLanguageEvent(newLanguage),
                );
          }
        },
      ),
    );
  }

  Widget _buildList(BuildContext context, LanguageState state) {
    return Padding(
      padding: padding ?? const EdgeInsets.all(8.0),
      child: SizedBox(
        width: 190, // Ancho fijo para el selector
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (showLabel) ...[
              Text(
                _getLanguageLabel(context),
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
            ],
            ...AppLanguage.values.map((language) {
              final isSelected = state.language == language;
              return ListTile(
                contentPadding: EdgeInsets.zero, // Reducir padding
                dense: true, // Hacer más compacto
                leading: Text(
                  _getFlagEmoji(language.flagCode),
                  style: const TextStyle(fontSize: 24),
                ),
                title: Text(
                  language.name,
                  style: TextStyle(
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
                trailing: isSelected
                    ? const Icon(Icons.check, color: Colors.blue, size: 20)
                    : null,
                selected: isSelected,
                onTap: () {
                  context.read<LanguageBloc>().add(
                        ChangeLanguageEvent(language),
                      );
                },
              );
            }).toList(),
          ],
        ),
      ),
    );
  }

  String _getFlagEmoji(String flagCode) {
    // Convertir código de país a emoji de bandera
    // Para códigos de 2 letras, convertir cada letra a su emoji regional indicator
    try {
      final codePoints = flagCode
          .toUpperCase()
          .split('')
          .map((char) => 127397 + char.codeUnitAt(0))
          .toList();
      return String.fromCharCodes(codePoints);
    } catch (e) {
      // Fallback: retornar el código si hay error
      return flagCode;
    }
  }

  String _getLanguageLabel(BuildContext context) {
    // Intentar obtener el label desde localizaciones
    // Por ahora retornamos un texto genérico
    try {
      // Esto funcionará después de generar las localizaciones
      // return AppLocalizations.of(context)?.language ?? 'Language';
      return 'Language'; // Fallback por ahora
    } catch (e) {
      return 'Language';
    }
  }
}

