import 'package:flutter/material.dart';
import 'package:graphview/GraphView.dart';

class ArtistNetworkGraph extends StatefulWidget {
  const ArtistNetworkGraph({super.key});

  @override
  State<ArtistNetworkGraph> createState() => _ArtistNetworkGraphState();
}

class _ArtistNetworkGraphState extends State<ArtistNetworkGraph> {
  final Graph graph = Graph()..isTree = false;

  final BuchheimWalkerConfiguration builder = BuchheimWalkerConfiguration()
    ..siblingSeparation = (30)
    ..levelSeparation = (40)
    ..subtreeSeparation = (30)
    ..orientation = (BuchheimWalkerConfiguration.ORIENTATION_TOP_BOTTOM);

  @override
  void initState() {
    super.initState();
    _buildGraph();
  }

  void _buildGraph() {
    final artistA = Node.Id('Artist A');
    final artistB = Node.Id('Artist B');
    final artistC = Node.Id('Artist C');
    final artistD = Node.Id('Artist D');
    final artistE = Node.Id('Artist E');

    graph.addEdge(artistA, artistB);
    graph.addEdge(artistA, artistC);
    graph.addEdge(artistA, artistD);
    graph.addEdge(artistC, artistE);
  }

  Widget _artistNode(String name) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFF2C2C2C),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        name,
        style: const TextStyle(
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Artist Network',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 20),
        Expanded(
          child: InteractiveViewer(
            constrained: false,
            boundaryMargin: const EdgeInsets.all(100),
            minScale: 0.01,
            maxScale: 5.6,
            child: GraphView(
              graph: graph,
              algorithm: BuchheimWalkerAlgorithm(builder, TreeEdgeRenderer(builder)),
              builder: (Node node) {
                final name = node.key!.value as String;
                return _artistNode(name);
              },
            ),
          ),
        ),
      ],
    );
  }
}
