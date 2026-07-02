import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/teams/teams_bloc.dart';
import '../blocs/teams/teams_event.dart';
import '../blocs/teams/teams_state.dart';
import '../database/app_database.dart';
import 'team_details_screen.dart';
import '../blocs/team_details/team_details_bloc.dart';
import '../blocs/team_details/team_details_event.dart';
import '../repositories/poke_api_repository.dart';
import '../repositories/team_pokemon_repository.dart';

class TeamsScreen extends StatefulWidget {
  const TeamsScreen({super.key});

  @override
  State<TeamsScreen> createState() => _TeamsScreenState();
}

class _TeamsScreenState extends State<TeamsScreen> {
  void _showTeamDialog([Team? team]) {
    final nameController = TextEditingController(text: team?.name ?? '');
    final descController = TextEditingController(text: team?.description ?? '');

    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: Text(team == null ? 'Criar Time' : 'Editar Time'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Nome do Time (ex: Fogo)'),
              ),
              TextField(
                controller: descController,
                decoration: const InputDecoration(labelText: 'Descrição rápida'),
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
                context.read<TeamsBloc>().add(
                  SaveTeamEvent(
                    team: team,
                    name: nameController.text,
                    description: descController.text,
                  )
                );
                Navigator.pop(dialogContext);
              },
              child: const Text('Salvar'),
            ),
          ],
        );
      },
    );
  }

  void _deleteTeam(int id) {
    context.read<TeamsBloc>().add(DeleteTeamEvent(id));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE53935),
      appBar: AppBar(
        title: const Text('Meus Times', style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFFE53935),
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
        ),
        child: BlocBuilder<TeamsBloc, TeamsState>(
          builder: (context, state) {
            if (state is TeamsLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is TeamsError) {
              return Center(child: Text(state.message));
            } else if (state is TeamsLoaded) {
              final teams = state.teams;
              if (teams.isEmpty) {
                return const Center(
                  child: Text(
                    'Você não tem times ainda. Crie um!',
                    style: TextStyle(color: Colors.grey, fontSize: 16),
                  ),
                );
              }
              return ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: teams.length,
                itemBuilder: (context, index) {
                  final team = teams[index];
                  return Card(
                    margin: const EdgeInsets.only(bottom: 12),
                    elevation: 3,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      leading: const CircleAvatar(
                        backgroundColor: Color(0xFFE53935),
                        child: Icon(Icons.catching_pokemon, color: Colors.white),
                      ),
                      title: Text(team.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                      subtitle: Text(team.description),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => BlocProvider(
                            create: (context) => TeamDetailsBloc(
                              teamPokemonRepository: context.read<TeamPokemonRepository>(),
                              apiRepository: context.read<PokeApiRepository>(),
                            )..add(LoadTeamDetailsEvent(team.teamId)),
                            child: TeamDetailsScreen(team: team),
                          )),
                        ).then((_) {
                          if (context.mounted) {
                            context.read<TeamsBloc>().add(LoadTeamsEvent());
                          }
                        });
                      },
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit, color: Colors.blue),
                            onPressed: () => _showTeamDialog(team),
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () => _deleteTeam(team.teamId),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }
            return const SizedBox();
          },
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showTeamDialog(),
        backgroundColor: const Color(0xFFE53935),
        icon: const Icon(Icons.add, color: Colors.white),
        label: const Text('Criar Time', style: TextStyle(color: Colors.white)),
      ),
    );
  }
}
