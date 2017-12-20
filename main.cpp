#include <QGuiApplication>
#include <QQmlApplicationEngine>

//#include "notificationclient.h"
#include "myio.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    qmlRegisterType<MyIOout>("IO", 1, 0, "MyIOout");

    QQmlApplicationEngine engine;
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));

  //  NotificationClient *notificationClient = new NotificationClient(&app);
       //app.connectNotify(QLatin1String("notificationClient"),notificationClient);



    return app.exec();
}
