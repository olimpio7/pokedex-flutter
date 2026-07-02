import 'package:flutter/material.dart';
import '../main.dart';
import '../database/app_database.dart';
import 'team_details_screen.dart';

class TeamsScreen extends StatefulWidget {
  const TeamsScreen({super.key});

  @override
  State<TeamsScreen> createState() => _TeamsScreenState();
}

class _TeamsScreenState extends State<TeamsScreen> {
  List<Team> _teams = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadTeams();
  }

  Future<void> _loadTeams() async {
    final teams = await teamRepository.getTeams();
    setState(() {
      _teams = teams;
      _isLoading = false;
    });
  }

  void _showTeamDialog([Team? team]) {
    final nameController = TextEditingController(text: team?.name ?? '');
    final descController = TextEditingController(text: team?.description ?? '');

    showDialog(
      context: context,
      builder: (context) {
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
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () async {
                final nav = Navigator.of(context);
                if (team == null) {
                  await teamRepository.createTeam(
                    name: nameController.text,
                    description: descController.text,
                  );
                } else {
                  await teamRepository.updateTeam(
                    teamId: team.teamId,
                    name: nameController.text,
                    description: descController.text,
                    createdAt: team.createdAt,
                  );
                }
                nav.pop();
                _loadTeams();
              },
              child: const Text('Salvar'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _deleteTeam(int id) async {
    await teamRepository.deleteTeam(id);
    _loadTeams();
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
        child: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : _teams.isEmpty
                ? const Center(
                    child: Text(
                      'Você não tem times ainda. Crie um!',
                      style: TextStyle(color: Colors.grey, fontSize: 16),
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: _teams.length,
                    itemBuilder: (context, index) {
                      final team = _teams[index];
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
                          onTap: () async {
                            await Navigator.push(
                              context,
                              MaterialPageRoute(builder: (_) => TeamDetailsScreen(team: team)),
                            );
                            _loadTeams();
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
