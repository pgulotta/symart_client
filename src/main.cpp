#include <QCoreApplication>
#include <QGuiApplication>
#include <QApplication>
#include <QQuickStyle>
#include "initializer.hpp"




int main( int argc, char* argv[] )
{
  QCoreApplication::setAttribute( Qt::AA_EnableHighDpiScaling );
  QApplication::setApplicationName( QStringLiteral( "SymArt" ) );
  QApplication::setOrganizationDomain( "twentysixapps.com" );
  QCoreApplication::setOrganizationName( QLatin1String( "26Apps" ) );
  QApplication::setApplicationVersion( "1.00" );
  QQuickStyle::setStyle( "Material" );
  QApplication app( argc, argv );

  Initializer initializer;

  return app.exec();
}
