// Default empty project template
#include "applicationui.hpp"

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

ApplicationUI::ApplicationUI(bb::cascades::Application *app) :
		m_sqlConnection(0) {

	A_dataModel = 0;
	// create scene document from main.qml asset
	// set parent to created document to ensure it exists for the whole application lifetime
	QmlDocument *qml = QmlDocument::create("asset:///main.qml").parent(this);
	qml->setContextProperty("_app", this);
	// create root object for the UI
	AbstractPane *mainNavi = qml->createRootObject<AbstractPane>();
	db = QSqlDatabase::addDatabase("QSQLITE");

	db.setDatabaseName("./data/peeperDatabase.db");
	// set created root object as a scene
	app->setScene(mainNavi);

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

	if (title.trimmed().isEmpty() && username.trimmed().isEmpty()
			&& password.trimmed().isEmpty()) {
		alert(tr("Need to enter something in all bro!:)"));
		return false;
	}

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

	return success;
}
void ApplicationUI::initDataModel(){
	A_dataModel = new GroupDataModel(this);
	A_dataModel->setSortingKeys(QStringList() << "accountName");
	A_dataModel->setGrouping(ItemGrouping::None);
}
void ApplicationUI::readRecords(){
	QSqlQuery query(db);

	const QString sqlQuery = "SELECT accountID, accountName, userName, passWord FROM accounts";

	if(query.exec(sqlQuery)){
//		const int accountIDField = query.record().indexOf("accountID");
//		const int accountNameField = query.record().indexOf("accountName");
//		const int userNameField = query.record().indexOf("userName");
//		const int passWordField = query.record().indexOf("passWord");

		m_dataModel->clear();


	}
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

