import 'package:aplicativo_furia/app/models/matchstatus.dart';

class Match {
  final String id;
  final String teamA;
  final String teamB;
  int scoreA;
  int scoreB;
  final String tournament;
  final DateTime startTime;
  MatchStatus status;

  Match({
    required this.id,
    required this.teamA,
    required this.teamB,
    required this.scoreA,
    required this.scoreB,
    required this.tournament,
    required this.startTime,
    required this.status,
  });

  factory Match.fromJson(Map<String, dynamic> json) {
    return Match(
      id: json['id'] as String,
      teamA: json['teamA'] as String,
      teamB: json['teamB'] as String,
      scoreA: json['scoreA'] as int,
      scoreB: json['scoreB'] as int,
      tournament: json['tournament'] as String,
      startTime: DateTime.parse(json['startTime']),
      status: MatchStatus.values.firstWhere(
        (e) => e.toString().split('.').last == json['status'],
        orElse: () => MatchStatus.upcoming,
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'teamA': teamA,
      'teamB': teamB,
      'scoreA': scoreA,
      'scoreB': scoreB,
      'tournament': tournament,
      'startTime': startTime.toIso8601String(),
      'status': status.name,
    };
  }
}
