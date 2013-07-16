// Navigation pane project template
#include "applicationui.hpp"

#include <bb/cascades/Application>
#include <bb/cascades/QmlDocument>
#include <bb/cascades/AbstractPane>
#include <bb/cascades/Container>
#include <bb/cascades/SceneCover>
#include <bb/cascades/Picker>
#include <QDebug>
#include <QtSql/QtSql>
#include <bb/data/SqlDataAccess>
#include <bb/system/SystemDialog>

using namespace bb::cascades;
using namespace bb::system;
using namespace bb::data;

#define ADD_WORKOUT 1
#define READ_WORKOUT 2
#define MODIFY_WORKOUT 3
#define REMOVE_WORKOUT 4
#define CHECK_WORKOUT 5

const char* const ApplicationUI::mWTDatabase = "wt.db";

ApplicationUI::ApplicationUI(bb::cascades::Application *app) :
		m_sqlConnection(0) {
	QCoreApplication::setOrganizationName("DCK");
	QCoreApplication::setApplicationName("Peeper");
	A_dataModel = 0;
	initDataModel();
	copyDBToDataFolder(mWTDatabase);
	m_sqlConnection = new SqlConnection("data/wt.db", this);
	connect(m_sqlConnection, SIGNAL(reply(const bb::data::DataAccessReply&)),
			this,
			SLOT(onLoadAsyncResultData(const bb::data::DataAccessReply&)));
	// create scene document from main.qml asset
	// set parent to created document to ensure it exists for the whole application lifetime
	QmlDocument *qml = QmlDocument::create("asset:///main.qml").parent(this);

	qml->setContextProperty("_app", this);

	// create root object for the UI
	AbstractPane *root = qml->createRootObject<AbstractPane>();
	// set created root object as a scene
	app->setScene(root);
	addApplicationCover();
}
void ApplicationUI::initDataModel() {
	A_dataModel = new bb::cascades::GroupDataModel(this);
	A_dataModel->setSortingKeys(QStringList() << "DATE");
	A_dataModel->setGrouping(ItemGrouping::ByFullValue);
}

void ApplicationUI::onLoadAsyncResultData(
		const bb::data::DataAccessReply& reply) {
	if (reply.hasError()) {
		alert(tr("Has error on loadAsync Method"));
	} else {
		if (reply.id() == READ_WORKOUT) {
			QVariantList resultList = reply.result().value<QVariantList>();
			if (resultList.size() > 0) {
				//dbOpenPublic = true;
				A_dataModel->insertList(resultList);

			}
		} else {
			alert(tr("reply id is different"));
		}
	}
}
void ApplicationUI::addApplicationCover() {
	// A small UI consisting of just an ImageView in a Container is set up
	// and used as the cover for the application when running in minimized mode.
	QmlDocument *qmlCover = QmlDocument::create("asset:///AppCover.qml").parent(
			this);

	if (!qmlCover->hasErrors()) {
		// Create the QML Container from using the QMLDocument.
		Container *coverContainer = qmlCover->createRootObject<Container>();

		// Create a SceneCover and set the application cover
		SceneCover *sceneCover = SceneCover::create().content(coverContainer);
		Application::instance()->setCover(sceneCover);
	}
}
ApplicationUI::~ApplicationUI() {
	if (m_sqlConnection->isRunning()) {
		m_sqlConnection->stop();
	}
}
bool ApplicationUI::copyDBToDataFolder(const QString databaseName) {
	QString dataFolder = QDir::homePath();
	QString newFileName = dataFolder + "/" + databaseName;
	QFile newFile(newFileName);

	if (!newFile.exists()) {
		QString appFolder(QDir::homePath());
		appFolder.chop(4);
		QString originalFileName = appFolder + "app/native/assets/SQL/"
				+ databaseName;
		QFile originalFile(originalFileName);

		if (originalFile.exists()) {
			return originalFile.copy(newFileName);
		} else {
			alert(
					tr("failed to copy db file. It doesn't exist. %1").arg(
							appFolder));
			return true;
		}

	}
	return true;
}
void ApplicationUI::alert(const QString &message) {
	SystemDialog *dialog; // SystemDialog uses the BB10 native dialog.
	dialog = new SystemDialog(tr("OK"), 0); // New dialog with on 'Ok' button, no 'Cancel' button
	dialog->setTitle(tr("Alert")); // set a title for the message
	dialog->setBody(message); // set the message itself
	dialog->setDismissAutomatically(true); // Hides the dialog when a button is pressed.

	// Setup slot to mark the dialog for deletion in the next event loop after the dialog has been accepted.
	connect(dialog, SIGNAL(finished(bb::system::SystemUiResult::Type)), dialog,
			SLOT(deleteLater()));
	dialog->show();
}
bb::cascades::GroupDataModel* ApplicationUI::dataModel() const {
	return A_dataModel;
}
bool ApplicationUI::addExercise(const QString & setsixweight,
		const QString & setsixreps, const QString & setfiveweight,
		const QString & setfivereps, const QString & setfourweight,
		const QString & setfourreps, const QString & setthreeweight,
		const QString & setthreereps, const QString & settwoweight,
		const QString & settworeps, const QString & setoneweight,
		const QString & setonereps, const QString & units,
		const QString & numsets, const QString & title, const QString & muscle,
		const QString & date, const QString & pic_fn) {
	QString query;

	QTextStream(&query)
			<< "INSERT INTO WORKOUT(SETSIXWEIGHT, SETSIXREPS, SETFIVEWEIGHT, SETFIVEREPS, "
			<< "SETFOURWEIGHT, SETFOURREPS, SETTHREEWEIGHT, SETTHREEREPS, SETTWOWEIGHT, SETTWOREPS,"
			<< " SETONEWEIGHT, SETONEREPS, UNITS, NUMSETS, TITLE, MUSCLE, DATE, PIC_FN) VALUES ("
			<< setsixweight << "," << setsixreps << "," << setfiveweight << ","
			<< setfivereps << "," << setfourweight << "," << setfourreps << ","
			<< setthreeweight << "," << setthreereps << "," << settwoweight
			<< "," << settworeps << "," << setoneweight << "," << setonereps
			<< ",'" << units << "'," << numsets << ",'" << title << "','"
			<< muscle << "','" << date << "','" << pic_fn << "')";
	DataAccessReply reply = m_sqlConnection->executeAndWait(query, ADD_WORKOUT);
	bool success = false;
	if (reply.hasError()) {
		alert(tr("add work-out ERROR%1 %2 %3").arg(setsixreps).arg(date).arg(numsets));
		success = false;
	} else {
		alert(tr("Added %1 work-out").arg(title));
		success = true;
	}

	return success;
}

void ApplicationUI::retrieveExercises() {

	A_dataModel->clear();

	QString query;

		QTextStream(&query) <<
			"SELECT SETSIXWEIGHT, SETSIXREPS, SETFIVEWEIGHT, SETFIVEREPS, SETFOURWEIGHT, "
					<< "SETFOURREPS, SETTHREEWEIGHT, SETTHREEREPS, SETTWOWEIGHT, SETTWOREPS, "
					<< "SETONEWEIGHT, SETONEREPS, UNITS, NUMSETS, TITLE, MUSCLE, DATE, "
					<< "PIC_FN FROM workout ORDER BY DATE";
	DataAccessReply reply = m_sqlConnection->executeAndWait(query,
				READ_WORKOUT);
	if (reply.hasError()) {
			alert(tr("No exercises logged in yet!"));
		} else {
			onLoadAsyncResultData(reply);
		}

}
