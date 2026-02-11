import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:apple_maps_flutter/apple_maps_flutter.dart';

class AestheticLocationPicker extends StatefulWidget {
  final Function(LatLng, String) onSelect;
  const AestheticLocationPicker({super.key, required this.onSelect});

  @override
  State<AestheticLocationPicker> createState() =>
      _AestheticLocationPickerState();
}

class _AestheticLocationPickerState extends State<AestheticLocationPicker> {
  List<dynamic> _results = [];
  bool _isLoading = false;
  Timer? _debounce;

  Future<void> _searchPlaces(String query) async {
    if (query.length < 3) {
      setState(() => _results = []);
      return;
    }
    setState(() => _isLoading = true);

    try {
      final url = Uri.parse(
        'https://nominatim.openstreetmap.org/search?q=$query&format=json&addressdetails=1&limit=10',
      );
      final response = await http.get(
        url,
        headers: {'User-Agent': 'VanLifeApp'},
      );

      if (response.statusCode == 200) {
        setState(() {
          _results = json.decode(response.body);
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    // Styling constants to match your main UI
    final headerStyle = GoogleFonts.robotoCondensed(
      fontSize: 20,
      fontWeight: FontWeight.w900,
      color: Colors.white,
    );
    final bodyStyle = GoogleFonts.poppins(fontSize: 14, color: Colors.white70);
    final addressStyle = GoogleFonts.poppins(
      fontSize: 12,
      color: Colors.white38,
    );

    return DraggableScrollableSheet(
      initialChildSize: 0.9,
      maxChildSize: 0.95,
      minChildSize: 0.6,
      expand: false,
      builder: (context, scrollController) {
        return Container(
          decoration: const BoxDecoration(
            color: Color(0xFF0F0F0F), // Deep black background
            borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
          ),
          child: Column(
            children: [
              // 1. DRAG HANDLE
              Container(
                margin: const EdgeInsets.symmetric(vertical: 15),
                height: 4,
                width: 35,
                decoration: BoxDecoration(
                  color: Colors.white12,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),

              // 2. HEADER
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 25,
                  vertical: 10,
                ),
                child: Row(
                  children: [
                    Text("SELECT LOCATION", style: headerStyle),
                    const Spacer(),
                    if (_isLoading)
                      const SizedBox(
                        width: 15,
                        height: 15,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      ),
                  ],
                ),
              ),

              // 3. MINIMAL SEARCH INPUT
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 15,
                ),
                child: TextField(
                  onChanged: (val) {
                    if (_debounce?.isActive ?? false) _debounce!.cancel();
                    _debounce = Timer(
                      const Duration(milliseconds: 700),
                      () => _searchPlaces(val),
                    );
                  },
                  style: bodyStyle.copyWith(color: Colors.white),
                  cursorColor: Colors.white,
                  decoration: InputDecoration(
                    hintText: "Search city or area...",
                    hintStyle: bodyStyle.copyWith(color: Colors.white24),
                    prefixIcon: const Icon(
                      Icons.search,
                      color: Colors.white54,
                      size: 20,
                    ),
                    filled: true,
                    fillColor: const Color(0xFF1A1A1A), // Subtle grey-black
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.symmetric(vertical: 18),
                  ),
                ),
              ),

              // 4. RESULTS LIST
              Expanded(
                child: ListView.separated(
                  controller: scrollController,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  itemCount: _results.length + 1,
                  separatorBuilder:
                      (_, __) => const Divider(
                        color: Colors.white10,
                        indent: 60,
                        height: 1,
                      ),
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      return ListTile(
                        leading: const CircleAvatar(
                          backgroundColor: Color(0xFF1A1A1A),
                          child: Icon(
                            Icons.my_location,
                            color: Colors.white,
                            size: 18,
                          ),
                        ),
                        title: Text(
                          "Current Location",
                          style: bodyStyle.copyWith(
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                        onTap: () {
                          /* GPS Logic */
                        },
                      );
                    }

                    final item = _results[index - 1];
                    final String fullName = item['display_name'];
                    final List<String> parts = fullName.split(',');
                    final String title = parts[0];
                    final String subtitle = parts.skip(1).join(',').trim();

                    return ListTile(
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 5,
                      ),
                      leading: const Icon(
                        Icons.location_on_outlined,
                        color: Colors.white24,
                      ),
                      title: Text(
                        title,
                        style: bodyStyle.copyWith(fontWeight: FontWeight.w600),
                      ),
                      subtitle: Text(
                        subtitle,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: addressStyle,
                      ),
                      onTap: () {
                        final lat = double.parse(item['lat']);
                        final lon = double.parse(item['lon']);
                        print("$lat /n $lon");
                        widget.onSelect(LatLng(lat, lon), title);
                        Navigator.pop(context);
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
