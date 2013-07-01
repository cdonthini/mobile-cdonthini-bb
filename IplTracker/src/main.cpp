#include <bb/cascades/AbstractPane>
#include <bb/cascades/Application>
#include <bb/cascades/QmlDocument>
#include <bb/cascades/SceneCover>
#include <bb/cascades/Container>
#include <bb/data/DataSource>

using namespace bb::cascades;
void addApplicationCover();

Q_DECL_EXPORT int main(int argc, char **argv)
{
    // We want to use DataSource in QML
    bb::data::DataSource::registerQmlTypes();

    Application app(argc, argv);

    // Load the UI description from main.qml
    QmlDocument *qml = QmlDocument::create("asset:///main.qml").parent(&app);

    // Create the application scene
    AbstractPane *appPage = qml->createRootObject<AbstractPane>();
    Application::instance()->setScene(appPage);
    addApplicationCover();
    return Application::instance()->exec();

}
void addApplicationCover() {
	// A small UI consisting of just an ImageView in a Container is set up
	// and used as the cover for the application when running in minimized mode.
	QmlDocument *qmlCover = QmlDocument::create("asset:///AppCover.qml");

	if (!qmlCover->hasErrors()) {
		// Create the QML Container from using the QMLDocument.
		Container *coverContainer = qmlCover->createRootObject<Container>();

		// Create a SceneCover and set the application cover
		SceneCover *sceneCover = SceneCover::create().content(coverContainer);
		Application::instance()->setCover(sceneCover);
	}
}
