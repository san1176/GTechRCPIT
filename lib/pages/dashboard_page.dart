import 'package:flutter/material.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final String _role = "Student"; // Fixed role

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          Text(
            'Welcome, $_role!',
            style: Theme.of(context)
                .textTheme
                .headlineSmall
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              children: [
                _quickActionCard(
                  icon: Icons.upload_file,
                  label: 'Submit Project',
                  onTap: () => _showSnack('Submit Project tapped'),
                ),
                _quickActionCard(
                  icon: Icons.emoji_events,
                  label: 'View Challenges',
                  onTap: () => _showSnack('View Challenges tapped'),
                ),
                _quickActionCard(
                  icon: Icons.menu_book,
                  label: 'Explore Learning',
                  onTap: () => _showSnack('Explore Learning tapped'),
                ),
                _quickActionCard(
                  icon: Icons.announcement,
                  label: 'Announcements / Forum',
                  onTap: () => _showSnack('Announcements tapped'),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Student Tips:',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          Text('- Don’t forget to submit projects on time.'),
          Text('- Check latest challenges weekly.'),
        ],
      ),
    );
  }

  Widget _quickActionCard({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    final isLight = Theme.of(context).brightness == Brightness.light;
    return Material(
      color: isLight ? Colors.deepPurple.shade50 : Colors.deepPurple.shade900,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 48, color: Colors.deepPurple),
              const SizedBox(height: 12),
              Text(
                label,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  color: Colors.deepPurple,
                ),
              ),
            ],
          ),
        ),
      ),
      elevation: 3,
      shadowColor: Colors.deepPurple.withOpacity(0.3),
    );
  }

  void _showSnack(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }
}
