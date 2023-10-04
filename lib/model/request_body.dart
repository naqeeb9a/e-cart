class RequestBody {
  String? authToken;
  String? directory;
  Object? body;
  List? files;
  Map<String, dynamic>? parameters;

  RequestBody({
    this.authToken,
    this.directory,
    this.body,
    this.files,
    this.parameters,
  });
}
