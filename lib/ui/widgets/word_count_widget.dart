import 'package:flutter/material.dart';

/// Widget to display word count for text content
class WordCountWidget extends StatelessWidget {
  final String text;
  final bool showCharacters;
  
  const WordCountWidget({
    super.key,
    required this.text,
    this.showCharacters = false,
  });
  
  int get wordCount {
    if (text.isEmpty) return 0;
    return text.split(RegExp(r'\s+')).where((w) => w.isNotEmpty).length;
  }
  
  int get characterCount {
    return text.length;
  }
  
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondaryContainer,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.text_fields,
            size: 16,
            color: Theme.of(context).colorScheme.onSecondaryContainer,
          ),
          const SizedBox(width: 6),
          Text(
            showCharacters 
                ? '$wordCount words • $characterCount chars'
                : '$wordCount words',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: Theme.of(context).colorScheme.onSecondaryContainer,
            ),
          ),
        ],
      ),
    );
  }
}

/// Widget for writing goals and progress
class WritingGoalWidget extends StatelessWidget {
  final int currentWords;
  final int goalWords;
  
  const WritingGoalWidget({
    super.key,
    required this.currentWords,
    this.goalWords = 500,
  });
  
  double get progress {
    if (goalWords == 0) return 0;
    return (currentWords / goalWords).clamp(0.0, 1.0);
  }
  
  @override
  Widget build(BuildContext context) {
    final isComplete = currentWords >= goalWords;
    
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  isComplete ? Icons.check_circle : Icons.track_changes,
                  color: isComplete ? Colors.green : Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(width: 8),
                Text(
                  isComplete ? 'Goal Achieved!' : 'Daily Goal',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ],
            ),
            const SizedBox(height: 12),
            LinearProgressIndicator(
              value: progress,
              minHeight: 8,
              backgroundColor: Colors.grey.shade200,
              valueColor: AlwaysStoppedAnimation(
                isComplete ? Colors.green : Theme.of(context).colorScheme.primary,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              '$currentWords / $goalWords words (${(progress * 100).toInt()}%)',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }
}
