// lib/widgets/audio_list.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/audio_provider.dart';
import '../models/audio_file.dart';
import '../pages/transcription_page.dart';
import '../pages/summary_page.dart';

class AudioList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<AudioProvider>(
      builder: (context, audioProvider, child) {
        if (audioProvider.audioFiles.isEmpty) {
          return Center(
            child: Text(
              'No audio files available.',
              style: TextStyle(fontSize: 16),
            ),
          );
        }

        return ListView.builder(
          itemCount: audioProvider.audioFiles.length,
          itemBuilder: (context, index) {
            final audioFile = audioProvider.audioFiles[index];
            return AudioListItem(audioFile: audioFile);
          },
        );
      },
    );
  }
}

class AudioListItem extends StatelessWidget {
  final AudioFile audioFile;

  const AudioListItem({Key? key, required this.audioFile}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Format the upload date
    String formattedDate =
        "${audioFile.uploadedAt.day}/${audioFile.uploadedAt.month}/${audioFile.uploadedAt.year} ${audioFile.uploadedAt.hour}:${audioFile.uploadedAt.minute}";

    return Card(
      margin: EdgeInsets.symmetric(vertical: 6.0, horizontal: 4.0),
      elevation: 2.0,
      child: ListTile(
        leading: Icon(Icons.audiotrack, color: Colors.blue),
        title: Text(
          audioFile.name,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text('Uploaded on: $formattedDate'),
        trailing: PopupMenuButton<String>(
          onSelected: (value) {
            if (value == 'view_transcription') {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      TranscriptionPage(audioFile: audioFile),
                ),
              );
            } else if (value == 'view_summary') {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SummaryPage(audioFile: audioFile),
                ),
              );
            } else if (value == 'delete') {
              _confirmDeletion(context);
            }
          },
          itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
            const PopupMenuItem<String>(
              value: 'view_transcription',
              child: Text('View Transcription'),
            ),
            const PopupMenuItem<String>(
              value: 'view_summary',
              child: Text('View Summary'),
            ),
            const PopupMenuDivider(),
            const PopupMenuItem<String>(
              value: 'delete',
              child: Text('Delete'),
            ),
          ],
        ),
        onTap: () {
          // Navigate to Transcription Page by default
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TranscriptionPage(audioFile: audioFile),
            ),
          );
        },
      ),
    );
  }

  void _confirmDeletion(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete Audio File'),
          content: Text('Are you sure you want to delete "${audioFile.name}"?'),
          actions: [
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
            TextButton(
              child: Text(
                'Delete',
                style: TextStyle(color: Colors.red),
              ),
              onPressed: () async {
                // Call the provider to remove the file
                Provider.of<AudioProvider>(context, listen: false)
                    .removeAudioFile(audioFile.path);
                Navigator.of(context).pop(); // Close the dialog
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Audio file deleted.')),
                );
              },
            ),
          ],
        );
      },
    );
  }
}
