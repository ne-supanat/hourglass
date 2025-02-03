class TarotCard {
  final String name;
  final String url;

  TarotCard({required this.name, required this.url});

  factory TarotCard.fromJson(Map<String, dynamic> json) {
    return TarotCard(name: json['name'], url: json['url']);
  }
}
