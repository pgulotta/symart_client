#pragma once

#include <QObject>
#include <QSettings>
#include "topicmetadata.hpp"


class TopicsMetaDataBuilder final : public QObject
{
  Q_OBJECT
public:
  explicit TopicsMetaDataBuilder( QObject* parent = nullptr )
    : QObject( parent )
  {
    build();
  }

  ~TopicsMetaDataBuilder() { qDeleteAll( mTopicsMetaData ); }

  const QList<QObject*>& topicsMetaData() const { return mTopicsMetaData; }



signals:

public slots:

private:
  void build()
  {
    mTopicsMetaData.append( new TopicMetaData{
      TopicMetaData::Topic::Clouds,
      "Clouds",
      "qrc:/view/images/clouds.png",
      "qrc:/view/qml/CloudsPage.qml",
      parent()} );
    mTopicsMetaData.append( new TopicMetaData{
      TopicMetaData::Topic::Clusters,
      "Clusters",
      "qrc:/view/images/clusters.png",
      "qrc:/view/qml/ClustersPage.qml",
      parent()} );
    mTopicsMetaData.append( new TopicMetaData{
      TopicMetaData::Topic::HyperClouds,
      "Hyperbolic Clouds",
      "qrc:/view/images/hyper-clouds.png",
      "qrc:/view/qml/HyperCloudsPage.qml",
      parent()} );
    mTopicsMetaData.append( new TopicMetaData{
      TopicMetaData::Topic::HyperLines,
      "Hyperbolic Lines",
      "qrc:/view/images/hyper-lines.png",
      "qrc:/view/qml/HyperLinesPage.qml",
      parent()} );
    mTopicsMetaData.append( new TopicMetaData{
      TopicMetaData::Topic::Lines,
      "Lines",
      "qrc:/view/images/lines.png",
      "qrc:/view/qml/LinesPage.qml",
      parent()} );
    mTopicsMetaData.append( new TopicMetaData{
      TopicMetaData::Topic::OrbitTraps,
      "Orbit Trap",
      "qrc:/view/images/orbit-traps.png",
      "qrc:/view/qml/OrbitTrapsPage.qml",
      parent()} );
    mTopicsMetaData.append( new TopicMetaData{
      TopicMetaData::Topic::QuasiOrbitTraps,
      "Quasiperiodic Orbit Trap",
      "qrc:/view/images/quasi-orbit-traps.png",
      "qrc:/view/qml/QuasiOrbitTrapsPage.qml",
      parent()} );
    mTopicsMetaData.append( new TopicMetaData{
      TopicMetaData::Topic::QuasiStripes,
      "Quasiperiodic Stripes",
      "qrc:/view/images/quasi-stripes.png",
      "qrc:/view/qml/QuasiperiodicStripesPage.qml",
      parent()} );
    mTopicsMetaData.append( new TopicMetaData{
      TopicMetaData::Topic::Squiggles,
      "Squiggles",
      "qrc:/view/images/squiggles.png",
      "qrc:/view/qml/SquigglesPage.qml",
      parent()} );
    mTopicsMetaData.append( new TopicMetaData{
      TopicMetaData::Topic::Stripes,
      "Stripes",
      "qrc:/view/images/stripes.png",
      "qrc:/view/qml/StripesPage.qml",
      parent()} );
    mTopicsMetaData.append( new TopicMetaData{
      TopicMetaData::Topic::Walk,
      "Walk",
      "qrc:/view/images/walks.png",
      "qrc:/view/qml/WalksPage.qml",
      parent()} );
    mTopicsMetaData.append( new TopicMetaData{
      TopicMetaData::Topic::Info,
      "App Info",
      "qrc:/view/images/info.png",
      "qrc:/view/qml/InfoPage.qml",
      parent()} );
  }

  QList<QObject*> mTopicsMetaData;
};
