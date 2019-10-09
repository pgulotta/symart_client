#pragma once

#include <QObject>
#include <QQmlApplicationEngine>
#include "topicsmetadatabuilder.hpp"

class Initializer final : public QObject
{
public:
  Q_OBJECT

public:
  explicit Initializer( QObject* parent = nullptr );


private:
  void initSettings();
  void initQml();

private:
  TopicsMetaDataBuilder mTopicsMetaDataBuilder;
  QQmlApplicationEngine mQmlApplicationEngine;


};

