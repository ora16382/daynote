

enum MusicGenre {
  ballad('발라드'),
  rock('락/메탈'),
  jazz('재즈'),
  classical('클래식'),
  hiphop('힙합/랩'),
  rnb('R&B/소울'),
  indie('인디/어쿠스틱'),
  kpop('K-Pop'),
  world('월드뮤직'),
  lofi('로파이/힐링'),
  game('게임/OST'),
  ost('영화/드라마 OST');

  final String label;
  const MusicGenre(this.label);
}
