// Default empty project template
#include "applicationui.hpp"

#include <bb/cascades/Application>
#include <bb/cascades/QmlDocument>
#include <bb/cascades/AbstractPane>
#include <bb/data/SqlDataAccess>

#include <QtSql/QtSql>
#include <QDebug>

using namespace bb::cascades;

ApplicationUI::ApplicationUI(bb::cascades::Application *app) :
		m_sqlConnection(0) {
	// create scene document from main.qml asset
	// set parent to created document to ensure it exists for the whole application lifetime
	QmlDocument *qml = QmlDocument::create("asset:///main.qml").parent(this);
	qml->setContextProperty("_app", this);
	// create root object for the UI
	AbstractPane *mainNavi = qml->createRootObject<AbstractPane>();
	const bool dbInited = initDatabase();
	mainNavi->setProperty("dbOpen", dbInited);
	// set created root object as a scene
	app->setScene(mainNavi);

}

bool ApplicationUI::initDatabase() {
	QSqlDatabase db = QSqlDatabase::addDatabase("QSLITE");

	db.setDatabaseName("./data/peeperDatabase.db");

	if (db.open() == false) {
		const QSqlError error = db.lastError();
		//alert(tr("Error opening connection to db"));
		return false;
	}
	QSqlQuery query(db);
	const QString createSQL = "CREATE TABLE accounts"
			" (accountID INTEGER PRIMARY KEY AUTOINCREMENT, "
			" accountName VARCHAR, "
			" userName    VARCHAR, "
			" passWord    VARCHAR);";

	if (query.exec(createSQL)) {
		qDebug() << "Table of accounts created.";
	} else {
		const QSqlError error = db.lastError();
		//alert(tr("Error in creating table"));
		return false;
	}

	return true;
}

