class Player {}

class Game {
  List<int> grid = [0, 0, 0, 0, 0, 0, 0, 0, 0];
  bool isGameOver = false;
  String _turn = "X";

  String getTurn() => _turn;
  void makePlay(int index, String trn) {
    if (grid[index] == 0) {
      grid[index] = trn == 'X' ? 1 : 2;
      _turn = trn == 'X' ? 'O' : 'X';
    }
  }

  String checkWinning(String trn) {
    for (int i = 0; i < 3; i++) {
      int rowHead = grid[i * 3] == 0 ? -1 : grid[i * 3];
      int count = 1, count2 = 1;
      for (int j = 0; j < 3; j++) {
        if (j != 0) {
          if (grid[i * 3 + j] == rowHead) count++;

          if ((grid[j * 3 + i] == grid[(j - 1) * 3 + i]) &&
              grid[(j - 1) * 3 + i] != 0) count2++;
        }
      }
      if (((grid[0] == grid[1 * 3 + 1]) &&
              (grid[1 * 3 + 1] == grid[2 * 3 + 2]) &&
              (grid[1 * 3 + 1] != 0)) ||
          ((grid[0 * 3 + 2] == grid[1 * 3 + 1]) &&
              (grid[1 * 3 + 1] == grid[2 * 3 + 0]) &&
              (grid[1 * 3 + 1] != 0))) {
        isGameOver = true;
        return "$trn is the winner";
      }
      if (count == 3 || count2 == 3) {
        isGameOver = true;
        return "$trn is the winner";
      }
    }
    return "";
  }
}
