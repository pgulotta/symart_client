#pragma once

#include <QObject>
#include <QString>
#include <QHash>

class QDate;


class Constants final  : public QObject
{
public:
  static const QString ApplicationCategoryTitle;
  static const QString CelluarAutomataTitle;
  static const QString CloudsTitle;
  static const QString ClustersTitle;
  static const QString HyperCloudsTitle;
  static const QString HyperLinesTitle;
  static const QString LinesTitle;
  static const QString OrbitTrapTitle;
  static const QString QuasiOrbitTrapsTitle;
  static const QString QuasiStripesTitle;
  static const QString SquigglesTitle;
  static const QString StripesTitle;
  static const QString WalkTitle;
  static const QString ApplicationUseDefaultDatesSettings;
  static const QString ListSelectedDate;
  static const QString ListDuration;
  static const QString Address;
  static const QString AlwaysUseAddress;
  static const QString NotDefined;
  static const QString ComparisonDateFormat;
  static const QString ToolTipDateFormat;
  static const QString ChartDateFormat;
  static const int TopChartItemsCount;
  static const int ChartDurationDefaultValue;

  static QString parseValue( const QJsonValue& jsonValue );
  static QString formatThruDates( const QDate& begDate, const QDate& endDate );
  static void populatePoliceIncidentCategoryColors();
  static void populateFireIncidentsStationColors();
  static void populateCityEmployeesDepartmentColors();
  static void populateBuildingPermitsTypeColors();
  static void populateServiceRequestsCategoryColors();

  static QString getPoliceIncidentCategoryColor( const QString& category ) ;
  static QString getFireIncidentsStationColor( const QString& station ) ;
  static QString getCityEmployeesDepartmentColor( const QString& department ) ;
  static QString getBuildingPermitsTypeColor( const QString& permitType ) ;
  static QString getServiceRequestsCategoryColor( const QString& category ) ;

  static QString formatGeoLocation(  qreal x, qreal y ) ;
};




