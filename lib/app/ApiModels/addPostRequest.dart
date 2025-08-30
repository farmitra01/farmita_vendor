import 'dart:io';

class AddPostRequest {
  final String? location;
  final String tags;
  final String content;
  final List<File> images;

  AddPostRequest({
    this.location,
    required this.tags,
    required this.content,
    required this.images,
  });

  Map<String, String> toFormData() {
    return {
      if (location != null) 'location': location!,
      'tags': tags,
      'content': content,
    };
  }

  toFileMap() {}
}
