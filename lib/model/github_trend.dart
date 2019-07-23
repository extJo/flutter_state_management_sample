class GithubTrendItem {
  final String author;
  final String name;
  final String avatar;
  final String url;
  final String description;
  final int stars;
  final int forks;
  final int currentPeriodStars;

  const GithubTrendItem({
    this.author,
    this.name,
    this.avatar,
    this.url,
    this.description,
    this.stars,
    this.forks,
    this.currentPeriodStars
  });

  factory GithubTrendItem.fromJson(Map<String, dynamic> json) {
    return GithubTrendItem(
      author: json['author'],
      name: json['name'],
      avatar: json['avatar'],
      url: json['url'],
      description: json['description'],
      stars: json['stars'],
      forks: json['forks'],
      currentPeriodStars: json['currentPeriodStars']
    );
  }
}