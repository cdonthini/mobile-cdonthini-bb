// Navigation pane project template
#ifndef IplTracker_HPP_
#define IplTracker_HPP_
#include <bb/data/DataSource>
#include <QObject>

namespace bb { namespace cascades { class Application; }}

/*!
 * @brief Application pane object
 *
 *Use this object to create and init app UI, to create context objects, to register the new meta types etc.
 */
class IplTracker : public QObject
{
    Q_OBJECT
public:
    IplTracker(bb::cascades::Application *app);
    virtual ~IplTracker() {}
};

#endif /* IplTracker_HPP_ */
