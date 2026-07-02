import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/trainer/trainer_bloc.dart';
import '../blocs/trainer/trainer_event.dart';
import '../blocs/trainer/trainer_state.dart';
import '../database/app_database.dart';

class TrainerScreen extends StatefulWidget {
  const TrainerScreen({super.key});

  @override
  State<TrainerScreen> createState() => _TrainerScreenState();
}

class _TrainerScreenState extends State<TrainerScreen> {
  final ImagePicker _picker = ImagePicker();

  void _deleteTrainer() {
    context.read<TrainerBloc>().add(DeleteTrainerEvent());
  }

  void _editTrainer(Trainer? trainer) {
    final nameController = TextEditingController(text: trainer?.name ?? '');
    final cityController = TextEditingController(text: trainer?.city ?? '');
    String currentAvatar = trainer?.avatar ?? '';

    showDialog(
      context: context,
      builder: (dialogContext) {
        return StatefulBuilder(
          builder: (context, setStateDialog) {
            return AlertDialog(
              title: Text(trainer == null ? 'Criar Perfil' : 'Editar Perfil'),
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
                  onPressed: () => Navigator.pop(dialogContext),
                  child: const Text('Cancelar'),
                ),
                ElevatedButton(
                  onPressed: () {
                    context.read<TrainerBloc>().add(
                      SaveTrainerEvent(
                        name: nameController.text,
                        city: cityController.text,
                        avatar: currentAvatar,
                      )
                    );
                    Navigator.pop(dialogContext);
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
        child: BlocBuilder<TrainerBloc, TrainerState>(
          builder: (context, state) {
            if (state is TrainerLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is TrainerError) {
              return Center(child: Text(state.message));
            } else if (state is TrainerLoaded) {
              final trainer = state.trainer;
              
              if (trainer == null) {
                return Center(
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
                        onPressed: () => _editTrainer(null),
                        icon: const Icon(Icons.add),
                        label: const Text('Criar Meu Perfil'),
                      )
                    ],
                  ),
                );
              }

              return Center(
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
                              image: trainer.avatar.isNotEmpty
                                  ? DecorationImage(
                                      image: trainer.avatar.startsWith('http')
                                          ? NetworkImage(trainer.avatar)
                                          : FileImage(File(trainer.avatar)) as ImageProvider,
                                      fit: BoxFit.cover,
                                    )
                                  : null,
                            ),
                            child: trainer.avatar.isEmpty
                                ? const Icon(Icons.person, size: 80, color: Colors.grey)
                                : null,
                          ),
                          const SizedBox(height: 20),
                          Text(
                            trainer.name,
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
                                trainer.city,
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
                                onPressed: () => _editTrainer(trainer),
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
              );
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}
