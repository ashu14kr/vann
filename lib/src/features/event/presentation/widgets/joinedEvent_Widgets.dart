import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget buildTopNavigation() {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 5),
    child: Row(
      children: [
        const Spacer(),
        Text(
          "Event Detail",
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        const Expanded(
          child: Align(
            alignment: Alignment.centerRight,
            child: Icon(
              Icons.edit_square,
              color: Colors.white,
              size: 30,
            ), // Larger icon
          ),
        ),
      ],
    ),
  );
}

Widget buildHostAvatar() {
  return Container(
    padding: const EdgeInsets.all(3),
    decoration: const BoxDecoration(
      color: Colors.white,
      shape: BoxShape.circle,
    ),
    child: const CircleAvatar(
      radius: 32, // Bigger avatar
      backgroundImage: AssetImage('assets/images/profile.png'),
    ),
  );
}

Widget buildMapWithBlueGradient() {
  return Container(
    height: 140,
    width: double.infinity,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(25),
      image: const DecorationImage(
        image: AssetImage('assets/images/map_view.png'),
        fit: BoxFit.cover,
      ),
    ),
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            const Color(0xFF0047FF).withOpacity(0.85),
            const Color(0xFF0047FF).withOpacity(0.2),
          ],
        ),
      ),
    ),
  );
}

Widget buildParticipantsList() {
  return Container(
    padding: const EdgeInsets.all(24),
    decoration: BoxDecoration(
      color: const Color(0xFF111111),
      borderRadius: BorderRadius.circular(35),
    ),
    child: Column(
      children: [
        participantItem(
          "#1",
          "Sam Altman",
          "Founder of disciplue",
          const Color(0xFFFFE600),
        ),
        participantItem("#2", "Ritvik Singh", "Wipro", const Color(0xFFFFA500)),
        participantItem(
          "#3",
          "Ravi Sastri",
          "Golfer at MCG",
          const Color(0xFFA066FF),
        ),
      ],
    ),
  );
}

Widget participantItem(String rank, String name, String sub, Color rankColor) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 10),
    child: Row(
      children: [
        // Bigger rank with thick white border (Explore style)
        Stack(
          children: [
            Text(
              rank,
              style: GoogleFonts.robotoCondensed(
                fontSize: 32,
                fontWeight: FontWeight.w900,
                foreground:
                    Paint()
                      ..style = PaintingStyle.stroke
                      ..strokeWidth = 6
                      ..color = Colors.white,
              ),
            ),
            Text(
              rank,
              style: GoogleFonts.robotoCondensed(
                fontSize: 32,
                fontWeight: FontWeight.w900,
                color: rankColor,
              ),
            ),
          ],
        ),
        const SizedBox(width: 20),
        const CircleAvatar(
          radius: 28, // Bigger avatars
          backgroundImage: AssetImage('assets/images/profile.png'),
        ),
        const SizedBox(width: 15),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name,
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: 17,
              ),
            ),
            Text(
              sub,
              style: GoogleFonts.poppins(
                color: const Color.fromARGB(173, 255, 255, 255),
                fontSize: 15,
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

// Helper methods
Widget buildGrabHandle() => Center(
  child: Container(
    width: 55,
    height: 8,
    decoration: BoxDecoration(
      color: Colors.white24,
      borderRadius: BorderRadius.circular(10),
    ),
  ),
);

Widget buildSectionHeader(String title, String trailing) => Row(
  mainAxisAlignment: MainAxisAlignment.spaceBetween,
  children: [
    Text(
      title,
      style: GoogleFonts.robotoCondensed(
        color: Colors.white,
        fontSize: 27,
        fontWeight: FontWeight.w900,
      ),
    ),
    Text(
      trailing,
      style: GoogleFonts.poppins(
        color: const Color.fromARGB(192, 255, 255, 255),
        fontSize: 16,
      ),
    ),
  ],
);

Widget buildHorizontalGallery() => SizedBox(
  height: 220,
  child: ListView.separated(
    scrollDirection: Axis.horizontal,
    itemCount: 2,
    separatorBuilder: (_, __) => const SizedBox(width: 15),
    itemBuilder:
        (_, __) => ClipRRect(
          borderRadius: BorderRadius.circular(25),
          child: Image.asset(
            'assets/images/event.jpg',
            width: 190,
            fit: BoxFit.cover,
          ),
        ),
  ),
);

Widget buildStickerVibeTags() {
  final List<Map<String, dynamic>> tags = [
    {'text': 'CALM', 'color': const Color(0xFFD4E157), 'rot': -0.04},
    {'text': 'SOCIAL', 'color': const Color(0xFF81C784), 'rot': 0.03},
    {'text': 'NIGHT', 'color': const Color(0xFF00D1FF), 'rot': -0.02},
  ];
  return Wrap(
    spacing: 12,
    runSpacing: 18,
    children:
        tags
            .map(
              (tag) => Transform.rotate(
                angle: tag['rot'],
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    color: tag['color'],
                    border: Border.all(color: Colors.white, width: 2),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        offset: const Offset(4, 4),
                      ),
                    ],
                  ),
                  child: Text(
                    tag['text'],
                    style: GoogleFonts.robotoCondensed(
                      fontWeight: FontWeight.w900,
                      fontSize: 18,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            )
            .toList(),
  );
}

Widget buildBottomScrim() => Positioned(
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
            Colors.black.withOpacity(0),
            Colors.black.withOpacity(0.8),
            Colors.black,
          ],
        ),
      ),
    ),
  ),
);

Widget buildChatButton() => Container(
  width: double.infinity,
  height: 65,
  decoration: BoxDecoration(
    gradient: const LinearGradient(
      colors: [Color(0xFFF2BC56), Color(0xFFF9E364)],
    ),
    borderRadius: BorderRadius.circular(35),
  ),
  child: Center(
    child: Text(
      "CHAT",
      style: GoogleFonts.poppins(
        color: Colors.black,
        fontSize: 24,
        fontWeight: FontWeight.w700,
      ),
    ),
  ),
);
