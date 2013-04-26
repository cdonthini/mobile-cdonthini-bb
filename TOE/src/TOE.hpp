// Navigation pane project template
#ifndef TOE_HPP_
#define TOE_HPP_

#include <QObject>

namespace bb { namespace cascades { class Application; }}

/*!
 * @brief Application pane object
 *
 *Use this object to create and init app UI, to create context objects, to register the new meta types etc.
 */
class TOE : public QObject
{
    Q_OBJECT
public:
    TOE(bb::cascades::Application *app);
    void addApplicationCover();
    virtual ~TOE() {}
};

#endif /* TOE_HPP_ */
