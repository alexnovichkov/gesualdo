#include <QApplication>
#include <QtQml>
#include <QtQuick/QQuickView>
//#include "qtquick2applicationviewer.h"

#include "model.h"

static void registerTypes()
{
    //register all classes that can be used in the app
    qmlRegisterType<Model>("org.alexnovichkov.gesualdo", 1, 0, "Model");
}

int main(int argc, char *argv[])
{
    QApplication app(argc, argv);
    registerTypes();
    QQmlApplicationEngine engine(QUrl("qml/main.qml"));
    QQmlContext *context = engine.rootContext();
    context->setContextProperty("window_title", "w_title");

    QObject *topLevel = engine.rootObjects().value(0);
    QQuickWindow *window = qobject_cast<QQuickWindow *>(topLevel);
    if (!window) {
        qWarning("Error: Your root item has to be a Window.");
        return -1;
    }

    window->show();
    return app.exec();
}
