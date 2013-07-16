// Navigation pane project template
#ifndef ApplicationUI_HPP_
#define ApplicationUI_HPP_

#include <bb/data/SqlConnection>
#include <bb/data/SqlDataAccess>
#include <bb/cascades/GroupDataModel>
#include <QtSql/QtSql>

namespace bb {
namespace cascades {
class Application;
}
}

class ApplicationUI: public QObject {
	Q_OBJECT
	Q_PROPERTY(bb::cascades::DataModel* dataModel READ dataModel CONSTANT)

public:
	ApplicationUI(bb::cascades::Application *app);
	Q_INVOKABLE	void alert(const QString &message);
	Q_INVOKABLE bool addExercise(const QString & setsixweight, const QString & setsixreps,
			const QString & setfiveweight, const QString & setfivereps,
			const QString & setfourweight, const QString & setfourreps,
			const QString & setthreeweight, const QString & setthreereps,
			const QString & settwoweight, const QString & settworeps,
			const QString & setoneweight, const QString & setonereps,
			const QString & units, const QString & numsets,
			const QString & title, const QString & muscle, const QString & date,
			const QString & pic_fn);
	Q_INVOKABLE void retrieveExercises();
	~ApplicationUI();

private slots:
	void onLoadAsyncResultData(const bb::data::DataAccessReply& reply);

private:
	void addApplicationCover();
	bool copyDBToDataFolder(const QString databaseName);
	void initDataModel();
	bb::cascades::GroupDataModel* dataModel() const;
	bb::cascades::GroupDataModel* A_dataModel;

	// The connection to the SQL database
	bb::data::SqlConnection* m_sqlConnection;
	static const char* const mWTDatabase;
};

#endif /* ApplicationUI_HPP_ */
