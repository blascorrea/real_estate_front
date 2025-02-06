abstract class ResponseBase {
  ResponseBase(this.error, this.message);
  bool error;
  String message;
}

class ResponseSucces extends ResponseBase {
  ResponseSucces(String message) : super(false, message);
}

class ResponseFailure extends ResponseBase {
  ResponseFailure(String message) : super(true, message);
}
