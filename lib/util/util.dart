import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../db/constants.dart';

Future<bool> confirmAction(
  BuildContext context,
  String title,
  String message,
) async {
  final confirm = await showDialog<bool>(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(true),
            style: ElevatedButton.styleFrom(
              backgroundColor: primaryColor,
              foregroundColor: Colors.white,
            ),
            child: Text("Confirm"),
          ),
        ],
      );
    },
  );

  return confirm ?? false;
}

String formatJoinDate(String createdAt) {
  DateTime date = DateTime.parse(createdAt);
  return "Joined ${DateFormat.yMMM().format(date)}"; // e.g. "Joined Jan 2023"
}

String formatDate(dynamic date, {String format = 'MMM d yyyy'}) {
  if (date == null) return "N/A";

  try {
    DateTime parsed;

    if (date is String) {
      if (date.isEmpty) return "N/A";
      parsed = DateTime.parse(date);
    } else if (date is DateTime) {
      parsed = date;
    } else {
      return "N/A";
    }

    return DateFormat(format).format(parsed.toLocal());
  } catch (_) {
    return "N/A";
  }
}

List<File> convertPathsToFiles(List<String> paths) {
  return paths.map((path) => File(path)).toList();
}

String removeLeadingSlash(String url) {
  return url.startsWith('/') ? url.substring(1) : url;
}
