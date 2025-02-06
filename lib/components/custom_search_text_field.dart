import 'package:flutter/material.dart';
import 'package:house/utils/search_result.dart';

class CustomSearchTextField extends StatefulWidget {
  final String labelText;
  final SearchResult? initialValue;
  final bool requiredField;
  final void Function(SearchResult?)? onChanged;
  final List<SearchResult> searchResults;
  const CustomSearchTextField({
    super.key,
    required this.labelText,
    this.initialValue,
    this.onChanged,
    this.requiredField = false,
    this.searchResults = const [],
  });

  @override
  State<CustomSearchTextField> createState() => _CustomSearchTextFieldState();
}

class _CustomSearchTextFieldState extends State<CustomSearchTextField> {
  late TextEditingController controller;
  SearchResult? result;

  void _showSearch() async {
    final resultSearch = await showSearch<SearchResult?>(
      context: context,
      delegate: CustomSearchDelegate(widget.searchResults),
    );
    result = resultSearch;
    controller.text = resultSearch != null ? resultSearch.name : '';
    
  }

  @override
  void initState() {
    controller = TextEditingController(text: widget.initialValue?.name);
    controller.addListener(() {
      widget.onChanged?.call(result);
    });
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      onTap: () => _showSearch(),
      readOnly: true,
      validator: widget.requiredField
          ? (text) {
              if (text == null || text.isEmpty) {
                return "Campo obligatorio";
              }
              return null;
            }
          : null,
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        labelText: widget.labelText,
        border: const OutlineInputBorder(),
        suffixIcon: InkWell(
          child: const Icon(Icons.search),
          onTap: () => _showSearch(),
        ),
      ),
    );
  }
}

class CustomSearchDelegate extends SearchDelegate<SearchResult?> {
  final List<SearchResult> searchResults;
  CustomSearchDelegate(this.searchResults);

  List<SearchResult> _filterResults() {
    return searchResults.where((searchResult) {
      final result = searchResult.name.toLowerCase();
      final input = query.toLowerCase();
      return result.contains(input);
    }).toList();
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          if (query.isEmpty) {
            close(context, null);
          } else {
            query = '';
          }
        },
        icon: const Icon(Icons.clear),
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () => close(context, null),
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<SearchResult> suggestions = _filterResults();

    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        final suggestion = suggestions[index];
        return ListTile(
          key: Key(suggestion.id.toString()),
          title: Text(suggestion.name),
          onTap: () => close(context, suggestion),
        );
      },
    );
  }
}
