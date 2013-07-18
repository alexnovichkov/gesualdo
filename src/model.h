#ifndef MODEL_H
#define MODEL_H

#include <QObject>
#include <QUrl>

class Model : public QObject
{
    Q_OBJECT

    Q_PROPERTY(QList<QUrl> filesToAdd READ filesToAdd WRITE setFilesToAdd NOTIFY filesToAddChanged)

public:
    explicit Model(QObject *parent = 0);
    QList<QUrl> filesToAdd() const {return _filesToAdd;}
signals:
    void filesToAddChanged();
public slots:
    void setFilesToAdd(const QList<QUrl> &files);
private:
    QList<QUrl> _filesToAdd;
};

#endif // MODEL_H
