// Default empty project template
#include "applicationui.hpp"
#include "Account.hpp"

#include <bb/cascades/Application>
#include <bb/cascades/QmlDocument>
#include <bb/cascades/AbstractPane>
#include <bb/data/SqlDataAccess>
#include <bb/system/SystemDialog>

#include <QtSql/QtSql>
#include <QDebug>

using namespace bb::cascades;
using namespace bb::system;
using namespace bb::data;

#define ADD_ACCOUNT 1
#define READ_ACCOUNTS 2
#define MODIFY_ACCOUNT 3
#define REMOVE_ACCOUNT 4
#define CHECK_PIN 5

const char* const ApplicationUI::mPeeperDatabase = "peeperDatabase.db";

ApplicationUI::ApplicationUI(bb::cascades::Application *app) :
		m_sqlConnection(0) {

	QCoreApplication::setOrganizationName("DCK");
	QCoreApplication::setApplicationName("Peeper");

	dbOpenPublic = false;
	A_dataModel = 0;
	initDataModel();
	// create scene document from main.qml asset
	// set parent to created document to ensure it exists for the whole application lifetime
	QmlDocument *qml = QmlDocument::create("asset:///main.qml").parent(this);
	qml->setContextProperty("_app", this);
	// create root object for the UI
	AbstractPane *mainNavi = qml->createRootObject<AbstractPane>();
	copyDBToDataFolder(mPeeperDatabase);
	m_sqlConnection = new SqlConnection("data/peeperDatabase.db", this);

	connect(m_sqlConnection, SIGNAL(reply(const bb::data::DataAccessReply&)),
			this,
			SLOT(onLoadAsyncResultData(const bb::data::DataAccessReply&)));
	// set created root object as a scene
	app->setScene(mainNavi);

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
		QString originalFileName = appFolder + "app/native/assets/sql/"
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

bool ApplicationUI::createRecord(const QString &title, const QString &username,
		const QString &password, const QString &tag) {

	if (password.isEmpty()) {
		alert(tr("Need to enter something in all fields)"));
		return false;
	}

	QString query;

	QTextStream(&query)
			<< "INSERT INTO accounts (tag, accountName, userName, passWord) VALUES ('"
			<< tag << "','" << title << "','" << username << "','" << password
			<< "')";

	DataAccessReply reply = m_sqlConnection->executeAndWait(query, ADD_ACCOUNT);

	bool success = false;
	if (reply.hasError()) {
		alert(tr("create record ERROR"));
		success = false;
	} else {
		success = true;
		alert(tr("Created %1 account").arg(title));
	}

	return success;
}
void ApplicationUI::initDataModel() {
	A_dataModel = new bb::cascades::GroupDataModel(this);
	A_dataModel->setSortingKeys(QStringList() << "tag");
	A_dataModel->setGrouping(ItemGrouping::ByFullValue);
}
void ApplicationUI::readRecords() {
	A_dataModel->clear();

	const QString sqlQuery =
			"SELECT pk, tag, accountName, userName, passWord FROM accounts";
	DataAccessReply reply = m_sqlConnection->executeAndWait(sqlQuery,
			READ_ACCOUNTS);

	if (reply.hasError()) {
		alert(tr("reading records ERROR"));
	} else {
		onLoadAsyncResultData(reply);
	}
}
bool ApplicationUI::modify(const QString &title, const QString &username,
		const QString &password, const QString &pk) {
	QString sqlQueryModify;

	QTextStream(&sqlQueryModify) << "UPDATE accounts set accountName ='"
			<< title << "', userName='" << username << "', passWord ='"
			<< password << "' where pk =" << pk;
	DataAccessReply reply = m_sqlConnection->executeAndWait(sqlQueryModify,
			MODIFY_ACCOUNT);
	if (reply.hasError()) {
		alert(tr("reading records ERROR"));
	} else {
		alert(tr("Account Updated."));
		;
	}
	return true;
}
bool ApplicationUI::remove(const QString &pk) {
	QString sqlQueryRemove;

	QTextStream(&sqlQueryRemove) << "DELETE FROM accounts WHERE pk =" << pk;
	DataAccessReply reply = m_sqlConnection->executeAndWait(sqlQueryRemove,
			REMOVE_ACCOUNT);
	if (reply.hasError()) {
		alert(tr("reading records ERROR"));
	} else {
		alert(tr("Account Removed."));
		;
	}
	return true;
}
bb::cascades::GroupDataModel* ApplicationUI::dataModel() const {
	return A_dataModel;
}
// -----------------------------------------------------------------------------------------------
// Alert Dialog Box Functions
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

void ApplicationUI::onLoadAsyncResultData(
		const bb::data::DataAccessReply& reply) {
	if (reply.hasError()) {
		alert(tr("Has error on loadAsync Method"));
	} else {
		if (reply.id() == READ_ACCOUNTS) {
			QVariantList resultList = reply.result().value<QVariantList>();
			if (resultList.size() > 0) {
				dbOpenPublic = true;
				A_dataModel->insertList(resultList);

			}
		} else {
			alert(tr("reply id is different"));
		}
	}
}
bool ApplicationUI::checkPIN(const QString &pin) {
	QString query;
	bool isCorrect = false;
	QTextStream(&query) << "SELECT password FROM pw WHERE password =" << pin;
	DataAccessReply reply = m_sqlConnection->executeAndWait(query, CHECK_PIN);

	if (reply.hasError()) {
		isCorrect = false;
		alert(tr(" DB Error "));
	} else if (reply.id() != CHECK_PIN) {
		isCorrect = false;
		alert(tr(" Wrong reply ID "));
	} else {
		QVariantList resultList = reply.result().value<QVariantList>();
		if (resultList.size() > 0) {
			return true;
		} else {
			isCorrect = false;
			alert(tr(" Wrong PIN. Try Again! "));
		}
	}

	return isCorrect;
}
bool ApplicationUI::createPIN(const QString &pin) {
	QString query;
	QTextStream(&query) << "SELECT * FROM pw" << pin;
	return true;
}
