import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_crud/providers/pet_provider.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../models/pet_model.dart';

class PetCard extends StatelessWidget {
  PetCard({required this.pet, super.key});

  final Pet pet;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        leading: Image.network(
          "${pet.image}",
          height: 100,
          width: 100,
        ),
        title: Text("${pet.name}"),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("${pet.age}"),
            Text("${pet.gender}"),
          ],
        ),
        trailing: Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () {
                  context.push("/edit", extra: pet);
                },
                child: Icon(
                  Icons.edit,
                  size: 20,
                ),
              ),
              InkWell(
                onTap: () {
                  context.read<PetProvider>().deletePet(pet.id);
                },
                child: Icon(
                  Icons.delete,
                  size: 20,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
