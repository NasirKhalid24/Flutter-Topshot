import 'package:topshot_scan/models/Pagination.dart';
import 'package:topshot_scan/models/byCreatedAt.dart';
import 'package:topshot_scan/models/byGameDate.dart';
import 'package:topshot_scan/models/byPower.dart';
import 'package:topshot_scan/models/byPrice.dart';

import 'bySerialNumber.dart';

class SearchQuery {
  SearchQuery(
      {this.price,
      this.power,
      this.serialnumber,
      this.gamedate,
      this.createat,
      this.playerpositions,
      this.sets,
      this.series,
      this.setvisuals,
      this.playstyle,
      this.skill,
      this.players,
      this.tagnames,
      this.playtagids,
      this.setplaytagids,
      this.teams,
      this.listingtypes,
      this.orderby,
      this.searchinput});

  byPrice? price;
  byPower? power;
  bySerialNumber? serialnumber;
  byGameDate? gamedate;
  byCreatedAt? createat;
  List<String>? playerpositions;
  List<String>? sets;
  List<String>? series;
  List<String>? setvisuals;
  List<String>? playstyle;
  List<String>? skill;
  List<String>? players;
  List<String>? tagnames;
  List<String>? playtagids;
  List<String>? setplaytagids;
  List<String>? teams;
  List<String>? listingtypes;
  String? orderby;
  Pagination? searchinput;

  factory SearchQuery.fromMap(Map<String, dynamic> json) => SearchQuery(
      price: json["byPrice"] == null
          ? byPrice()
          : byPrice.fromMap(json["byPrice"]),
      power: json["byPower"] == null
          ? byPower()
          : byPower.fromMap(json["byPower"]),
      serialnumber: json["bySerialNumber"] == null
          ? bySerialNumber()
          : bySerialNumber.fromMap(json["bySerialNumber"]),
      gamedate: json["byGameDate"] == null
          ? byGameDate()
          : byGameDate.fromMap(json["byGameDate"]),
      createat: json["byCreatedAt"] == null
          ? byCreatedAt()
          : byCreatedAt.fromMap(json["byCreatedAt"]),
      playerpositions: json["byPrimaryPlayerPosition"] == null
          ? []
          : json["byPrimaryPlayerPosition"],
      sets: json["bySets"] == null ? [] : json["bySets"],
      setvisuals: json["bySetVisuals"] == null ? [] : json["bySetVisuals"],
      playstyle: json["byPlayStyle"] == null ? [] : json["byPlayStyle"],
      skill: json["bySkill"] == null ? [] : json["bySkill"],
      players: json["byPlayers"] == null ? [] : json["byPlayers"],
      tagnames: json["byTagNames"] == null ? [] : json["byTagNames"],
      playtagids: json["byPlayTagIDs"] == null ? [] : json["byPlayTagIDs"],
      setplaytagids:
          json["bySetPlayTagIDs"] == null ? [] : json["bySetPlayTagIDs"],
      teams: json["byTeams"] == null ? [] : json["byTeams"],
      listingtypes: json["byListingType"] == null ? [] : json["byListingType"],
      orderby: json["orderBy"] == null ? null : json["orderBy"],
      searchinput: json["searchInput"] == null
          ? Pagination()
          : Pagination.fromMap(json["searchInput"]));

  Map<String, dynamic> toMap() => {
        "byPrice": price?.toMap(),
        "byPower": power?.toMap(),
        "bySerialNumber": serialnumber?.toMap(),
        "byGameDate": gamedate?.toMap(),
        "byCreatedAt": createat?.toMap(),
        "byPrimaryPlayerPosition": playerpositions,
        "bySets": sets,
        "bySeries": series,
        "bySetVisuals": setvisuals,
        "byPlayStyle": playstyle,
        "byPlayTagIDs": playtagids,
        "bySetPlayTagIDs": setplaytagids,
        "bySkill": skill,
        "byPlayers": players,
        "byTagNames": tagnames,
        "byTeams": teams,
        "byListingType": listingtypes,
        "searchInput": {"pagination": searchinput?.toMap()},
        "orderBy": orderby
      };

  @override
  String toString() {
    return """
    SearchQuery(
         byPrice: ${price?.toMap()},
         byPower: ${power?.toMap()},
         bySerialNumber: ${serialnumber?.toMap()},
         byGameDate: ${gamedate?.toMap()},
         byCreatedAt: ${createat?.toMap()},
         byPrimaryPlayerPosition: ${playerpositions},
         bySets: ${sets},
         bySeries: ${series},
         bySetVisuals: ${setvisuals},
         byPlayStyle: ${playstyle},
         bySkill: ${skill},
         byPlayers: ${players},
         byTagNames: ${tagnames},
         byTeams: ${teams},
         byListingType: ${listingtypes},
         searchInput: ${{"pagination": searchinput?.toMap()}}},
         orderBy: ${orderby}
      )';
    """;
  }
}
