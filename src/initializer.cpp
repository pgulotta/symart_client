#include "initializer.hpp"
#include "imageprovider.hpp"
#include "topicmetadata.hpp"
#include <QGuiApplication>
#include <QQmlContext>
#include <QQmlApplicationEngine>
#include <QSettings>
#include <QVariant>


const QString ApplicationCategoryTitle{"Application"  };

Initializer::Initializer( FrontController& frontController, QObject* parent ):
  QObject{parent},
  mTopicsMetaDataBuilder{parent},
  mImmutableList{parent},
  mQmlApplicationEngine{parent}
{
  initQml( frontController );
}

void Initializer::initQml( FrontController& frontController )
{
  qmlRegisterSingletonType( QUrl( QStringLiteral( "qrc:/view/qml/SharedConstants.qml" ) ),
                            "com.twentysixapps.constants", 1, 0, "Constants" );


  qmlRegisterType<TopicMetaData>( "TopicMetaDataModel", 1, 0, "TopicMetaData" );
  QQmlContext* context = mQmlApplicationEngine.rootContext();
  context->setContextProperty( "ImmutableList", &mImmutableList );
  context->setContextProperty( "Controller", &frontController );
  context->setContextProperty( "TopicsMetaData", QVariant::fromValue( mTopicsMetaDataBuilder.topicsMetaData() ) );
  mQmlApplicationEngine.addImageProvider( "generatedImage", frontController.imageProvider() );
  mQmlApplicationEngine.load( QUrl( QStringLiteral( "qrc:/view/qml/MainPage.qml" ) ) );
}

