// Default empty project template
#ifndef ApplicationUI_HPP_
#define ApplicationUI_HPP_


#include <bb/data/SqlConnection>
#include <bb/data/SqlDataAccess>
#include <bb/cascades/GroupDataModel>
#include <QtSql/QtSql>


namespace bb { namespace cascades { class Application; }}

/*!
 * @brief Application pane object
 *
 *Use this object to create and init app UI, to create context objects, to register the new meta types etc.
 */
class ApplicationUI : public QObject
{
    Q_OBJECT

    Q_PROPERTY(bb::cascades::DataModel* dataModel READ dataModel CONSTANT)

public:
    ApplicationUI(bb::cascades::Application *app);

    Q_INVOKABLE bool createRecord(const QString &title , const QString &username, const QString &password, const QString &tag, const QString &peepID);
    Q_INVOKABLE bool modify(const QString &title , const QString &username, const QString &password, const QString &tag, const QString &peepID);
    Q_INVOKABLE void readRecords();
    Q_INVOKABLE QString decryptPW(const QString& pw, const QString& peepID);
    Q_INVOKABLE bool remove(const QString &pk);
    Q_INVOKABLE bool checkPIN(const QString &pin);
    Q_INVOKABLE bool createPIN(const QString &pin);
    Q_INVOKABLE bool dbOpenPublic;
    Q_INVOKABLE void alert(const QString &message);
    ~ApplicationUI();


private slots:

	void onLoadAsyncResultData(const bb::data::DataAccessReply& reply);

private:
	void addApplicationCover();
	bool copyDBToDataFolder(const QString databaseName);
    void initDataModel();
    bool pinExists();
    bb::cascades::GroupDataModel* dataModel() const;
    bb::cascades::GroupDataModel* A_dataModel;
    QSqlDatabase db;

    // The connection to the SQL database
    bb::data::SqlConnection* m_sqlConnection;
    static const char* const mPeeperDatabase;

};


#endif /* ApplicationUI_HPP_ */
