class AuthException implements Exception {}

// Sign Up Exception
class EmailAlreadyInUse extends AuthException {}

class InvalidEmail extends AuthException  {}

class WeakPassword extends AuthException {}

//Login Exception
class WrongCredintials extends AuthException {}

class UserBlocked extends AuthException {}

// Generic Exception
class GenericAuthException extends AuthException {}

// user exceptions

class UserNotLoggedIn extends AuthException {}
