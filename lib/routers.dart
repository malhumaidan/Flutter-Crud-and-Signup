import 'package:flutter_crud/models/pet_model.dart';
import 'package:flutter_crud/pages/add_page.dart';
import 'package:flutter_crud/pages/edit_page.dart';
import 'package:flutter_crud/pages/home_page.dart';
import 'package:go_router/go_router.dart';

final router = GoRouter(routes: [
  GoRoute(
    path: "/",
    builder: (context, state) => HomePage(),
  ),
  GoRoute(
    path: "/add",
    builder: (context, state) => AddPetPage(),
  ),
  GoRoute(
    path: "/edit",
    builder: (context, state) => EditPetPage(
      pet: state.extra as Pet,
    ),
  )
]);
