enum Mood {
  happy('기뻐요', '😊'),
  sad('슬퍼요', '😢'),
  angry('화가나요', '😠'),
  tired('피곤해요', '😩'),
  calm('차분해요', '😌'),
  excited('신나요', '😆'),
  lonely('외로워요', '😔'),
  anxious('불안해요', '😟'),
  neutral('그냥 그래요', '😐');

  final String label;
  final String emoji;

  const Mood(this.label, this.emoji);
}
