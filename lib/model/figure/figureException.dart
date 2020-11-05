


enum FigureException {
  downMove,
  // If figure can't move down, it will have downMove exception
  rotate,
  // If figure can't rotate, it will have rotate exception
  sideMove,
  // If figure can't move left or right , it will have sideMove exception
  none,
}