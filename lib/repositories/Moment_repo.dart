import 'package:graphql/client.dart';
import 'package:topshot_scan/graphql/client.dart';

class Moment_repo {
  final String _query = r'''
      query GetUserMomentListingsDedicated($input: GetUserMomentListingsInput!) {
        getUserMomentListings(input: $input) {
          data {
            circulationCount
            flowRetired
            version
            set {
              id
              flowName
              flowSeriesNumber
              
            }
            play {
              ... on Play {
                ...PlayDetails
                
              }
              
            }
            setPlay {
              ID
              circulationCount
              flowRetired
              tags {
                ...TagsFragment
                
              }
              
            }
            assetPathPrefix
            priceRange {
              min
              max
              
            }
            momentListings {
              id
              moment {
                id
                price
                flowSerialNumber
                owner {
                  dapperID
                  username
                  profileImageUrl
                  
                }
                setPlay {
                  ID
                  flowRetired
                  
                }
                
              }
              
            }
            momentListingCount
            
          }
          
        }
      }

      fragment PlayDetails on Play {
        id
        description
        tags {
          ...TagsFragment
          
        }
        stats {
          playerID
          playerName
          primaryPosition
          currentTeamId
          dateOfMoment
          jerseyNumber
          awayTeamName
          awayTeamScore
          teamAtMoment
          homeTeamName
          homeTeamScore
          totalYearsExperience
          teamAtMomentNbaId
          height
          weight
          currentTeam
          birthplace
          birthdate
          awayTeamNbaId
          draftYear
          nbaSeason
          draftRound
          draftSelection
          homeTeamNbaId
          draftTeam
          draftTeamNbaId
          playCategory
          homeTeamScoresByQuarter {
            quarterScores {
              type
              number
              sequence
              points
              
            }
            
          }
          awayTeamScoresByQuarter {
            quarterScores {
              type
              number
              sequence
              points
              
            }
            
          }
          
        }
        statsPlayerGameScores {
          blocks
          points
          steals
          assists
          minutes
          rebounds
          turnovers
          plusMinus
          flagrantFouls
          personalFouls
          playerPosition
          technicalFouls
          twoPointsMade
          blockedAttempts
          fieldGoalsMade
          freeThrowsMade
          threePointsMade
          defensiveRebounds
          offensiveRebounds
          pointsOffTurnovers
          twoPointsAttempted
          assistTurnoverRatio
          fieldGoalsAttempted
          freeThrowsAttempted
          twoPointsPercentage
          fieldGoalsPercentage
          freeThrowsPercentage
          threePointsAttempted
          threePointsPercentage
          
        }
        statsPlayerSeasonAverageScores {
          minutes
          blocks
          points
          steals
          assists
          rebounds
          turnovers
          plusMinus
          flagrantFouls
          personalFouls
          technicalFouls
          twoPointsMade
          blockedAttempts
          fieldGoalsMade
          freeThrowsMade
          threePointsMade
          defensiveRebounds
          offensiveRebounds
          pointsOffTurnovers
          twoPointsAttempted
          assistTurnoverRatio
          fieldGoalsAttempted
          freeThrowsAttempted
          twoPointsPercentage
          fieldGoalsPercentage
          freeThrowsPercentage
          threePointsAttempted
          threePointsPercentage
          
        }
        
      }

      fragment TagsFragment on Tag {
        id
        title
        visible
        level
        
      }
      ''';

  Future<Map<String, dynamic>> dataFetch(setID, playID) async {
    final QueryOptions options =
        QueryOptions(document: gql(_query), variables: {
      "input": {"setID": setID, "playID": playID}
    });

    var result;
    try {
      result = await Client.fetch(options);
    } catch (e) {
      result = {"data": null};
    }

    if (result.data == null) {
      return {};
    } else {
      return result.data["getUserMomentListings"]["data"];
    }
  }
}
