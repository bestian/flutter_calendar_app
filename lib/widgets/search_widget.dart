import 'package:flutter/material.dart';
import '../models/event.dart';

class SearchWidget extends StatefulWidget {
  final List<Event> allEvents;
  final Function(Event) onEventSelected;

  const SearchWidget({
    Key? key,
    required this.allEvents,
    required this.onEventSelected,
  }) : super(key: key);

  @override
  State<SearchWidget> createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  final TextEditingController _searchController = TextEditingController();
  List<Event> _searchResults = [];
  bool _isSearching = false;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _performSearch(String query) {
    if (query.isEmpty) {
      setState(() {
        _searchResults = [];
        _isSearching = false;
      });
      return;
    }

    setState(() {
      _isSearching = true;
      _searchResults = widget.allEvents.where((event) {
        final title = event.title.toLowerCase();
        final group = event.group.toLowerCase();
        final searchQuery = query.toLowerCase();
        
        return title.contains(searchQuery) || 
               group.contains(searchQuery) ||
               event.data.values.any((value) => 
                 value.toLowerCase().contains(searchQuery));
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // 搜尋欄位
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: _searchController,
            decoration: InputDecoration(
              hintText: '搜尋活動...',
              prefixIcon: const Icon(Icons.search),
              suffixIcon: _searchController.text.isNotEmpty
                  ? IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: () {
                        _searchController.clear();
                        _performSearch('');
                      },
                    )
                  : null,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
            onChanged: _performSearch,
          ),
        ),
        // 搜尋結果清單
        if (_isSearching && _searchResults.isNotEmpty)
          Expanded(
            child: Card(
              margin: const EdgeInsets.all(8.0),
              child: ListView.builder(
                itemCount: _searchResults.length,
                itemBuilder: (context, index) {
                  final event = _searchResults[index];
                  return ListTile(
                    title: Text(event.title),
                    subtitle: Text(event.group),
                    onTap: () {
                      widget.onEventSelected(event);
                      _searchController.clear();
                      _performSearch('');
                    },
                  );
                },
              ),
            ),
          ),
        // 無搜尋結果提示
        if (_isSearching && _searchResults.isEmpty)
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text('找不到符合的活動'),
          ),
      ],
    );
  }
} 