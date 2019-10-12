#pragma once

#include <QObject>
#include "listsbuilder.hpp"



class FrontController : public QObject
{
  Q_OBJECT
  Q_PROPERTY( QStringList symGroups READ symGroups CONSTANT )
signals:

public slots:


public:
  explicit FrontController( QObject* parent = nullptr );

  QStringList symGroups() {return mListsBuilder.symGroups();}

private:
  ListsBuilder mListsBuilder;



};


