class GithubTrendItem {
  final String repo;
  final String desc;
  final List<String> avatars;
  final String link;
  final String description;
  final String stars;
  final String forks;
  final String addedStars;

  const GithubTrendItem(
      {this.repo,
      this.desc,
      this.avatars,
      this.link,
      this.description,
      this.stars,
      this.forks,
      this.addedStars});

  factory GithubTrendItem.fromJson(Map<String, dynamic> json) {
    List<String> avatars = json['avatars']?.cast<String>();
    return GithubTrendItem(
        repo: json['repo'],
        desc: json['desc'],
        avatars: avatars,
        link: json['link'],
        description: json['description'],
        stars: json['stars'],
        forks: json['forks'],
        addedStars: json['added_stars']);
  }
}
