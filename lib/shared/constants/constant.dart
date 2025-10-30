class Constant {
   static const String BASE_URL = "https://alquilafacil-web-service-software.onrender.com/";
   static const String RESOURCE_PATH = "api/v1/";

   static String getEndpoint(String route, String? path){
      return BASE_URL + RESOURCE_PATH  + route + path!;
   }
}
