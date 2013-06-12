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

const char* const CityModel::mPeeperDatabase = "data/peeperDatabase.db";

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
	m_sqlConnection = new SqlConnection(mPeeperDatabase, this);

	connect(m_sqlConnection, SIGNAL(reply(const bb::data::DataAccessReply&)),
			this,
			SLOT(onLoadAsyncResultData(const bb::data::DataAccessReply&)));
	// set created root object as a scene
	app->setScene(mainNavi);

}

ApplicationUI::~ApplicationUI() {
	if(m_sqlConnection->isRunning()){
		m_sqlConnection->stop();
	}
}

bool ApplicationUI::copyDBToDataFolder(const QString databaseName) {
	QString dataFolder = QDir::homePath();
	QString newFileName = dataFolder + "/" + databaseName;
	QFile newFile(newFileName);

	if(!newFile.exists()){
		QString appFolder(QDir::homePath());
		appFolder.chop(4);
		QString originalFileName = appFolder + "app/native/assets/sql/" + databaseName;
		QFile originalFile(originalFileName);

		if(originalFile.exists()) {
			return originalFile.copy(newFileName);
		} else {
			alert(tr("failed to copy file db file doesnt exist."));
			return true;
		}

	}
	return true;
}
void ApplicationUI::onCreatedDB(bool dbOpen) {
	dbOpenPublic = dbOpen;
	check();
}
bool ApplicationUI::initDatabase() {

	if (db.open() == false) {
		const QSqlError error = db.lastError();
		alert(tr("Error opening connection to db"));
		return false;
	}
	QSqlQuery query(db);

	if (query.exec("DROP TABLE IF EXISTS accounts")) {
		qDebug() << "Table dropped";
	} else {
		const QSqlError error = query.lastError();
		alert(tr("Drop table error"));

	}
	const QString createSQL = "CREATE TABLE accounts"
			" (accountID INTEGER PRIMARY KEY AUTOINCREMENT, "
			" accountName VARCHAR, "
			" userName    VARCHAR, "
			" passWord    VARCHAR);";

	if (query.exec(createSQL)) {
		qDebug() << "Table of accounts created.";
	} else {
		const QSqlError error = db.lastError();
		alert(tr("Error in creating table"));
		return false;
	}

	return true;

}

bool ApplicationUI::createRecord(const QString &title, const QString &username,
		const QString &password) {

	if (password.isEmpty()) {
		alert(tr("Need to enter something in all bro!:)"));
		return false;
	}
	db = QSqlDatabase::database();
	QSqlQuery query(db);

	query.prepare("INSERT INTO accounts"
			"	(accountName,userName,passWord) "
			"	VALUES (:accountName, :userName, :passWord)");
	query.bindValue(":accountName", title);
	query.bindValue(":userName", username);
	query.bindValue(":passWord", password);

	bool success = false;
	if (query.exec()) {
		alert(tr("Create record succeeded."));
		success = true;
	} else {
		// If 'exec' fails, error information can be accessed via the lastError function
		// the last error is reset every time exec is called.
		const QSqlError error = query.lastError();
		alert(tr("Create record error: %1").arg(error.text()));
	}
	db.close();
	return success;
}
void ApplicationUI::initDataModel() {
	A_dataModel = new bb::cascades::GroupDataModel(this);
	A_dataModel->setSortingKeys(QStringList() << "accountName");
	A_dataModel->setGrouping(ItemGrouping::None);
}
void ApplicationUI::readRecords() {
	db = QSqlDatabase::database();

	QSqlQuery query(db);
	const QString sqlQuery =
			"SELECT accountID, accountName, userName, passWord FROM accounts";

	if (query.exec(sqlQuery)) {
		const int accountIDField = query.record().indexOf("accountID");
		const int accountNameField = query.record().indexOf("accountName");
		const int userNameField = query.record().indexOf("userName");
		const int passWordField = query.record().indexOf("passWord");

		A_dataModel->clear();

		int recordsRead = 0;

		while (query.next()) {
			Account *account = new Account(
					query.value(accountIDField).toString(),
					query.value(accountNameField).toString(),
					query.value(userNameField).toString(),
					query.value(passWordField).toString());
			A_dataModel->insert(account);
			recordsRead++;
		}
		if (recordsRead == 0) {
			alert(tr("no records"));
		}
	} else {
		alert(tr("reading failed"));
	}
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

bool ApplicationUI::check() {

	return dbOpenPublic;
}
