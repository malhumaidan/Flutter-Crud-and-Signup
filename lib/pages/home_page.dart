import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_crud/providers/pet_provider.dart';
import 'package:flutter_crud/widgets/pet_card.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("HomePage")),
      body: Column(children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                  child: ElevatedButton(
                      onPressed: () {
                        context.read<PetProvider>().getPets();
                      },
                      child: Text("Get"))),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                  child: ElevatedButton(
                      onPressed: () {
                        context.push("/add");
                      },
                      child: Text("Add pet"))),
            ],
          ),
        ),
        Expanded(
          child: context.watch<PetProvider>().isLoading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : ListView.builder(
                  itemCount: context.watch<PetProvider>().petlist.length,
                  itemBuilder: (context, index) =>
                      PetCard(pet: context.watch<PetProvider>().petlist[index]),
                ),
        )
      ]),
    );
  }
}
