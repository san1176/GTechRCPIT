import 'package:flutter/material.dart';

class ProjectsPage extends StatefulWidget {
  const ProjectsPage({Key? key}) : super(key: key);

  @override
  State<ProjectsPage> createState() => _ProjectsPageState();
}

class _ProjectsPageState extends State<ProjectsPage> {
  final _formKey = GlobalKey<FormState>();

  // Form controllers
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descController = TextEditingController();
  final TextEditingController _techStackController = TextEditingController();
  final TextEditingController _githubLinkController = TextEditingController();

  bool _usedGoogleTech = false;

  // Demo projects storage
  final List<_Project> _myProjects = [
    _Project(
      title: 'Flutter Chat App',
      description: 'A real-time chat app using Flutter and Firebase.',
      techStack: 'Flutter, Firebase',
      githubLink: 'https://github.com/example/flutter-chat',
      usedGoogleTech: true,
      status: 'Under Review',
      points: 0,
    ),
    _Project(
      title: 'GCP IoT Dashboard',
      description: 'Dashboard to monitor IoT devices using Google Cloud.',
      techStack: 'GCP, Flutter',
      githubLink: 'https://github.com/example/gcp-iot-dashboard',
      usedGoogleTech: true,
      status: 'Evaluated',
      points: 85,
    ),
  ];

  // Demo top projects
  final List<_Project> _topProjects = [
    _Project(
      title: 'AI Chatbot',
      description: 'An AI-powered chatbot built with Flutter and Dialogflow.',
      techStack: 'Flutter, Dialogflow',
      githubLink: 'https://github.com/example/ai-chatbot',
      usedGoogleTech: true,
      status: 'Evaluated',
      points: 95,
    ),
    _Project(
      title: 'Smart Farming',
      description: 'IoT and GCP-powered smart farming solution.',
      techStack: 'GCP, IoT',
      githubLink: 'https://github.com/example/smart-farming',
      usedGoogleTech: true,
      status: 'Evaluated',
      points: 90,
    ),
    _Project(
      title: 'Weather App',
      description: 'Weather forecast app using Flutter and Firebase.',
      techStack: 'Flutter, Firebase',
      githubLink: 'https://github.com/example/weather-app',
      usedGoogleTech: true,
      status: 'Evaluated',
      points: 88,
    ),
  ];

  @override
  void dispose() {
    _titleController.dispose();
    _descController.dispose();
    _techStackController.dispose();
    _githubLinkController.dispose();
    super.dispose();
  }

  void _submitProject() {
    if (!_formKey.currentState!.validate()) return;

    final newProject = _Project(
      title: _titleController.text.trim(),
      description: _descController.text.trim(),
      techStack: _techStackController.text.trim(),
      githubLink: _githubLinkController.text.trim(),
      usedGoogleTech: _usedGoogleTech,
      status: 'Under Review',
      points: 0,
    );

    setState(() {
      _myProjects.insert(0, newProject);
    });

    _formKey.currentState!.reset();
    setState(() {
      _usedGoogleTech = false;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Project submitted successfully!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isLight = Theme.of(context).brightness == Brightness.light;

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          leading: null,
          automaticallyImplyLeading: false,
          toolbarHeight: 0,
          foregroundColor: Color(0xFF001A66),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Submit'),
              Tab(text: 'My Projects'),
              Tab(text: 'Top Projects'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            // Submit Form
            SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    _buildTextField(_titleController, 'Project Title',
                        validator: (v) {
                      if (v == null || v.isEmpty) return 'Title is required';
                      return null;
                    }),
                    const SizedBox(height: 12),
                    _buildTextField(_descController, 'Project Description',
                        maxLines: 4, validator: (v) {
                      if (v == null || v.isEmpty)
                        return 'Description is required';
                      return null;
                    }),
                    const SizedBox(height: 12),
                    _buildTextField(
                        _techStackController, 'Tech Stack (comma separated)',
                        validator: (v) {
                      if (v == null || v.isEmpty)
                        return 'Tech stack is required';
                      return null;
                    }),
                    const SizedBox(height: 12),
                    _buildTextField(_githubLinkController, 'GitHub Link',
                        validator: (v) {
                      if (v == null || v.isEmpty)
                        return 'GitHub link is required';

                      return null;
                    }),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Checkbox(
                          value: _usedGoogleTech,
                          onChanged: (val) =>
                              setState(() => _usedGoogleTech = val ?? false),
                        ),
                        const Text('Used Google Tech?'),
                      ],
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _submitProject,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF001A66),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        minimumSize: const Size.fromHeight(48),
                      ),
                      child: const Text('Submit Project'),
                    ),
                  ],
                ),
              ),
            ),

            // My Projects List
            _buildProjectsList(_myProjects),

            // Top Projects List
            _buildProjectsList(_topProjects, showPoints: true, showBadge: true),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label,
      {int maxLines = 1, String? Function(String?)? validator}) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      validator: validator,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  Widget _buildProjectsList(List<_Project> projects,
      {bool showPoints = false, bool showBadge = false}) {
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: projects.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final p = projects[index];
        return Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          elevation: 4,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(p.title,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 18)),
                const SizedBox(height: 6),
                Text(p.description),
                const SizedBox(height: 8),
                Text('Tech Stack: ${p.techStack}'),
                const SizedBox(height: 4),
                InkWell(
                  onTap: () => _launchUrl(p.githubLink),
                  child: Text(
                    p.githubLink,
                    style: TextStyle(
                      color: Colors.blue.shade700,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Text('Used Google Tech: ${p.usedGoogleTech ? "Yes" : "No"}'),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Status: ${p.status}',
                        style: const TextStyle(fontWeight: FontWeight.w600)),
                    if (showPoints) Text('Points: ${p.points}'),
                    if (showBadge) _buildBadgeForPoints(p.points),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildBadgeForPoints(int points) {
    String label;
    Color color;

    if (points >= 90) {
      label = '🏆 Top Winner';
      color = Colors.amber.shade700;
    } else if (points >= 80) {
      label = '🥈 Runner Up';
      color = Colors.grey.shade600;
    } else {
      label = '🥉 Third Place';
      color = Colors.brown.shade400;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(label,
          style: TextStyle(color: color, fontWeight: FontWeight.bold)),
    );
  }

  void _launchUrl(String url) async {
    // Here you can integrate url_launcher or just print url for demo
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Open URL: $url')),
    );
  }
}

class _Project {
  final String title;
  final String description;
  final String techStack;
  final String githubLink;
  final bool usedGoogleTech;
  final String status; // "Under Review", "Evaluated"
  final int points;

  _Project({
    required this.title,
    required this.description,
    required this.techStack,
    required this.githubLink,
    required this.usedGoogleTech,
    required this.status,
    required this.points,
  });
}
