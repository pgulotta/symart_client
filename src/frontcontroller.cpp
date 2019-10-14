#include "frontcontroller.hpp"
#include <QApplication>
#include <QUuid>

FrontController* mInstance;

void FrontController::appMessageHandler( QtMsgType type, const QMessageLogContext& context, const QString& msg )
{
  QByteArray localMsg = msg.toLocal8Bit();
  const char* file = context.file ? context.file : "";
  const char* function = context.function ? context.function : "";
  auto displayMsg = msg.split( ':', QString::SkipEmptyParts );

  switch ( type ) {
  case QtDebugMsg:
    fprintf( stderr, "SymArt Debug: %s (%s:%u, %s)\n", localMsg.constData(), file, context.line, function );
    break;

  case QtInfoMsg:
    fprintf( stderr, "SymArt Info: %s (%s:%u, %s)\n", localMsg.constData(), file, context.line, function );
    break;

  case QtWarningMsg:
    fprintf( stderr, "SymArt Warning: %s (%s:%u, %s)\n", localMsg.constData(), file, context.line, function );
    emit mInstance->messageGenerated( displayMsg[displayMsg.count() - 1] );
    break;

  case QtCriticalMsg:
    fprintf( stderr, "SymArt Critical: %s (%s:%u, %s)\n", localMsg.constData(), file, context.line, function );
    emit mInstance->messageGenerated( displayMsg[displayMsg.count() - 1] );
    break;

  case QtFatalMsg:
    fprintf( stderr, "SymArt Fatal: %s (%s:%u, %s)\n", localMsg.constData(), file, context.line, function );
    emit mInstance->messageGenerated( displayMsg[displayMsg.count() - 1] );
    break;
  }
}

FrontController::FrontController( QObject* parent ) :
  QObject( parent ),
  mServiceId{QUuid::createUuid().toString()}
{
  mInstance = this;
  qInstallMessageHandler( FrontController::appMessageHandler );
}

QString FrontController::applicationTitle() const
{
  return QApplication::applicationName();
}

QString FrontController::applicationVersion() const
{
  return QApplication::applicationVersion();
}


QString FrontController::generateTrapQuery( int dimension, int symmetryGroup )
{
  //  http://localhost:60564/test/?trap

  return QString{};
}

