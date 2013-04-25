// Default empty project template
#ifndef Exchange_HPP_
#define Exchange_HPP_

#include <QObject>

namespace bb { namespace cascades { class Application; }}

/*!
 * @brief Application pane object
 *
 *Use this object to create and init app UI, to create context objects, to register the new meta types etc.
 */
class Exchange : public QObject
{
    Q_OBJECT
public:
    Exchange(bb::cascades::Application *app);
    virtual ~Exchange() {}
};


#endif /* Exchange_HPP_ */
