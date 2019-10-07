#pragma once

#include <QObject>
#include <QSettings>
#include "topicmetadata.hpp"
#include "constants.hpp"

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
    load();
  }

  ~TopicsMetaDataBuilder() { qDeleteAll( mTopicsMetaData ); }

  const QList<QObject*>& topicsMetaData() const { return mTopicsMetaData; }

  void load()
  {
//    QSettings settings;
//    settings.beginGroup( Constants::TopicsMetaDataTitle );

//    for ( auto item : mTopicsMetaData ) {
//      TopicMetaData* topic = static_cast<TopicMetaData*>( item );
//      topic->setOrderByIndex( settings.value( topic->title(), 0 ).toInt() );
//    }

//    settings.endGroup();
//    std::sort( mTopicsMetaData.begin(), mTopicsMetaData.end(), TopicsMetaDataSort() );
  }

  void store( const QStringList& data )
  {
//    QSettings settings;
//    settings.beginGroup( Constants::TopicsMetaDataTitle );
//    int index = 0;

//    for ( const auto& item : data ) {
//      settings.setValue( item, index++ );
//    }

//    settings.endGroup();
//    load();
  }

signals:

public slots:

private:
  void build()
  {
    mTopicsMetaData.append( new TopicMetaData{
      TopicMetaData::Topic::CelluarAutomata,
      Constants::CelluarAutomataTitle,
      "qrc:/view/images/celluar-automata.png",
      "qrc:/view/qml/CelluarAutomata.qml",
      "Celluar Automata Help...."} );
    mTopicsMetaData.append( new TopicMetaData{
      TopicMetaData::Topic::Clouds,
      Constants::CloudsTitle,
      "qrc:/view/images/clouds.png",
      "qrc:/view/qml/Clouds.qml",
      "Clouds Help...."} );
    mTopicsMetaData.append( new TopicMetaData{
      TopicMetaData::Topic::Clusters,
      Constants::ClustersTitle,
      "qrc:/view/images/clusters.png",
      "qrc:/view/qml/Clusters.qml",
      "Clusters Help...."} );
    mTopicsMetaData.append( new TopicMetaData{
      TopicMetaData::Topic::HyperClouds,
      Constants::HyperCloudsTitle,
      "qrc:/view/images/hyper-clouds.png",
      "qrc:/view/qml/HyperClouds.qml",
      "Hyperbolic Clouds Help"} );
    mTopicsMetaData.append( new TopicMetaData{
      TopicMetaData::Topic::HyperLines,
      Constants::HyperCloudsTitle,
      "qrc:/view/images/hyper-lines.png",
      "qrc:/view/qml/HyperLines.qml",
      "Hyperbolic Lines Help"} );
    mTopicsMetaData.append( new TopicMetaData{
      TopicMetaData::Topic::Lines,
      Constants::LinesTitle,
      "qrc:/view/images/lines.png",
      "qrc:/view/qml/Lines.qml",
      "Lines Help ..."} );
    mTopicsMetaData.append( new TopicMetaData{
      TopicMetaData::Topic::OrbitTraps,
      Constants::OrbitTrapTitle,
      "qrc:/view/images/orbit-trap.png",
      "qrc:/view/qml/OrbitTrap.qml",
      "Orbit Trap Help"} );
    mTopicsMetaData.append( new TopicMetaData{
      TopicMetaData::Topic::QuasiOrbitTraps,
      Constants::QuasiOrbitTrapsTitle,
      "qrc:/view/images/quasi-orbit-trap.png",
      "qrc:/view/qml/QuasiOrbitTraps.qml",
      "Quasi Orbit Traps Help ..."} );
    mTopicsMetaData.append( new TopicMetaData{
      TopicMetaData::Topic::QuasiStripes,
      Constants::QuasiStripesTitle,
      "qrc:/view/images/quasi-stripes.png",
      "qrc:/view/qml/QuasiStripes.qml",
      "Quasi Stripes Help...."} );
    mTopicsMetaData.append( new TopicMetaData{
      TopicMetaData::Topic::Squiggles,
      Constants::SquigglesTitle,
      "qrc:/view/images/squiggles.png",
      "qrc:/view/qml/Squiggles.qml",
      "Squiggles Help ..."} );
    mTopicsMetaData.append( new TopicMetaData{
      TopicMetaData::Topic::Stripes,
      Constants::StripesTitle,
      "qrc:/view/images/stripes.png",
      "qrc:/view/qml/Stripes.qml",
      "Stripes Help ..."} );
    mTopicsMetaData.append( new TopicMetaData{
      TopicMetaData::Topic::Walk,
      Constants::WalkTitle,
      "qrc:/view/images/walk.png",
      "qrc:/view/qml/Walk.qml",
      "Walk Help ..."} );






  }

  QList<QObject*> mTopicsMetaData;
};
