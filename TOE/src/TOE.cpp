// Navigation pane project template
#include "TOE.hpp"

#include <bb/cascades/Application>
#include <bb/cascades/QmlDocument>
#include <bb/cascades/AbstractPane>
#include <bb/cascades/SceneCover>
#include <bb/cascades/Container>
using namespace bb::cascades;

TOE::TOE(bb::cascades::Application *app)
: QObject(app)
{
    // create scene document from main.qml asset
    // set parent to created document to ensure it exists for the whole application lifetime
    QmlDocument *qml = QmlDocument::create("asset:///NewMain.qml").parent(this);

    // create root object for the UI
    AbstractPane *root = qml->createRootObject<AbstractPane>();
    // set created root object as a scene
    app->setScene(root);
    addApplicationCover();
}

void TOE::addApplicationCover() {
    // A small UI consisting of just an ImageView in a Container is set up
    // and used as the cover for the application when running in minimized mode.
    QmlDocument *qmlCover = QmlDocument::create("asset:///minimized.qml").parent(this);

    if (!qmlCover->hasErrors()) {
        // Create the QML Container from using the QMLDocument.
        Container *coverContainer = qmlCover->createRootObject<Container>();

        // Create a SceneCover and set the application cover
        SceneCover *sceneCover = SceneCover::create().content(coverContainer);
        Application::instance()->setCover(sceneCover);
    }
}
