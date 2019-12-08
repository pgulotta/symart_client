#pragma once

#include <QObject>
#include <QSettings>
#include "topicmetadata.hpp"


struct TopicsMetaDataSort {
  inline bool operator()( const QObject* lhsObject, const QObject* rhsObject )
  {
    const TopicMetaData* lhs = static_cast<const TopicMetaData*>( lhsObject );
    const TopicMetaData* rhs = static_cast<const TopicMetaData*>( rhsObject );

    if ( lhs->orderByIndex() == rhs->orderByIndex() ) {
      return lhs->title() < rhs->title();
    } else {
      return lhs->orderByIndex() < rhs->orderByIndex();
    }
  }
};

class TopicsMetaDataBuilder final : public QObject
{
  Q_OBJECT
public:
  explicit TopicsMetaDataBuilder( QObject* parent = nullptr )
    : QObject( parent )
  {
    build();
    //load();
  }

  ~TopicsMetaDataBuilder() { qDeleteAll( mTopicsMetaData ); }

  const QList<QObject*>& topicsMetaData() const { return mTopicsMetaData; }

// void load()
// {
//    QSettings settings;
//    settings.beginGroup( Constants::TopicsMetaDataTitle );

//    for ( auto item : mTopicsMetaData ) {
//      TopicMetaData* topic = static_cast<TopicMetaData*>( item );
//      topic->setOrderByIndex( settings.value( topic->title(), 0 ).toInt() );
//    }

//    settings.endGroup();
//    std::sort( mTopicsMetaData.begin(), mTopicsMetaData.end(), TopicsMetaDataSort() );
// }

// void store( const QStringList& data )
// {
//    QSettings settings;
//    settings.beginGroup( Constants::TopicsMetaDataTitle );
//    int index = 0;

//    for ( const auto& item : data ) {
//      settings.setValue( item, index++ );
//    }

//    settings.endGroup();
//    load();
// }

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
      "Clouds Help....", parent()} );
    mTopicsMetaData.append( new TopicMetaData{
      TopicMetaData::Topic::Clusters,
      "Clusters",
      "qrc:/view/images/clusters.png",
      "qrc:/view/qml/ClustersPage.qml",
      "Clusters Help....", parent()} );
    mTopicsMetaData.append( new TopicMetaData{
      TopicMetaData::Topic::HyperClouds,
      "Hyperbolic Clouds",
      "qrc:/view/images/hyper-clouds.png",
      "qrc:/view/qml/HyperCloudsPage.qml",
      "Hyperbolic Clouds Help", parent()} );
    mTopicsMetaData.append( new TopicMetaData{
      TopicMetaData::Topic::HyperLines,
      "Hyperbolic Lines",
      "qrc:/view/images/hyper-lines.png",
      "qrc:/view/qml/HyperLinesPage.qml",
      "Hyperbolic Lines Help", parent()} );
    mTopicsMetaData.append( new TopicMetaData{
      TopicMetaData::Topic::Lines,
      "Lines",
      "qrc:/view/images/lines.png",
      "qrc:/view/qml/LinesPage.qml",
      "Lines Help ...", parent()} );
    mTopicsMetaData.append( new TopicMetaData{
      TopicMetaData::Topic::OrbitTraps,
      "Orbit Trap",
      "qrc:/view/images/orbit-traps.png",
      "qrc:/view/qml/OrbitTrapsPage.qml",
      "Orbit Trap Help", parent()} );
    mTopicsMetaData.append( new TopicMetaData{
      TopicMetaData::Topic::QuasiOrbitTraps,
      "Quasiperiodic Orbit Trap",
      "qrc:/view/images/quasi-orbit-traps.png",
      "qrc:/view/qml/QuasiOrbitTrapsPage.qml",
      "Quasiperiodic Orbit Traps Help ...", parent()} );
    mTopicsMetaData.append( new TopicMetaData{
      TopicMetaData::Topic::QuasiStripes,
      "Quasiperiodic Stripes",
      "qrc:/view/images/quasi-stripes.png",
      "qrc:/view/qml/QuasiperiodicStripesPage.qml",
      "Quasi Stripes Help....", parent()} );
    mTopicsMetaData.append( new TopicMetaData{
      TopicMetaData::Topic::Squiggles,
      "Squiggles",
      "qrc:/view/images/squiggles.png",
      "qrc:/view/qml/SquigglesPage.qml",
      "Squiggles Help ...", parent()} );
    mTopicsMetaData.append( new TopicMetaData{
      TopicMetaData::Topic::Stripes,
      "Stripes",
      "qrc:/view/images/stripes.png",
      "qrc:/view/qml/StripesPage.qml",
      "Stripes Help ...", parent()} );
    mTopicsMetaData.append( new TopicMetaData{
      TopicMetaData::Topic::Walk,
      "Walk",
      "qrc:/view/images/walks.png",
      "qrc:/view/qml/WalksPage.qml",
      "Walk Help ...", parent()} );
    mTopicsMetaData.append( new TopicMetaData{
      TopicMetaData::Topic::Info,
      "App Info",
      "qrc:/view/images/info.png",
      "qrc:/view/qml/InfoPage.qml",
      "Application Info ...", parent()} );
  }

  QList<QObject*> mTopicsMetaData;
};
