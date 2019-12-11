#include <QApplication>
#include <QQuickStyle>
#include "initializer.hpp"
#include "frontcontroller.hpp"

int main( int argc, char* argv[] )
{
  QGuiApplication::setAttribute( Qt::AA_EnableHighDpiScaling );
  QGuiApplication::setApplicationName( QStringLiteral( "SymArt" ) );
  QGuiApplication::setOrganizationDomain( "twentysixapps.com" );
  QGuiApplication::setOrganizationName( QLatin1String( "26Apps" ) );
  QGuiApplication::setApplicationVersion( "2.01" );
  QQuickStyle::setStyle( "Material" );
  QApplication app( argc, argv );
  FrontController frontController{&app};
  Initializer initializer{frontController, &app};

  return app.exec();
}
