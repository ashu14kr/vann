import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:van_life/src/features/event/presentation/provider/provider.dart';

import 'widgets/createEvent_widgets.dart';

class CreateEventBottomSheet extends ConsumerStatefulWidget {
  const CreateEventBottomSheet({super.key});

  @override
  ConsumerState<CreateEventBottomSheet> createState() =>
      _CreateEventBottomSheetState();
}

class _CreateEventBottomSheetState
    extends ConsumerState<CreateEventBottomSheet> {
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

  TextEditingController title = TextEditingController();
  TextEditingController discription = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final headerStyle = GoogleFonts.robotoCondensed(
      fontSize: 24,
      fontWeight: FontWeight.w900,
      color: Colors.white,
    );

    final eventContro = ref.watch(eventController);

    final bodyStyle = GoogleFonts.poppins(fontSize: 14, color: Colors.white70);

    return InkWell(
      onTap: () => FocusScope.of(context).unfocus(),
      child: DraggableScrollableSheet(
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
                        padding: const EdgeInsets.fromLTRB(20, 10, 20, 140),
                        children: [
                          buildBadge(),
                          const SizedBox(height: 30),

                          Text('TITLE', style: headerStyle),
                          const SizedBox(height: 12),
                          buildTextField(
                            hint: 'Write the title of the event',
                            fontStyle: bodyStyle,
                            controller: title,
                          ),

                          const SizedBox(height: 25),
                          Text('DESCRIPTION', style: headerStyle),
                          const SizedBox(height: 12),
                          buildTextField(
                            hint: 'What will you and participants do?',
                            fontStyle: bodyStyle,
                            maxLines: 4,
                            controller: discription,
                          ),

                          const SizedBox(height: 25),
                          Text('DETAILS', style: headerStyle),
                          const SizedBox(height: 12),
                          buildFullDetailsBox(
                            bodyStyle,
                            context,
                            eventContro.eventModel.locationText,
                            eventContro.eventModel.startDate.toString(),
                            eventContro.eventModel.endDate.toString(),
                            eventContro.eventModel.capacity.toString(),
                          ),
                          const SizedBox(height: 25),
                          Text('VIBE', style: headerStyle),
                          const SizedBox(height: 15),
                          buildVibeWrap(vibes, (index) {
                            setState(() {
                              selectedIndices.contains(index)
                                  ? selectedIndices.remove(index)
                                  : selectedIndices.add(index);
                            });
                            ref
                                .read(eventController.notifier)
                                .updateVibeList(vibes); //FIX NEEDED
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
                Positioned(
                  bottom: 30,
                  right: 20,
                  child: buildPublishButton(
                    ontap: () async {
                      if (selectedIndices.length < 3) return;
                      await ref
                          .read(eventController.notifier)
                          .addEvent(
                            title: title.text,
                            description: discription.text,
                          );
                      if (!context.mounted) return;
                      Navigator.pop(context);
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
