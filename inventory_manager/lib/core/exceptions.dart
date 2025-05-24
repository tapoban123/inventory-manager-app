class InsufficientResources implements Exception{
  final String message;
  
  InsufficientResources({this.message = "You do not have enough resources to complete this action."});
}