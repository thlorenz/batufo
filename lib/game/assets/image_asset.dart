class ImageAsset {
  final String imagePath;
  final int width;
  final int height;
  final int cols;
  final int rows;

  ImageAsset(
    this.imagePath,
    this.width,
    this.height, {
    this.cols = 1,
    this.rows = 1,
  });
}
