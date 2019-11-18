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
  Q_INVOKABLE  QStringList walkFillModes();
  Q_INVOKABLE  QStringList distributionNames();
  Q_INVOKABLE  QStringList ruleTypes();

private slots:


private:
  QStringList mSymmetryGroups;
  QStringList mFlipTypes;
  QStringList mProjectionTypes;
  QStringList mWalkFillModes;
  QStringList mDistributionNames;
  QStringList mRuleTypes;

};


