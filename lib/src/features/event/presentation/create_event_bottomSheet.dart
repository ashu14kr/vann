import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'widgets/createEvent_widgets.dart';

class CreateEventBottomSheet extends StatefulWidget {
  const CreateEventBottomSheet({super.key});

  @override
  State<CreateEventBottomSheet> createState() => _CreateEventBottomSheetState();
}

class _CreateEventBottomSheetState extends State<CreateEventBottomSheet> {
  final List<int> selectedIndices = [];
  final List<String> vibes = [
    'PARTY',
    'CHILL',
    'WILD',
    'MUSIC',
    'NIGHT',
    'ADVENTURE',
    'ROADTRIP',
  ];

  @override
  Widget build(BuildContext context) {
    final headerStyle = GoogleFonts.robotoCondensed(
      fontSize: 24,
      fontWeight: FontWeight.w900,
      color: Colors.white,
    );

    final bodyStyle = GoogleFonts.poppins(fontSize: 14, color: Colors.white70);

    return DraggableScrollableSheet(
      initialChildSize: 0.9,
      maxChildSize: 0.95,
      minChildSize: 0.5,
      expand: false,
      builder: (_, controller) {
        return Container(
          decoration: const BoxDecoration(
            color: Color(0xFF0F0F0F),
            borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
          ),
          child: Stack(
            children: [
              // 1. SCROLLABLE CONTENT
              Column(
                children: [
                  buildGrabHandle(),
                  Expanded(
                    child: ListView(
                      controller: controller,
                      physics: const ClampingScrollPhysics(),
                      // Bottom padding of 140 ensures content scrolls past the blurred button area
                      padding: const EdgeInsets.fromLTRB(20, 10, 20, 140),
                      children: [
                        buildBadge(),
                        const SizedBox(height: 30),

                        Text('TITLE', style: headerStyle),
                        const SizedBox(height: 12),
                        buildTextField(
                          hint: 'Write the title of the event',
                          fontStyle: bodyStyle,
                        ),

                        const SizedBox(height: 25),
                        Text('DESCRIPTION', style: headerStyle),
                        const SizedBox(height: 12),
                        buildTextField(
                          hint: 'What will you and participants do?',
                          fontStyle: bodyStyle,
                          maxLines: 4,
                        ),

                        const SizedBox(height: 25),
                        Text('DETAILS', style: headerStyle),
                        const SizedBox(height: 12),
                        buildFullDetailsBox(bodyStyle),

                        const SizedBox(height: 25),
                        Text('VIBE', style: headerStyle),
                        const SizedBox(height: 15),
                        buildVibeWrap(vibes, (index) {
                          setState(() {
                            selectedIndices.contains(index)
                                ? selectedIndices.remove(index)
                                : selectedIndices.add(index);
                          });
                        }, selectedIndices),
                      ],
                    ),
                  ),
                ],
              ),

              // 2. BOTTOM GRADIENT SCRIM & BLUR
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                height: 160,
                child: IgnorePointer(
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          const Color(0xFF0F0F0F).withOpacity(0.0),
                          const Color(0xFF0F0F0F).withOpacity(0.8),
                          const Color(0xFF0F0F0F),
                        ],
                        stops: const [0.0, 0.4, 1.0],
                      ),
                    ),
                  ),
                ),
              ),

              // 3. FIXED PUBLISH BUTTON
              Positioned(bottom: 30, right: 20, child: buildPublishButton()),
            ],
          ),
        );
      },
    );
  }
}
