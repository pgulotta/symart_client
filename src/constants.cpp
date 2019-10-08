#include "constants.hpp"
#include <QJsonArray>
#include <QDate>
#include <QDebug>

static QHash<QString, QString> mPoliceIncidentCategoryColors;
static QHash<QString, QString> mFireIncidentsStationColors;
static QHash<QString, QString> mCityEmployeesDepartmentColors;
static QHash<QString, QString> mBuildingPermitsTypeColors;
static QHash<QString, QString> mServiceRequestsCategoryColors;

const QString Constants::ApplicationCategoryTitle{"Application"  };

const QString Constants::CelluarAutomataTitle{"Celluar Automata" };

const QString Constants::CloudsTitle{"Clouds" };

const QString Constants::ClustersTitle{"Clusters"};

const QString Constants::HyperCloudsTitle{"Hyperbolic Clouds"};

const QString Constants::HyperLinesTitle{"Hyperbolic Lines"};

const QString Constants::LinesTitle{"Lines"};

const QString Constants::OrbitTrapTitle{"Orbit Trap"  };

const QString Constants::QuasiOrbitTrapsTitle{"Quasiperiodic Orbit Traps"};

const QString Constants::QuasiStripesTitle{"Quasiperiodic Stripes"};

const QString Constants::SquigglesTitle{"Squiggles"};

const QString Constants::StripesTitle{"Stripes"};

const QString Constants::WalkTitle{"Walk"};

const QString Constants::ApplicationUseDefaultDatesSettings{"useDefaultDates"   };

const QString Constants::ListSelectedDate{ "listSelectedDate"   };

const QString Constants::ListDuration{"listDuration"   };

const QString Constants::Address{"address"};

const QString Constants::AlwaysUseAddress{"alwaysUseAddress"};

const QString Constants::NotDefined{"(Not Specified)" };

const QString Constants::ComparisonDateFormat{ "yyyy-MM-dd" };

const QString Constants::ToolTipDateFormat{ "dd MMM yyyy hh:mm:ss ap" };

const QString Constants::ChartDateFormat{ "MMM dd, yyyy" };

const int Constants::TopChartItemsCount{5};

const int Constants::ChartDurationDefaultValue{7};

QString Constants::parseValue( const QJsonValue& jsonValue )
{
  QString value = jsonValue.toString();
  return ( value == "" || value == "NULL" ) ? Constants::NotDefined : value;
}

QString Constants::formatThruDates( const QDate& begDate, const QDate& endDate )
{
  return QString( "%1 through %2" )
         .arg( begDate.toString( Constants::ChartDateFormat ),
               endDate.toString( Constants::ChartDateFormat ) );
}

QString Constants::getPoliceIncidentCategoryColor( const QString& category )
{
  if ( mPoliceIncidentCategoryColors.contains( category ) ) {
    return mPoliceIncidentCategoryColors[category];
  }

  qDebug() << Q_FUNC_INFO << "missing " << category;
  return "DIMGRAY";
}
QString Constants::getFireIncidentsStationColor( const QString& station )
{
  if ( mFireIncidentsStationColors.contains( station ) ) {
    return mFireIncidentsStationColors[station];
  }

  qDebug() << Q_FUNC_INFO << "missing " << station;
  return "DIMGRAY";
}

QString Constants::getCityEmployeesDepartmentColor( const QString& department )
{
  if ( mCityEmployeesDepartmentColors.contains( department ) ) {
    return mCityEmployeesDepartmentColors[department];
  }

  //qDebug() << Q_FUNC_INFO << "missing " << department ;
  return "DIMGRAY";
}

QString Constants::getBuildingPermitsTypeColor( const QString& permitType )
{
  if ( mBuildingPermitsTypeColors.contains( permitType ) ) {
    return mBuildingPermitsTypeColors[permitType];
  }

  //qDebug() << Q_FUNC_INFO << "missing " << permitType ;
  return "DIMGRAY";
}

QString Constants::getServiceRequestsCategoryColor( const QString& code )
{
  if ( mServiceRequestsCategoryColors.contains( code ) ) {
    return mServiceRequestsCategoryColors[code];
  }

  qDebug() << Q_FUNC_INFO << "missing " << code;
  return "DIMGRAY";
}

QString Constants::formatGeoLocation( qreal x, qreal y )
{
  return QString( "%1,%2" ).arg( x ).arg( y );
}

void Constants::populatePoliceIncidentCategoryColors()
{
  if ( mPoliceIncidentCategoryColors.count() == 0 ) {
    mPoliceIncidentCategoryColors["ABANDONED VEHICLE"] = "brown";
    mPoliceIncidentCategoryColors["ANIMAL"] = "mediumspringgreen";
    mPoliceIncidentCategoryColors["ASSAULT"] = "slateblue";
    mPoliceIncidentCategoryColors["BATTERY"] = "coral";
    mPoliceIncidentCategoryColors["BURGLARY FROM MOBILE VEHICLE"] = "burlywood";
    mPoliceIncidentCategoryColors["BURGLARY"] = "ROYALBLUE";
    mPoliceIncidentCategoryColors["CANNABIS CONTROL ACT"] = "teal";
    mPoliceIncidentCategoryColors["CRIMINAL DAMAGE AND TRESPASS"] = "palevioletred";
    mPoliceIncidentCategoryColors["CRIMINAL SEXUAL ASSAULT"] = "darkslateblue";
    mPoliceIncidentCategoryColors["DECEPTION"] = "darkmagenta";
    mPoliceIncidentCategoryColors["DEADLY WEAPONS"] = "greenyellow";
    mPoliceIncidentCategoryColors["DEPARTAMENTAL SERVICES"] = "deepskyblue";
    mPoliceIncidentCategoryColors["DISORDERLY CONDUCT"] = "indigo";
    mPoliceIncidentCategoryColors["DRUG PARAPHERNALIA"] = "gray";
    mPoliceIncidentCategoryColors["INFORMATION FOR POLICE"] = "mediumblue";
    mPoliceIncidentCategoryColors["INTERFERING WITH PUBLIC OFFICERS"] = "goldenrod";
    mPoliceIncidentCategoryColors["INVESTIGATION - NON SPECIFIC"] = "lightcyan";
    mPoliceIncidentCategoryColors["LIQUOR CONTROL ACT"] = "plum";
    mPoliceIncidentCategoryColors["LOST FOUND MISSING"] = "darkturquoise";
    mPoliceIncidentCategoryColors["MENTAL HEALTH"] = "peru";
    mPoliceIncidentCategoryColors["MOTOR VEHICLE THEFT"] = "mediumslateblue";
    mPoliceIncidentCategoryColors["MOTOR VEHICLE"] = "dimgrey";
    mPoliceIncidentCategoryColors["NULL"] = "orange";
    mPoliceIncidentCategoryColors["OFFENSES INVOLVING CHILDREN"] = "tomato";
    mPoliceIncidentCategoryColors["OTHER OFFENSES"] = "skyblue";
    mPoliceIncidentCategoryColors["ROBBERY"] = "darkgoldenrod";
    mPoliceIncidentCategoryColors["SEX OFFENSES"] = "olivedrab";
    mPoliceIncidentCategoryColors["SERVICE OTHER AGENCY ASSISTANCE"] = "violet";
    mPoliceIncidentCategoryColors["THEFT"] = "beige";
    mPoliceIncidentCategoryColors["TRAFFIC CRASHES"] = "firebrick";
    mPoliceIncidentCategoryColors["TRAFFIC"] = "dodgerblue";
    mPoliceIncidentCategoryColors["(Not Specified)"] = "powderblue";
  }
}

void Constants::populateFireIncidentsStationColors()
{
  if ( mFireIncidentsStationColors.count() == 0 ) {
    mFireIncidentsStationColors["001"] = "brown";
    mFireIncidentsStationColors["002"] = "mediumspringgreen";
    mFireIncidentsStationColors["003"] = "slateblue";
    mFireIncidentsStationColors["004"] = "coral";
    mFireIncidentsStationColors["005"] = "burlywood";
    mFireIncidentsStationColors["006"] = "ROYALBLUE";
    mFireIncidentsStationColors["007"] = "teal";
    mFireIncidentsStationColors["008"] = "plum";
    mFireIncidentsStationColors["009"] = "darkslateblue";
    mFireIncidentsStationColors["010"] = "darkmagenta";
    mFireIncidentsStationColors["011"] = "greenyellow";
    mFireIncidentsStationColors["012"] = "deepskyblue";
    mFireIncidentsStationColors["013"] = "indigo";
    mFireIncidentsStationColors["014"] = "gray";
    mFireIncidentsStationColors["015"] = "mediumblue";
    mFireIncidentsStationColors["016"] = "goldenrod";
    mFireIncidentsStationColors["017"] = "lightcyan";
    mFireIncidentsStationColors["018"] = "palevioletred";
    mFireIncidentsStationColors["019"] = "darkturquoise";
  }
}

void Constants::populateCityEmployeesDepartmentColors()
{
  if ( mCityEmployeesDepartmentColors.count() == 0 ) {
    mCityEmployeesDepartmentColors["DPW"] = "brown";
    mCityEmployeesDepartmentColors["DPU-W"] = "mediumspringgreen";
    mCityEmployeesDepartmentColors["Finance"] = "slateblue";
    mCityEmployeesDepartmentColors["Police Dept."] = "coral";
    mCityEmployeesDepartmentColors["T.E.D."] = "burlywood";
    mCityEmployeesDepartmentColors["CMO"] = "ROYALBLUE";
    mCityEmployeesDepartmentColors["City Clerk"] = "teal";
    mCityEmployeesDepartmentColors["DPU-E"] = "palevioletred";
    mCityEmployeesDepartmentColors["Fire Dept."] = "darkslateblue";
    mCityEmployeesDepartmentColors["IT"] = "darkmagenta";
    mCityEmployeesDepartmentColors["Human Resource"] = "greenyellow";
    mCityEmployeesDepartmentColors["Legal"] = "deepskyblue";
    mCityEmployeesDepartmentColors["Fire/Police Commission"] = "indigo";
    mCityEmployeesDepartmentColors["Mayor & Council"] = "gray";
  }
}

void Constants::populateBuildingPermitsTypeColors()
{
  if ( mBuildingPermitsTypeColors.count() == 0 ) {
    mBuildingPermitsTypeColors["COMMERCIAL - CAD"] = "green";
    mBuildingPermitsTypeColors["COMMERCIAL COOKING SYSTEM"] = "brown";
    mBuildingPermitsTypeColors["TD  RIGHT OF WAY PERMIT"] = "mediumspringgreen";
    mBuildingPermitsTypeColors["ELECTRIC SERVICE CHANGE COMM"] = "slateblue";
    mBuildingPermitsTypeColors["ROOM ALTERATION"] = "CRIMSON";
    mBuildingPermitsTypeColors["ANNUAL MAINTENANCE PERMIT"] = "coral";
    mBuildingPermitsTypeColors["TEMPORARY SIGN"] = "burlywood";
    mBuildingPermitsTypeColors["ROOM ADDITION"] = "ROYALBLUE";
    mBuildingPermitsTypeColors["MISCELLANEOUS PERMIT"] = "teal";
    mBuildingPermitsTypeColors["ELECTRIC SERVICE CHANGE COMM"] = "palevioletred";
    mBuildingPermitsTypeColors["SITE DEVELOPMENT"] = "darkslateblue";
    mBuildingPermitsTypeColors["OCC INSPECT. PERMIT COM/RST"] = "darkmagenta";
    mBuildingPermitsTypeColors["ELECTRIC SVC CHANGE RES."] = "greenyellow";
    mBuildingPermitsTypeColors["RIGHT OF WAY PERMIT"] = "SILVER";
    mBuildingPermitsTypeColors["FENCE"] = "indigo";
    mBuildingPermitsTypeColors["SEWER/WATER REPAIR OR REPLACE"] = "gray";
    mBuildingPermitsTypeColors["DECK COMMERCIAL - CCAD"] = "mediumblue";
    mBuildingPermitsTypeColors["COMMERCIAL MISC. PERMIT"] = "goldenrod";
    mBuildingPermitsTypeColors["POOL IN GROUND"] = "lightcyan";
    mBuildingPermitsTypeColors["SIGN"] = "plum";
    mBuildingPermitsTypeColors["SATELLITE DISH/ANT COMMERCIAL"] = "darkturquoise";
    mBuildingPermitsTypeColors["SPA/HOT TUB"] = "peru";
    mBuildingPermitsTypeColors["FIRE ALARM"] = "mediumslateblue";
    mBuildingPermitsTypeColors["DEMOLITION PERMIT"] = "dimgrey";
    mBuildingPermitsTypeColors["SATELLITE DISH/ANT COMMERCIAL"] = "orange";
    mBuildingPermitsTypeColors["GARAGE PERMIT SFR"] = "olivedrab";
    mBuildingPermitsTypeColors["FIRE SPRINKLER PERMIT"] = "skyblue";
    mBuildingPermitsTypeColors["ELECTRIC FOR SINGLE FAMILY/DPX"] = "darkgoldenrod";
    mBuildingPermitsTypeColors["PLUMBING BASEMENT ROUGH"] = "tomato";
    mBuildingPermitsTypeColors["COMMERCIAL MISC. PERMIT"] = "violet";
    mBuildingPermitsTypeColors["SINGLE FAMILY RESIDENCE PERMIT"] = "seagreen";
    mBuildingPermitsTypeColors["FIREPLACE PREFAB"] = "firebrick";
    mBuildingPermitsTypeColors["STRUCTURAL FOR SINGLE FAM/DPX"] = "dodgerblue";
    mBuildingPermitsTypeColors["DECK WITH STRUCTURE - SFR/DPX"] = "powderblue";
    mBuildingPermitsTypeColors["DECK"] = "blue";
    mBuildingPermitsTypeColors["FINISHED BASEMENT"] = "red";
    mBuildingPermitsTypeColors["PLUMBING FOR SINGLE FAMILY/DPX"] = "DARKCYAN";
    mBuildingPermitsTypeColors["PATIO WITH STRUCTURE"] = "CADETBLUE";
    mBuildingPermitsTypeColors["FINISHED BASEMENT"] = "MEDIUMAQUAMARINE";
    mBuildingPermitsTypeColors["PARKWAY TREE PLANTING PERMIT"] = "ROSYBROWN";
    mBuildingPermitsTypeColors["MECHANICAL FOR SFR/DPX"] = "CHOCOLATE";
    mBuildingPermitsTypeColors["TD  ROW1 PERMIT"] = "deepskyblue";
    mBuildingPermitsTypeColors["GAZEBO / PAVILION PERMIT"] = "MIDNIGHTBLUE";
    mBuildingPermitsTypeColors["SHELL ONLY PERMIT"] = "DARKSEAGREEN";
    mBuildingPermitsTypeColors["WATER METER UPGRADE"] = "NAVAJOWHITE";
    mBuildingPermitsTypeColors["TEMPORARY TRAILER"] = "STEELBLUE";
    mBuildingPermitsTypeColors["ELECTRIC MISC"] = "DARKORCHID";
    mBuildingPermitsTypeColors["SOLAR PHOTOVOLTAIC"] = "DARKORANGE";
    mBuildingPermitsTypeColors["TOWNHOUSE PERMIT"] = "MEDIUMTURQUOISE";
    mBuildingPermitsTypeColors["LAWN SPRINKLER PERMIT"] = "ROYALBLUE";
    mBuildingPermitsTypeColors["FIRE DAMAGE REPAIR"] = "MISTYROSE";
    mBuildingPermitsTypeColors["DUPLEX PERMIT"] = "SALMON";
    mBuildingPermitsTypeColors["PATIO"] = "purple";
    mBuildingPermitsTypeColors["COMMERCIAL FULL PERMIT"] = "AQUA";
    mBuildingPermitsTypeColors["DEMOLITION COMMERCIAL INTERIOR"] = "DARKGREEN";
    mBuildingPermitsTypeColors["FIRE PROTECTION CLEAN AGENT"] = "DARKKHAKI";
    mBuildingPermitsTypeColors["DRIVEWAY ADDITION/ALTERATION"] = "MOCCASIN";
    mBuildingPermitsTypeColors["FIREPLACE PERMIT MASONRY"] = "THISTLE";
    mBuildingPermitsTypeColors["ELEVATOR PERMIT"] = "MEDIUMORCHID";
    mBuildingPermitsTypeColors["SEWER AND/OR WATER CONN PERMIT"] = "LIGHTGREEN";
    mBuildingPermitsTypeColors["ELECTRIC VEHICLE STATION COMM"] = "DARKOLIVEGREEN";
    mBuildingPermitsTypeColors["ELECTRIC LOW VOLTAGE"] = "TURQUOISE";
    mBuildingPermitsTypeColors["ROOM ADDITION LARGE"] = "WHEAT";
    mBuildingPermitsTypeColors["15 DAY STOCK & TRAINING"] = "LAVENDERBLUSH";
    mBuildingPermitsTypeColors["FOUND. ONLY THA/APT/CONDO/U"] = "lightblue";
    mBuildingPermitsTypeColors["HOUSE METER-ELECTRIC"] = "khaki";
    mBuildingPermitsTypeColors["ELECTRIC VEHICLE STATION RES"] = "hotpink";
    mBuildingPermitsTypeColors["TENT PERMIT"] = "gold";
    mBuildingPermitsTypeColors["FOUNDATION ONLY COMM NEW/NU"] = "beige";
    mBuildingPermitsTypeColors["DONATION BOX"] = "bisque";
    mBuildingPermitsTypeColors["PORCH PERMI"] = "aquamarine";
    mBuildingPermitsTypeColors["FOWL AND LIVESTOCK ENCLOSURE"] = "antiquewhite";
  }
}

void Constants::populateServiceRequestsCategoryColors()
{
  mServiceRequestsCategoryColors["PUBLIC WORKS"] = "darkgreen";
  mServiceRequestsCategoryColors["TRANSPORTATION ENGINEERING AND DEVELOPMENT"] = "slateblue";
  mServiceRequestsCategoryColors["ELECTRIC"] = "indigo";
  mServiceRequestsCategoryColors["WATER DISTRIBUTION AND COLLECTION"] = "mediumblue";
  mServiceRequestsCategoryColors["MTRSVY"] = "darkgoldenrod";
  mServiceRequestsCategoryColors["PBO"] = "dodgerblue";
  mServiceRequestsCategoryColors["CIV ENV ENGINEERING AND CONSTRUCTION"] = "red";
}
