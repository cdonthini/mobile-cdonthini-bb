// Default empty project template
#ifndef ApplicationUI_HPP_
#define ApplicationUI_HPP_

#include <QObject>
#include <bb/data/SqlConnection>

namespace bb { namespace cascades { class Application; }}

/*!
 * @brief Application pane object
 *
 *Use this object to create and init app UI, to create context objects, to register the new meta types etc.
 */
class ApplicationUI : public QObject
{
    Q_OBJECT
public:
    ApplicationUI(bb::cascades::Application *app);
    Q_INVOKABLE bool initDatabase();
    virtual ~ApplicationUI() {}
private:
    void alert(const QString &message);
    // The connection to the SQL database
    bb::data::SqlConnection* m_sqlConnection;

};


#endif /* ApplicationUI_HPP_ */
