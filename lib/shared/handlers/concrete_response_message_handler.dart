import 'package:alquilafacil/shared/handlers/response_message_handler.dart';

class ConcreteResponseMessageHandler extends ResponseMessageHandler {
  @override
  String reject(int statusCode) {
    String responseMessage;
    switch (statusCode) {
        case 400:
            responseMessage = "Bad Request: Please check the parameters.";
            break;
        case 401:
            responseMessage = "Unauthorized: User not authenticated. Please sign in or verify your token.";
            break;
        case 403:
            responseMessage = "Forbidden: You don't have permission to perform this action.";
            break;
        case 404:
            responseMessage = "Not Found: The requested resource could not be found.";
            break;
        case 408:
            responseMessage = "Request Timeout: The server timed out waiting for the request.";
            break;
        case 409:
            responseMessage = "Conflict: The request could not be processed due to a conflict.";
            break;
        case 410:
            responseMessage = "Gone: The requested resource is no longer available.";
            break;
        case 429:
            responseMessage = "Too Many Requests: You have sent too many requests in a given amount of time.";
            break;
        case 500:
            responseMessage = "Internal Server Error: Something went wrong on the server.";
            break;
        case 502:
            responseMessage = "Bad Gateway: The server received an invalid response from the upstream server.";
            break;
        case 503:
            responseMessage = "Service Unavailable: The server is not ready to handle the request.";
            break;
        case 504:
            responseMessage = "Gateway Timeout: The server did not receive a timely response from the upstream server.";
            break;
        default:
            responseMessage = "Unknown Error: An unexpected error occurred.";
    }
        return responseMessage;
    }

}