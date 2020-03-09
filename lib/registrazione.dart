class Registrazione {
  String titolo;
  String data;
  String luogo;
  String occasione;
  String momento;
  String mediaType;
  String url;

  Registrazione(
      {this.titolo,
      this.data,
      this.luogo,
      this.occasione,
      this.momento,
      this.mediaType,
      this.url});

  factory Registrazione.fromJson(Map<String, dynamic> parsedJson) {
    if (parsedJson == null) {
      throw FormatException("Null JSON provided to Registrazione");
    }

    return Registrazione(
        titolo: parsedJson['titolo'],
        data: parsedJson['data'],
        luogo: parsedJson['luogo'],
        occasione: parsedJson['occasione'],
        momento: parsedJson['momento'],
        mediaType: parsedJson['mediaType'],
        url: parsedJson['url']);
  }
}
