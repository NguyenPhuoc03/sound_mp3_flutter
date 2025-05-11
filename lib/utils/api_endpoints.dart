class ApiEndpoints {
  static const String login = '/auth/login';
  static const String register = '/auth/register';

  //song
  static const String getAllSong = '/song/get-all';
  static String getSongsByArtist(String artistId) => '/artist/$artistId/songs';
  static String getSongsByAlbum(String albumId) => '/album/$albumId/songs';

  // artist
  static const String getAllArtist = '/artist/get-all';

  //album
  static const String getAllAlbum = '/album/get-all';

  //user
  static const String profile = '/user/profile';

  //history
  static const String getAllHistory = '/history/get-all';
}
