import 'package:graphql/client.dart';
import 'package:topshot_scan/graphql/client.dart';

class Codex_repo {
  final String _query = r'''
      query SearchTags($setsInput: SearchSetsInput!) {
        allPlayers {
          size
          data {
            id
            name
            
          }
          
        }
        allTeams {
          size
          data {
            id
            name
            
          }
          
        }
        searchSets(input: $setsInput) {
          searchSummary {
            data {
              ... on Sets {
                data {
                  id
                  ... on Set {
                    flowName
                    setVisualId
                    flowSeriesNumber
                    assetPath
                  }
                  
                }
                
              }
              
            }
            
          }
          
        }
      }
      ''';

  final Map<String, dynamic> _vars = {"setsInput": {}};

  Future<Map<String, dynamic>> dataFetch() async {
    final QueryOptions options = QueryOptions(
      document: gql(_query),
      variables: _vars,
    );

    var result;
    try {
      result = await Client.fetch(options);
    } catch (e) {
      result = {"data": null};
    }

    if (result.data == null) {
      return {"error": "maintenance"};
    } else {
      return result.data;
    }
  }
}
