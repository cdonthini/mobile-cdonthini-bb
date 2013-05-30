// Default empty project template
#ifndef ApplicationUI_HPP_
#define ApplicationUI_HPP_

#include <QObject>
#include <bb/data/SqlConnection>
#include <bb/data/SqlDataAccess>
#include <QtSql/QtSql>
#include <bb/cascades/GroupDataModel>

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
    Q_INVOKABLE bool initDatabase();
    Q_INVOKABLE bool createRecord(const QString &title , const QString &username, const QString &password);
    Q_INVOKABLE void readRecords();
    virtual ~ApplicationUI() {}
private:
    void initDataModel();
    bb::cascades::GroupDataModel* dataModel() const;
    GroupDataModel* A_dataModel;
    QSqlDatabase db;
    void alert(const QString &message);
    // The connection to the SQL database
    bb::data::SqlConnection* m_sqlConnection;

};


#endif /* ApplicationUI_HPP_ */
