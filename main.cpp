//#include <QGuiApplication>
//#include <QQmlApplicationEngine>

#include <QtGui>
#include <QtQuick>

#include "notificationclient.h"
#include "myio.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    qmlRegisterType<MyIOout>("IO", 1, 0, "MyIOout");

     QQuickView view;

   // QQmlApplicationEngine engine;
    //engine.load(QUrl(QStringLiteral("qrc:/main.qml")));

  NotificationClient *notificationClient = new NotificationClient(&view);
        view.engine()->rootContext()->setContextProperty(QLatin1String("notificationClient"),notificationClient);
        view.setResizeMode(QQuickView::SizeRootObjectToView);
        view.setSource(QUrl(QStringLiteral("qrc:/main.qml")));
        view.show();



    return app.exec();
}
