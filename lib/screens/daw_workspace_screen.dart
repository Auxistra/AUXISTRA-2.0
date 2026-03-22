import 'package:flutter/material.dart';

class DAWWorkspaceScreen extends StatelessWidget {
  const DAWWorkspaceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("Remix Workspace"),
        backgroundColor: Colors.black,
        elevation: 0,
      ),
      body: Column(
        children: [

          /// TRANSPORT CONTROLS
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            color: const Color(0xFF1A1A1A),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(children: const [
                  Icon(Icons.skip_previous),
                  SizedBox(width: 10),
                  Icon(Icons.play_arrow),
                  SizedBox(width: 10),
                  Icon(Icons.pause),
                  SizedBox(width: 10),
                  Icon(Icons.stop),
                  SizedBox(width: 10),
                  Icon(Icons.skip_next),
                ]),
                Row(children: const [
                  Text("120 BPM", style: TextStyle(color: Colors.white)),
                  SizedBox(width: 20),
                  Text("4/4", style: TextStyle(color: Colors.white)),
                ]),
                Row(children: const [
                  Text("Loop", style: TextStyle(color: Colors.white70)),
                  SizedBox(width: 15),
                  Text("Snap", style: TextStyle(color: Colors.white70)),
                ])
              ],
            ),
          ),

          /// TIMELINE + WAVEFORM
          Container(
            height: 140,
            color: const Color(0xFF111111),
            child: Column(
              children: [
                Container(
                  height: 30,
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: const Text(
                    "|1|2|3|4|1|2|3|4|",
                    style: TextStyle(color: Colors.white54),
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: const Color(0xFF1E1E1E),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                )
              ],
            ),
          ),

          /// AUTOMATION LANES
          Container(
            height: 100,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  "Automation",
                  style: TextStyle(color: Colors.white70),
                ),
                SizedBox(height: 8),
                Expanded(
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: Color(0xFF1C1C1C),
                    ),
                  ),
                )
              ],
            ),
          ),

          /// STEM MIXER
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: const [
                _StemChannel(name: "Vocals"),
                _StemChannel(name: "Drums"),
                _StemChannel(name: "Bass"),
                _StemChannel(name: "Synth"),
                _StemChannel(name: "FX"),
              ],
            ),
          ),

          /// MASTER BUS
          Container(
            height: 90,
            color: const Color(0xFF141414),
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text("Master Limiter", style: TextStyle(color: Colors.white)),
                Text("Spectrum Analyzer", style: TextStyle(color: Colors.white)),
                Text("Loudness Meter", style: TextStyle(color: Colors.white)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _StemChannel extends StatelessWidget {
  final String name;

  const _StemChannel({required this.name});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

        Text(
          name,
          style: const TextStyle(color: Colors.white),
        ),

        const SizedBox(height: 10),

        /// VU Meter
        Container(
          height: 60,
          width: 14,
          color: Colors.green,
        ),

        const SizedBox(height: 10),

        /// Volume fader
        SizedBox(
          height: 120,
          child: RotatedBox(
            quarterTurns: -1,
            child: Slider(
              value: 0.5,
              onChanged: (v) {},
            ),
          ),
        ),

        const SizedBox(height: 10),

        /// Pan
        SizedBox(
          width: 60,
          child: Slider(
            value: 0,
            min: -1,
            max: 1,
            onChanged: (v) {},
          ),
        ),

        const SizedBox(height: 10),

        /// Mute / Solo
        Row(
          children: const [
            Icon(Icons.volume_off, color: Colors.red),
            SizedBox(width: 8),
            Icon(Icons.headphones, color: Colors.green),
          ],
        ),

        const SizedBox(height: 10),

        /// Effects
        Column(
          children: const [
            Text("EQ", style: TextStyle(color: Colors.white54)),
            Text("Comp", style: TextStyle(color: Colors.white54)),
            Text("Reverb", style: TextStyle(color: Colors.white54)),
          ],
        )
      ],
    );
  }
}
