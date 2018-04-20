//#include <QGuiApplication>
//#include <QQmlApplicationEngine>

#include <QtGui>
#include <QtQuick>
#include <QtAndroidExtras/QAndroidJniObject>
#include <QtAndroid>
#include <QCommandLineParser>


#include "notificationclient.h"
#include "myio.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    qmlRegisterType<MyIOout>("IO", 1, 0, "MyIOout");

     QQuickView view;

     QCommandLineParser parser;
     QCommandLineOption fullMode("main");
     QCommandLineOption serviceMode("service");

     parser.addOption(fullMode);
     parser.addOption(serviceMode);


   // QQmlApplicationEngine engine;
    //engine.load(QUrl(QStringLiteral("qrc:/main.qml")));

  NotificationClient *notificationClient = new NotificationClient(&view);
        view.engine()->rootContext()->setContextProperty(QLatin1String("notificationClient"),notificationClient);
        view.setResizeMode(QQuickView::SizeRootObjectToView);
        view.setSource(QUrl(QStringLiteral("qrc:/main.qml")));
        view.show();

    QAndroidJniObject::callStaticMethod<void>("com/vagueentertainment/cafesync/OpenSeedService",
                                              "startOpenSeedService",
                                              "(Landroid/content/Context;)V",
                                              QtAndroid::androidActivity().object());

    return app.exec();
}
