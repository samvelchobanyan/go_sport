class AppRoutes {
  static const String login = '/login';

  // Profile screens
  static const String profile = '/profile';
  static const String profileForBusiness = '/for-business';
  static const String editProfile = '/edit-profile';
  static const String profileChangePassword =
      '/change-password'; //profile change password
  static const String confirmDeleteAccount = '/confirm-delete'; 
  static const String deleteAccount = '/delete-account';
  static const String deleteSuccess = '/delete-success';
  static const String notifications = '/notifications';

  // Home screen
  static const String home = '/';
  static const String homeStory = '/story/:id';
  static const String homeNews = '/news';
  static const String homeNewsArticle = '/news/:id';

  // Music screens
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

  // Radio screens
  static const String radio = '/radio';
  static const String radioSchedule = '/radio/schedule';

  // Login and registration flows
  static const String registrationEmail = '/registration-email';
  static const String registrationPhone = '/registration-phone';
  static const String registrationName = '/registration-name';
  static const String confirmEmail = '/confirm-email';
  static const String confirmPhone = '/confirm-phone';
  static const String createPassword = '/create-password';
  static const String expiredGuest = '/expired-guest';
  static const String checkEmail = '/check-email';
  static const String changePassword = '/change-password';
  static const String forgotPassword = '/forgot-password';
  static const String confirmChangePassword = '/confirm-password-change';

  static const List<String> privateRoutes = [
    profile,
    editProfile,
    profileChangePassword,
    profileForBusiness,
    musicMyFavorites,
    musicMyPlaylists,
    musicMyAlbums,
    musicMyArtists,
    musicMyEpisodes,
    musicMyPrograms,
  ];
}
