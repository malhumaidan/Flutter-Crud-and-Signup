import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_crud/providers/pet_provider.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../models/pet_model.dart';

class EditPetPage extends StatefulWidget {
  final Pet pet;

  EditPetPage({required this.pet, super.key});

  @override
  State<EditPetPage> createState() => _AddPetPageState();
}

class _AddPetPageState extends State<EditPetPage> {
  final nameController = TextEditingController();

  final genderController = TextEditingController();

  final ageController = TextEditingController();

  // final imageController = TextEditingController();

  File? imageFile;

  String? imageError;

  var formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    nameController.text = widget.pet.name;
    genderController.text = widget.pet.gender;
    ageController.text = widget.pet.age.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Edit Pet")),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: nameController,
                  decoration: InputDecoration(
                    hintText: "name",
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 3, color: Colors.blue),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Field is required";
                    }

                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: genderController,
                  decoration: InputDecoration(
                    hintText: "gender",
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 3, color: Colors.blue),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Field is required";
                    }

                    if (value != "male" && value != "female") {
                      return "Please use a valid gender";
                    }

                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: ageController,
                  decoration: InputDecoration(
                    hintText: "age",
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 3, color: Colors.blue),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Field is required";
                    }

                    if (int.parse(value) == int) {
                      return "Please enter a number";
                    }

                    return null;
                  },
                ),
              ),
              if (imageFile != null)
                Image.file(
                  imageFile!,
                  height: 100,
                  width: 100,
                )
              else
                Image.network(
                  widget.pet.image,
                  height: 100,
                  width: 100,
                ),
              if (imageError != null) Text(imageError!),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                          onPressed: () async {
                            var file = await ImagePicker()
                                .pickImage(source: ImageSource.gallery);

                            if (file == null) {
                              return;
                            }

                            setState(() {
                              imageFile = File(file.path);
                              imageError = null;
                            });
                          },
                          child: Text("Upload image")),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                        child: ElevatedButton(
                            onPressed: () async {
                              if (imageFile == null) {
                                setState(() {
                                  imageError = "required field";
                                });
                              }

                              if (formKey.currentState!.validate() &&
                                  imageFile != null) {
                                await context.read<PetProvider>().editPets(
                                      id: widget.pet.id,
                                      name: nameController.text,
                                      image: imageFile!,
                                      age: int.parse(ageController.text),
                                      gender: genderController.text,
                                    );

                                context.pop();
                              }
                            },
                            child: Text("Save changes"))),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
