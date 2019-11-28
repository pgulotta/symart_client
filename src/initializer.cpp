#include "initializer.hpp"
#include "topicmetadata.hpp"
#include <QGuiApplication>
#include <QQmlContext>
#include <QQmlApplicationEngine>
#include <QSettings>
#include <QVariant>


const QString ApplicationCategoryTitle{"Application"  };

Initializer::Initializer( QObject* parent )
  : QObject{parent}
{
// initSettings();
  initQml();
}

void Initializer::initQml()
{
  qmlRegisterSingletonType( QUrl( QStringLiteral( "qrc:/view/qml/SharedConstants.qml" ) ),
                            "com.twentysixapps.constants", 1, 0, "Constants" );


  qmlRegisterType<TopicMetaData>( "TopicMetaDataModel", 1, 0, "TopicMetaData" );
  QQmlContext* context = mQmlApplicationEngine.rootContext();
  context->setContextProperty( "ImmutableList", &mImmutableList );
  context->setContextProperty( "Controller", &mFrontController );
  context->setContextProperty( "TopicsMetaData", QVariant::fromValue( mTopicsMetaDataBuilder.topicsMetaData() ) );

  mQmlApplicationEngine.load( QUrl( QStringLiteral( "qrc:/view/qml/MainPage.qml" ) ) );
//  mQmlApplicationEngine.load( QUrl( QStringLiteral( "qrc:/view/qml/main.qml" ) ) );

}
/*
void Initializer::initSettings()
{

//On linux, file is stored at:  /home/pat/.config/26Apps/Naperville Matters.conf
QSettings settings;
//qDebug() << "Settings file name =" << settings.fileName();
settings.beginGroup( Constants::ApplicationCategoryTitle );

if ( !settings.contains( Constants::ApplicationUseDefaultDatesSettings ) ) {
settings.setValue( Constants::ApplicationUseDefaultDatesSettings, "false" );
}

bool applicationUseDefaultDatesSettings
= settings.value( Constants::ApplicationUseDefaultDatesSettings ).toBool();
settings.endGroup();

if ( applicationUseDefaultDatesSettings ) {
const QDate today{QDate::currentDate()};

settings.beginGroup( Constants::BuildingPermitsTitle );
settings.setValue( Constants::ListDuration, mCityMetaData.buildingPermitsDaysForward() );
settings.setValue( Constants::ListSelectedDate,
                   today.addDays( mCityMetaData.buildingPermitsDaysForward() * -1 ) );
settings.endGroup();

settings.beginGroup( Constants::FireIncidentsTitle );
settings.setValue( Constants::ListDuration, mCityMetaData.fireIncidentsDaysForward() );
settings.setValue( Constants::ListSelectedDate,
                   today.addDays( mCityMetaData.fireIncidentsDaysForward() * -1 ) );
settings.endGroup();

settings.beginGroup( Constants::PoliceIncidentsTitle );
settings.setValue( Constants::ListDuration, mCityMetaData.policeIncidentsDaysForward() );
settings.setValue( Constants::ListSelectedDate,
                   today.addDays( mCityMetaData.policeIncidentsDaysForward() * -1 ) );
settings.endGroup();

settings.beginGroup( Constants::ServiceRequestsTitle );
settings.setValue( Constants::ListDuration, mCityMetaData.serviceRequestsDaysForward() );
settings.setValue( Constants::ListSelectedDate,
                   today.addDays( mCityMetaData.serviceRequestsDaysForward() * -1 ) );
settings.endGroup();
}
}
*/
