#include "model.h"

#include <QtDebug>

Model::Model(QObject *parent) :
    QObject(parent)
{
}

void Model::setFilesToAdd(const QList<QUrl> &files)
{
    _filesToAdd.clear();
    if (files.isEmpty()) return;

    _filesToAdd = files;
    // TODO: implement Settings
    // TODO: implement addDir

//    Settings->lastDirectory = files.first();
//#ifdef Q_OS_LINUX
//    QDir dir(Settings->lastDirectory);
//    if (dir.cdUp())
//        Settings->lastDirectory=dir.absolutePath();
//#endif
//    foreach (const QUrl &url, _filesToAdd) {
//        addDir(url, true, false);
//    }

    qDebug()<<files;
}
