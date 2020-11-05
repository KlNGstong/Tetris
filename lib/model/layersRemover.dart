import 'package:tetris/model/border/blocks.dart';

import 'border/boardConfig.dart';
import 'border/borderIndex.dart';

class LayersRemover {
  final Blocks _blocks;

  LayersRemover(this._blocks);

  void remove() {
    final lastFigureComp =
        _blocks.figureStack.last.figureComp.map((e) => e.index).toList();
    List<int> fillCount = List.generate(BoardConfig.columns, (index) => 0);
    _blocks.blockList.forEach(
      (block) {
        if (block.index.column >= 0 &&
            !lastFigureComp.contains(block.index.index))
          fillCount[block.index.column] += 1;
      },
    );
    List.generate(
      fillCount.length,
      (index) {
        if (fillCount[index] == BoardConfig.rows) {
          removeLayer(index);
          // shiftBlocks(index);
        }
      },
    );
  }

  void removeLayer(int layerIndex) {
    _blocks.figureStack.forEach((figure) {
      final thereAreCurrentLayers =
          figure.figureComp.map((e) => e.column == layerIndex).toList();
      if (thereAreCurrentLayers.contains(true)) {
        List<BorderIndex> listForDeformation = [];
        List.generate(
          thereAreCurrentLayers.length,
          (index) {
            if (thereAreCurrentLayers[index]) {
              listForDeformation.add(figure.figureComp[index]);
            }
          },
        );
        figure.matrix.matrixDeformer(listForDeformation, figure.currentShift);
      }
    });
  }

  void shiftBlocks(int start) {
    _blocks.figureStack.forEach(
      (figure) {
        if (figure.currentShift.column >= start) {
          figure.currentShift += BorderIndex(0, 1);
        }
      },
    );
  }
}
