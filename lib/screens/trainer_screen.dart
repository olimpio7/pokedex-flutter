import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../main.dart';
import '../database/app_database.dart';

class TrainerScreen extends StatefulWidget {
  const TrainerScreen({super.key});

  @override
  State<TrainerScreen> createState() => _TrainerScreenState();
}

class _TrainerScreenState extends State<TrainerScreen> {
  Trainer? _trainer;
  bool _isLoading = true;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _loadTrainer();
  }

  Future<void> _loadTrainer() async {
    final trainers = await trainerRepository.getTrainers();
    setState(() {
      _trainer = trainers.isNotEmpty ? trainers.first : null;
      _isLoading = false;
    });
  }

  Future<void> _deleteTrainer() async {
    if (_trainer != null) {
      await trainerRepository.deleteTrainer(_trainer!.trainerId);
      _loadTrainer();
    }
  }

  void _editTrainer() {
    final nameController = TextEditingController(text: _trainer?.name ?? '');
    final cityController = TextEditingController(text: _trainer?.city ?? '');
    String currentAvatar = _trainer?.avatar ?? '';

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setStateDialog) {
            return AlertDialog(
              title: Text(_trainer == null ? 'Criar Perfil' : 'Editar Perfil'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  GestureDetector(
                    onTap: () async {
                      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
                      if (image != null) {
                        setStateDialog(() {
                          currentAvatar = image.path;
                        });
                      }
                    },
                    child: Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        shape: BoxShape.circle,
                        image: currentAvatar.isNotEmpty
                            ? DecorationImage(
                                image: currentAvatar.startsWith('http')
                                    ? NetworkImage(currentAvatar)
                                    : FileImage(File(currentAvatar)) as ImageProvider,
                                fit: BoxFit.cover,
                              )
                            : null,
                      ),
                      child: currentAvatar.isEmpty
                          ? const Icon(Icons.add_a_photo, size: 40, color: Colors.grey)
                          : null,
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text('Toque na foto para alterar', style: TextStyle(fontSize: 12, color: Colors.grey)),
                  const SizedBox(height: 8),
                  TextField(
                    controller: nameController,
                    decoration: const InputDecoration(labelText: 'Seu Nome'),
                  ),
                  TextField(
                    controller: cityController,
                    decoration: const InputDecoration(labelText: 'Sua Cidade (ex: Pallet Town)'),
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancelar'),
                ),
                ElevatedButton(
                  onPressed: () async {
                    final nav = Navigator.of(context);
                    if (_trainer == null) {
                      await trainerRepository.createTrainer(
                        name: nameController.text,
                        city: cityController.text,
                        avatar: currentAvatar,
                      );
                    } else {
                      await trainerRepository.updateTrainer(
                        trainerId: _trainer!.trainerId,
                        name: nameController.text,
                        city: cityController.text,
                        avatar: currentAvatar,
                      );
                    }
                    nav.pop();
                    _loadTrainer();
                  },
                  child: const Text('Salvar'),
                ),
              ],
            );
          }
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE53935),
      appBar: AppBar(
        title: const Text('Perfil do Treinador', style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFFE53935),
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
        ),
        child: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : _trainer == null
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.person_off, size: 80, color: Colors.grey),
                        const SizedBox(height: 10),
                        const Text(
                          'Nenhum treinador registrado.',
                          style: TextStyle(color: Colors.grey, fontSize: 16),
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton.icon(
                          onPressed: _editTrainer,
                          icon: const Icon(Icons.add),
                          label: const Text('Criar Meu Perfil'),
                        )
                      ],
                    ),
                  )
                : Center(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(20),
                      child: Card(
                        elevation: 5,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                width: 130,
                                height: 130,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.grey.shade200,
                                  border: Border.all(color: Colors.red, width: 3),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withValues(alpha: .1),
                                      blurRadius: 10,
                                      offset: const Offset(0, 5),
                                    )
                                  ],
                                  image: _trainer!.avatar.isNotEmpty
                                      ? DecorationImage(
                                          image: _trainer!.avatar.startsWith('http')
                                              ? NetworkImage(_trainer!.avatar)
                                              : FileImage(File(_trainer!.avatar)) as ImageProvider,
                                          fit: BoxFit.cover,
                                        )
                                      : null,
                                ),
                                child: _trainer!.avatar.isEmpty
                                    ? const Icon(Icons.person, size: 80, color: Colors.grey)
                                    : null,
                              ),
                              const SizedBox(height: 20),
                              Text(
                                _trainer!.name,
                                style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 8),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(Icons.location_on, color: Colors.red, size: 18),
                                  const SizedBox(width: 4),
                                  Text(
                                    _trainer!.city,
                                    style: TextStyle(fontSize: 18, color: Colors.grey.shade700),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 40),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ElevatedButton.icon(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.blue.shade600,
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                    ),
                                    onPressed: _editTrainer,
                                    icon: const Icon(Icons.edit, color: Colors.white),
                                    label: const Text('Editar', style: TextStyle(color: Colors.white)),
                                  ),
                                  const SizedBox(width: 10),
                                  ElevatedButton.icon(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.red.shade600,
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                    ),
                                    onPressed: _deleteTrainer,
                                    icon: const Icon(Icons.delete, color: Colors.white),
                                    label: const Text('Excluir', style: TextStyle(color: Colors.white)),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
      ),
    );
  }
}
