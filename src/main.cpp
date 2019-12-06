#include <QGuiApplication>
#include <QQuickStyle>
#include "initializer.hpp"


int main( int argc, char* argv[] )
{
  QGuiApplication::setAttribute( Qt::AA_EnableHighDpiScaling );
  QGuiApplication::setApplicationName( QStringLiteral( "SymArt" ) );
  QGuiApplication::setOrganizationDomain( "twentysixapps.com" );
  QGuiApplication::setOrganizationName( QLatin1String( "26Apps" ) );
  QGuiApplication::setApplicationVersion( "1.00" );
  QQuickStyle::setStyle( "Material" );
  QGuiApplication app( argc, argv );

  Initializer initializer;

  return app.exec();
}
