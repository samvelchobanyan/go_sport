class AppRoutes {
  static const String login = '/login';
  static const String profile = '/profile';
  static const String home = '/';
  static const String homeStory = '/story/:id';
  static const String homeNews = '/news';
  static const String homeNewsArticle = '/news/:id';

  static const String music = '/music';
  static const String musicArtist = '/music/artist/:id';
  static const String musicAlbum = '/music/album/:id';
  static const String musicPlaylist = '/music/playlist/:id';
  static const String musicProgram = '/music/program/:id';
  static const String musicMyFavorites = '/music/myfavorites';
  static const String musicMyPlaylists = '/music/myplaylists';
  static const String musicMyAlbums = '/music/myalbums';
  static const String musicMyArtists = '/music/myartists';
  static const String musicMyEpisodes = '/music/myepisodes';
  static const String musicMyPrograms = '/music/myprograms';

  static const String radio = '/radio';
  static const String radioSchedule = '/radio/schedule';

  // static const String login = '/login';
  static const String registrationEmail = '/registration-email';
  static const String registrationPhone = '/registration-phone';
  static const String registrationName = '/registration-name';
  static const String confirmEmail = '/confirm-email';
  static const String confirmPhone = '/confirm-phone';
  static const String createPassword = '/create-password';
  static const String expiredGuest = '/expired-guest';
  static const String checkEmail = '/check-email';
  static const String newPassword = '/new-password';
  static const String passwordChanged = '/password-changed';
  static const String restorePassword = '/restore-password';


  static const List<String> privateRoutes = [
    profile,
    musicMyFavorites,
    musicMyPlaylists,
    musicMyAlbums,
    musicMyArtists,
    musicMyEpisodes,
    musicMyPrograms,
  ];
}
