import 'package:graphql/client.dart';
import 'package:topshot_scan/graphql/client.dart';

class Users_repo {
  final String _query = r'''
      query ProfilePage_getUserProfileByUsername($input: getUserProfileByUsernameInput!) {
        getUserProfileByUsername(input: $input) {
          publicInfo {
            ...UserFragment
            
          }
          momentCount
          
        }
      }

      fragment UserFragment on UserPublicInfo {
        dapperID
        username
        profileImageUrl
        twitterHandle
        createdAt
        flowAddress
        favoriteTeamID
      }
      ''';

  Future<Map<String, dynamic>> dataFetch(username) async {
    if (username != "") {
      final QueryOptions options = QueryOptions(
        document: gql(_query),
        variables: {
          "input": {"username": username}
        },
      );

      var result;
      try {
        result = await Client.fetch(options);
      } catch (e) {
        result = {"data": null};
      }

      if (result.data == null) {
        return {};
      } else {
        return result.data["getUserProfileByUsername"]?["publicInfo"];
      }
    } else {
      return {};
    }
  }
}
