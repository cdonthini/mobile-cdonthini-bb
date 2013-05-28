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
    virtual ~ApplicationUI() {}
private:
    // The connection to the SQL database
    bb::data::SqlConnection* m_sqlConnection;
    bool initDatabase();
};


#endif /* ApplicationUI_HPP_ */
