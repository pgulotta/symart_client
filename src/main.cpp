#include <QtGui/QGuiApplication>
#include <QtQml/QQmlApplicationEngine>
#include <QQmlContext>
#include "topicmetadata.hpp"
#include "topicsmetadatabuilder.hpp"

int main( int argc, char* argv[] )
{
  QCoreApplication::setAttribute( Qt::AA_EnableHighDpiScaling );

  QGuiApplication app( argc, argv );
  QQmlApplicationEngine engine;
  TopicsMetaDataBuilder topicsMetaDataBuilder;

  qmlRegisterSingletonType( QUrl( QStringLiteral( "qrc:/view/qml/Constants.qml" ) ),
                            "com.twentysixapps.symart.constants", 1, 0, "Constants" );
  qmlRegisterType<TopicMetaData>( "TopicMetaDataModel", 1, 0, "TopicMetaData" );
  engine.rootContext()->setContextProperty( "TopicsMetaData",
                                            QVariant::fromValue( topicsMetaDataBuilder.topicsMetaData() ) );

  const QUrl url( QStringLiteral( "qrc:/view/qml/MainPage.qml" ) );
  QObject::connect( &engine, &QQmlApplicationEngine::objectCreated,
  &app, [url]( QObject * obj, const QUrl & objUrl ) {
    if ( !obj && url == objUrl ) {
      QCoreApplication::exit( -1 );
    }
  }, Qt::QueuedConnection );
  engine.load( url );

  return app.exec();
}
