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
  Q_INVOKABLE  QStringList flipTypes();
  Q_INVOKABLE  QStringList projectionTypes();
  Q_INVOKABLE  QStringList walkFillTypes();


private slots:


private:
  QStringList mSymmetryGroups;
  QStringList mFlipTypes;
  QStringList mProjectionTypes;
  QStringList mWalkFillTypes;

};


