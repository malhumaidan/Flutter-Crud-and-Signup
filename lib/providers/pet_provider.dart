import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../client.dart';
import '../models/pet_model.dart';

class PetProvider extends ChangeNotifier {
  List<Pet> petlist = [];
  var isLoading = false;

  // PetProvider() {
  //   getPets();
  // }

  void getPets() async {
    isLoading = true;
    notifyListeners();

    var response = await Client.dioCrud.get("/pets");

    var petJasonList = response.data as List;

    petlist = petJasonList.map((e) => Pet.fromMap(e)).toList();

    isLoading = false;
    notifyListeners();
  }

  Future<void> addPets({
    required String name,
    required File image,
    required int age,
    required String gender,
  }) async {
    var response = await Client.dioCrud.post("/pets",
        data: FormData.fromMap({
          "name": name,
          "image": await MultipartFile.fromFile(image.path),
          "age": age,
          "gender": gender,
        }));

    getPets();
  }

  Future<void> editPets({
    required int id,
    required String name,
    required File image,
    required int age,
    required String gender,
  }) async {
    var response = await Client.dioCrud.put("/pets/${id}",
        data: FormData.fromMap({
          "name": name,
          "image": await MultipartFile.fromFile(image.path),
          "age": age,
          "gender": gender,
        }));

    getPets();
  }

  void deletePet(int id) async {
    await Client.dioCrud.delete('/pets/$id');

    getPets();
  }
}
