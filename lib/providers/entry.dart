import 'dart:async';
import 'dart:typed_data';
import 'package:appwrite/appwrite.dart';
import 'package:movie_app/api/client.dart';
import 'package:movie_app/data/entry.dart';
import 'package:flutter/material.dart';

class EntryProvider extends ChangeNotifier {
  final Map<String, Uint8List> _imageCache = {};

  static final String _databaseId = ID.custom("default2");
  static final String _collectionId = ID.custom("movies");
  static final String _bucketId = ID.custom("default1");

  Entry? _selected;
  Entry? get selected => _selected;

  Entry _featured = Entry.empty();
  Entry get featured => _featured;

  List<Entry> _entries = [];
  List<Entry> get entries => _entries;
  List<Entry> get originals => _entries.where((e) => e.isOriginal).toList();
  List<Entry> get animations => _entries.where((e) => e.ReleaseDate != null && e.ReleaseDate!.isAfter(DateTime.parse('2022-01-01'))).toList();
  List<Entry> get trending {
    var trending = _entries;
    trending.sort((a, b) => b.trendingIndex.compareTo(a.trendingIndex));
    return trending;
  }

  void setSelected(Entry entry) {
    _selected = entry;
    notifyListeners();
  }

  Future<void> list() async {
    var result = await ApiClient.database.listDocuments(databaseId: _databaseId, collectionId: _collectionId);

    _entries = result.documents.map((document) => Entry.fromJson(document.data)).toList();
    _featured = _entries.isEmpty ? Entry.empty() : _entries[0];

    notifyListeners();
  }

  Future<Uint8List> imageFor(Entry entry) async {
    if(_imageCache.containsKey(entry.thumbnailImageId)) {
      return _imageCache[entry.thumbnailImageId]!;
    }

    final result = await ApiClient.storage.getFileView(
      bucketId: _bucketId, fileId: entry.thumbnailImageId
    );

    _imageCache[entry.thumbnailImageId] = result;

    return result;
  }
}