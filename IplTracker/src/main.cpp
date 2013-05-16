#include <bb/cascades/AbstractPane>
#include <bb/cascades/Application>
#include <bb/cascades/QmlDocument>
#include <bb/data/DataSource>
#include <bb/cascades/WebPage>
using namespace bb::cascades;

Q_DECL_EXPORT int main(int argc, char **argv)
{
    // We want to use DataSource in QML
    bb::data::DataSource::registerQmlTypes();
    qmlRegisterType<bb::cascades::WebPage>("WebPageComponent", 1, 0,"WebPage");
    Application app(argc, argv);

    // Load the UI description from main.qml
    QmlDocument *qml = QmlDocument::create("asset:///main.qml").parent(&app);

    // Create the application scene
    AbstractPane *appPage = qml->createRootObject<AbstractPane>();
    Application::instance()->setScene(appPage);

    return Application::instance()->exec();
}
