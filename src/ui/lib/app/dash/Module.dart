import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:medicamina/app/dash/Page.dart';
import 'package:medicamina/app/dash/history/Page.dart';
import 'package:medicamina/app/dash/home/Page.dart';
import 'package:medicamina/app/dash/settings/Module.dart';
// import 'package:medicamina/app/dash/settings/Page.dart';
import 'package:medicamina/app/not_found/Page.dart';

class MedicaminaDashModule extends Module {
  @override
  List<Bind> get binds => [];

  @override
  List<ModularRoute> get routes {
    return [
      ChildRoute('/', child: (context, args) => const MedicaminaDashPage(), children: [
        ChildRoute('/home', child: (context, args) => const MedicaminaDashHome()),
        ChildRoute('/history', child: (context, args) => const MedicaminsaDashHistoryPage(), children: []),
        ChildRoute('/family', child: (context, args) => const Text('family'), children: []),

        ModuleRoute('/settings', module: MedicaminaDashSettingsModule()),

        WildcardRoute(child: (context, args) => const MedicaminaNotFoundPage()),
      ]),
    ];
  }
}
