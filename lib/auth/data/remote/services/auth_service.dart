abstract class AuthService {
   Future<Map<String,dynamic>> signIn(String email, String password);
   Future<String> signUp(String username, String password, String email, String name, String fatherName, String motherName, String dateOfBirth, String documentNumber, String phone);
}