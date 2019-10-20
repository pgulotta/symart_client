#include "frontcontroller.hpp"
#include <QApplication>
#include <QUuid>
#include <QDebug>

FrontController* FrontController::FrontControllerInstance{nullptr};

const QString QueryPrefix{"http://192.168.1.119:60564/get/?"};

//  const QString QueryPrefix{"http://192.168.1.119:60564/get/?"};

void FrontController::appMessageHandler(QtMsgType type,
                                        const QMessageLogContext &context,
                                        const QString &msg)
{
    QByteArray localMsg = msg.toLocal8Bit();
    const char *file = context.file ? context.file : "";
    const char *function = context.function ? context.function : "";
    auto displayMsg = msg.split(':', QString::SkipEmptyParts);

    switch (type) {
    case QtDebugMsg:
        fprintf(stderr,
                "SymArt Debug: %s (%s:%u, %s)\n",
                localMsg.constData(),
                file,
                context.line,
                function);
        break;

    case QtInfoMsg:
        fprintf(stderr,
                "SymArt Info: %s (%s:%u, %s)\n",
                localMsg.constData(),
                file,
                context.line,
                function);
        break;

    case QtWarningMsg:
        fprintf(stderr,
                "SymArt Warning: %s (%s:%u, %s)\n",
                localMsg.constData(),
                file,
                context.line,
                function);
        emit FrontControllerInstance->messageGenerated(displayMsg[displayMsg.count() - 1]);
        break;

    case QtCriticalMsg:
        fprintf(stderr,
                "SymArt Critical: %s (%s:%u, %s)\n",
                localMsg.constData(),
                file,
                context.line,
                function);
        emit FrontControllerInstance->messageGenerated(displayMsg[displayMsg.count() - 1]);
        break;

    case QtFatalMsg:
        fprintf(stderr,
                "SymArt Fatal: %s (%s:%u, %s)\n",
                localMsg.constData(),
                file,
                context.line,
                function);
        emit FrontControllerInstance->messageGenerated(displayMsg[displayMsg.count() - 1]);
        break;
    }
}

FrontController::FrontController(QObject *parent)
    : QObject(parent)
    ,

    mServiceId{QUuid::createUuid().toString(QUuid::WithoutBraces)}
    , mNetworkQueryController(parent)
{
    FrontControllerInstance = this;
    qInstallMessageHandler(FrontController::appMessageHandler);
    connect(&mNetworkQueryController,
            &NetworkQueryController::networkQueryFailed,
            this,
            [](const QString &messageDescription) {
                emit FrontControllerInstance->messageGenerated(messageDescription);
            });
}

QString FrontController::applicationTitle() const
{
    return QApplication::applicationName();
}

QString FrontController::applicationVersion() const
{
    return QApplication::applicationVersion();
}

void FrontController::saveCurrentImage(const QString &filename)
{
    auto formattedFilename{filename.trimmed()};

    if (formattedFilename.isEmpty()) {
        return;
    }

    QStringList attributes{QString::number(static_cast<int>(QueryType::SaveImage)),
                           formattedFilename};
    QString query = QString("%1lastImage/%2").arg(QueryPrefix).arg(mServiceId);
    mNetworkQueryController.runRequest(attributes, query);
}

QString FrontController::getOrbitTrapQuery(int dimension, int symmetryGroup)
{
    return QString("%1trap/%2/%3/%4")
        .arg(QueryPrefix)
        .arg(mServiceId)
        .arg(dimension)
        .arg(symmetryGroup);
}

QString FrontController::getRandomizeQuery(int x, int y)
{
    return QString("%1randomizeTiles/%2/%3/%4").arg(QueryPrefix).arg(mServiceId).arg(x).arg(y);
}

QString FrontController::getHyperbolicImageQuery(int size, int projectionType)
{
    return QString("%1hyperbolicImage/%2/%3/%4")
        .arg(QueryPrefix)
        .arg(mServiceId)
        .arg(size)
        .arg(projectionType);
}

QString FrontController::getLastGenerateImageQuery()
{
    return QString("%1lastImage/%2").arg(QueryPrefix).arg(mServiceId);
}

QString FrontController::getHexagonalStretchImageQuery()
{
    return QString("%1hexagonalStretch/%2").arg(QueryPrefix).arg(mServiceId);
}
