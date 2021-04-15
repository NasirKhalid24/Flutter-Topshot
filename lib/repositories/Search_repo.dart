import 'package:graphql/client.dart';
import 'package:topshot_scan/graphql/client.dart';
import 'package:topshot_scan/models/SearchQuery.dart';

class Search_repo {
  final String _query = r'''
      query SearchMomentListingsDefault($byPlayers: [ID], $byTagNames: [String!], $byTeams: [ID], $byPrice: PriceRangeFilterInput, $orderBy: MomentListingSortType, $byGameDate: DateRangeFilterInput, $byCreatedAt: DateRangeFilterInput, $byListingType: [MomentListingType], $bySets: [ID], $bySeries: [ID], $bySetVisuals: [VisualIdType], $byPrimaryPlayerPosition: [PlayerPosition], $bySerialNumber: IntegerRangeFilterInput, $searchInput: BaseSearchInput!, $userDapperID: ID) {
        searchMomentListings(input: {filters: {byPlayers: $byPlayers, byTagNames: $byTagNames, byGameDate: $byGameDate, byCreatedAt: $byCreatedAt, byTeams: $byTeams, byPrice: $byPrice, byListingType: $byListingType, byPrimaryPlayerPosition: $byPrimaryPlayerPosition, bySets: $bySets, bySeries: $bySeries, bySetVisuals: $bySetVisuals, bySerialNumber: $bySerialNumber}, sortBy: $orderBy, searchInput: $searchInput, userDapperID: $userDapperID}) {
          data {
            filters {
              byPlayers
              byTagNames
              byTeams
              byPrimaryPlayerPosition
              byGameDate {
                start
                end
                
              }
              byCreatedAt {
                start
                end
                
              }
              byPrice {
                min
                max
                
              }
              bySerialNumber {
                min
                max
                
              }
              bySets
              bySeries
              bySetVisuals
              
            }
            searchSummary {
              count {
                count
                
              }
              pagination {
                leftCursor
                rightCursor
                
              }
              data {
                ... on MomentListings {
                  size
                  data {
                    ... on MomentListing {
                      id
                      version
                      circulationCount
                      flowRetired
                      set {
                        id
                        flowName
                        setVisualId
                        flowSeriesNumber
                        
                      }
                      play {
                        description
                        id
                        stats {
                          playerName
                          dateOfMoment
                          playCategory
                          teamAtMomentNbaId
                          teamAtMoment
                          
                        }
                        
                      }
                      assetPathPrefix
                      priceRange {
                        min
                        max
                        
                      }
                      momentListingCount
                      listingType
                      userOwnedSetPlayCount
                      
                    }
                    
                  }
                  
                }
                
              }
              
            }
            
          }
          
        }
      }
      ''';

  Future<Map<String, dynamic>> dataFetch(SearchQuery params) async {
    QueryOptions options = QueryOptions(
        document: gql(_query), variables: params.toMap(), optimisticResult: {});

    var result;
    try {
      result = await Client.fetch(options);
    } catch (e) {
      result = {"data": null};
    }

    if (result.data == null) {
      return {"error": "maintenance"};
    } else {
      return result.data["searchMomentListings"]["data"]["searchSummary"];
    }
  }
}
