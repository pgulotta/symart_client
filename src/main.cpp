#include <QApplication>
#include <QQuickStyle>
#include "initializer.hpp"
#include "frontcontroller.hpp"
#include "permissions.hpp"

int main( int argc, char* argv[] )
{
  QGuiApplication::setAttribute( Qt::AA_EnableHighDpiScaling );
  QGuiApplication::setApplicationName( QStringLiteral( "SymArt" ) );
  QGuiApplication::setOrganizationDomain( "twentysixapps.com" );
  QGuiApplication::setOrganizationName( QLatin1String( "26Apps" ) );
  QGuiApplication::setApplicationVersion( "2.09" );
  QQuickStyle::setStyle( "Material" );
  QApplication app( argc, argv );
  FrontController frontController{&app};
  Initializer initializer{frontController, &app};

  Permissions permissions;
  permissions.requestExternalStoragePermission();

  if ( permissions.getPermissionResult() ) {
    qWarning( "Successfully obtained required permissions, app starting" );
    return app.exec();
  } else {
    qWarning( "Failed to obtain required permissions, app terminating" );
  }
}
