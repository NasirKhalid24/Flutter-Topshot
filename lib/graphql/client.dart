import 'package:graphql/client.dart';

class Client extends GraphQLClient {
  static final _httpLink = HttpLink(
    'https://nbatopshot.com/marketplace/graphql?',
  );

  static final GraphQLClient client = GraphQLClient(
    cache: GraphQLCache(),
    link: _httpLink,
  );

  static Future<QueryResult> fetch(options) async {
    return await client.query(options);
  }
}
