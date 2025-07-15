import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ChallengesPage extends StatefulWidget {
  const ChallengesPage({Key? key}) : super(key: key);

  @override
  State<ChallengesPage> createState() => _ChallengesPageState();
}

class _ChallengesPageState extends State<ChallengesPage> {
  // Demo challenges with descriptions added
  final List<_Challenge> _challenges = [
    _Challenge(
      id: '1',
      title: 'Firebase Auth System',
      description:
          'Implement secure login/signup with Firebase Auth. Use email/password authentication and handle user sessions effectively.',
      timeEstimate: '2 hrs',
      points: 50,
      instructions:
          'Implement a Firebase Authentication system with email/password login and signup.',
    ),
    _Challenge(
      id: '2',
      title: 'Flutter UI Layout',
      description:
          'Design a responsive and dynamic social media feed UI using Flutter widgets, ensuring it looks good on all screen sizes.',
      timeEstimate: '3 hrs',
      points: 70,
      instructions: 'Build a responsive Flutter UI for a social media feed.',
    ),
    _Challenge(
      id: '3',
      title: 'GCP Cloud Function',
      description:
          'Create a Google Cloud Function that triggers on HTTP requests to execute backend logic without managing servers.',
      timeEstimate: '1.5 hrs',
      points: 40,
      instructions:
          'Create a Google Cloud Function triggered by HTTP requests.',
    ),
  ];

  final Set<String> _completedChallengeIds = {};

  int get _earnedPoints {
    int total = 0;
    for (var c in _challenges) {
      if (_completedChallengeIds.contains(c.id)) {
        total += c.points;
      }
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    final isLight = Theme.of(context).brightness == Brightness.light;

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Progress Section at the top
          Text(
            'My Challenge Progress',
            style: Theme.of(context)
                .textTheme
                .headlineSmall
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          Text(
              'Completed Challenges: ${_completedChallengeIds.length} / ${_challenges.length}'),
          Text('Earned Points: $_earnedPoints 🪙'),
          const SizedBox(height: 16),

          // Challenges list scrollable
          Expanded(
            child: ListView(
              children: _challenges.map((challenge) {
                final completed = _completedChallengeIds.contains(challenge.id);
                return Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                  color: completed
                      ? (isLight
                          ? Colors.green.shade100
                          : Colors.green.shade800)
                      : null,
                  elevation: 4,
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(16),
                    onTap: () => _showChallengeDetails(challenge),
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SvgPicture.asset(
                            'assets/icons/challenges.svg',
                            width: 36,
                            height: 36,
                            color: Color(0xFF001A66),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  challenge.title,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  challenge.description,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: Colors.grey[700],
                                    fontSize: 14,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  'Time: ${challenge.timeEstimate} | Points: ${challenge.points}',
                                  style: const TextStyle(fontSize: 13),
                                ),
                              ],
                            ),
                          ),
                          if (completed)
                            const Padding(
                              padding: EdgeInsets.only(left: 8, top: 4),
                              child:
                                  Icon(Icons.check_circle, color: Colors.green),
                            ),
                        ],
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  void _showChallengeDetails(_Challenge challenge) {
    final isCompleted = _completedChallengeIds.contains(challenge.id);
    final TextEditingController submissionController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(challenge.title),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Instructions:',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 8),
                Text(challenge.instructions),
                const SizedBox(height: 20),
                if (!isCompleted) ...[
                  Text(
                    'Submit your work (link or notes):',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: submissionController,
                    maxLines: 3,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12)),
                      hintText: 'Enter submission URL or notes',
                    ),
                  ),
                ] else
                  Text(
                    'Challenge completed! 🎉',
                    style: TextStyle(
                        color: Colors.green.shade700,
                        fontWeight: FontWeight.bold),
                  ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Close'),
            ),
            if (!isCompleted)
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF001A66),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
                onPressed: () {
                  if (submissionController.text.trim().isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text('Please enter your submission')),
                    );
                    return;
                  }
                  setState(() {
                    _completedChallengeIds.add(challenge.id);
                  });
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                        content: Text(
                            'Challenge "${challenge.title}" marked completed!')),
                  );
                },
                child: const Text('Submit'),
              ),
          ],
        );
      },
    );
  }
}

class _Challenge {
  final String id;
  final String title;
  final String description; // NEW FIELD
  final String timeEstimate;
  final int points;
  final String instructions;

  _Challenge({
    required this.id,
    required this.title,
    required this.description,
    required this.timeEstimate,
    required this.points,
    required this.instructions,
  });
}
