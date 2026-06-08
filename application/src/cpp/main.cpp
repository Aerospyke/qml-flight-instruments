#include <QGuiApplication>
#include <QtQml/QtQml>

#include "animation.h"
#include "primary_flight_data.h"

int main(int argc, char* argv[]) {
  // Pull in resources (qrc:/qml/* with the nice aliases, plus all images and fonts)
  // that live in the static QmlFlightInstruments library.
  // The resource name must match the .qrc base name (QmlFlightInstruments.qrc).
  // Q_INIT_RESOURCE must be called from inside a function.
  Q_INIT_RESOURCE(QmlFlightInstruments);

#if QT_VERSION < QT_VERSION_CHECK(6, 0, 0)
  QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
#endif
  const QGuiApplication Application(argc, argv);

  QQmlApplicationEngine engine;

  const QUrl RootUrl("qrc:/qml/MainWindow.qml");
  QObject::connect(
      &engine, &QQmlApplicationEngine::objectCreated, &Application,
      [RootUrl](const QObject* object, const QUrl& object_url) {
        if (!object && RootUrl == object_url)
          QCoreApplication::exit(-1);
      },
      Qt::QueuedConnection);

  auto* flight_telemetry = new PrimaryFlightData;
  auto* animation = new Animation;
  animation->setPfd(flight_telemetry);

  engine.rootContext()->setContextProperty("flight_telemetry", flight_telemetry);
  engine.load(RootUrl);

  animation->init();

  return Application.exec();
}
