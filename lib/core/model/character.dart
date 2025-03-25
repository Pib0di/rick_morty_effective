import 'package:json_annotation/json_annotation.dart';

part 'character.g.dart';

@JsonSerializable()
class Characters {
  final Info? info;
  final List<Results>? results;

  const Characters({
    this.info,
    this.results,
  });

  factory Characters.fromJson(Map<String, dynamic> json) => _$CharactersFromJson(json);
  Map<String, dynamic> toJson() => _$CharactersToJson(this);
}

@JsonSerializable()
class Info {
  final int count;
  final int pages;
  final String? next;
  final String? prev;

  const Info({
    required this.count,
    required this.pages,
    this.next,
    this.prev,
  });

  factory Info.fromJson(Map<String, dynamic> json) => _$InfoFromJson(json);
  Map<String, dynamic> toJson() => _$InfoToJson(this);
}

@JsonSerializable()
class Results {
  final int? id;
  final String? name;
  final String? status;
  final String? species;
  final String? type;
  final String? gender;
  final Origin? origin;
  final Location? location;
  final String? image;
  final List<String>? episode;
  final String? url;
  final String? created;

  const Results({
    this.id,
    this.name,
    this.status,
    this.species,
    this.type,
    this.gender,
    this.origin,
    this.location,
    this.image,
    this.episode,
    this.url,
    this.created,
  });

  factory Results.fromJson(Map<String, dynamic> json) => _$ResultsFromJson(json);
  Map<String, dynamic> toJson() => _$ResultsToJson(this);
}

@JsonSerializable()
class Origin {
  final String? name;
  final String? url;

  const Origin({
    this.name,
    this.url,
  });

  factory Origin.fromJson(Map<String, dynamic> json) => _$OriginFromJson(json);
  Map<String, dynamic> toJson() => _$OriginToJson(this);
}

@JsonSerializable()
class Location {
  final String? name;
  final String? url;

  const Location({
    this.name,
    this.url,
  });

  factory Location.fromJson(Map<String, dynamic> json) => _$LocationFromJson(json);
  Map<String, dynamic> toJson() => _$LocationToJson(this);
}
