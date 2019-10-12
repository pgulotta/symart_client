#pragma once

#include <QStringList>


class ListsBuilder
{
public:
  ListsBuilder();

  const QStringList& symGroups();

private:
  QStringList mSymGroups;


};


