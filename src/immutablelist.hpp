#pragma once

#include <QObject>

#include <QStringList>


class ImmutableList final : public QObject
{
  Q_OBJECT

signals:

public:
  ImmutableList();
  Q_INVOKABLE  QStringList symmetryGroups();
  Q_INVOKABLE const QStringList& flipTypes();
  Q_INVOKABLE const QStringList& projectionTypes();
  Q_INVOKABLE const QStringList& walkFillTypes();


private slots:


private:
  QStringList mSymmetryGroups;
  QStringList mFlipTypes;
  QStringList mProjectionTypes;
  QStringList mWalkFillTypes;

};


