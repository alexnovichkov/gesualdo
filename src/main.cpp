#include <QtWidgets/QApplication>
#include <QtQml>
#include <QtQuick/QQuickView>
//#include "qtquick2applicationviewer.h"

static void registerTypes()
{
    //register all classes that can be used in the app
    //qmlRegisterType<DocumentHandler>("org.qtproject.example", 1, 0, "DocumentHandler");
}

int main(int argc, char *argv[])
{
//    QGuiApplication app(argc, argv);

//    registerTypes();

//    QtQuick2ApplicationViewer viewer;
//    //viewer.rootContext();
//    //

//    viewer.setMainQmlFile(QStringLiteral("qml/gesualdo/main.qml"));
//    viewer.showExpanded();

//    return app.exec();

    QApplication app(argc, argv);

    QQmlApplicationEngine engine(QUrl("qml/main.qml"));
    QQmlContext *context = engine.rootContext();
    context->setContextProperty("window_title", "w_title");

    QObject *topLevel = engine.rootObjects().value(0);
    QQuickWindow *window = qobject_cast<QQuickWindow *>(topLevel);
    if ( !window ) {
        qWarning("Error: Your root item has to be a Window.");
        return -1;
    }
    window->show();
    return app.exec();
}
