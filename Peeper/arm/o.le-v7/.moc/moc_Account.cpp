/****************************************************************************
** Meta object code from reading C++ file 'Account.hpp'
**
** Created by: The Qt Meta Object Compiler version 63 (Qt 4.8.5)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include "../../../src/Account.hpp"
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'Account.hpp' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 63
#error "This file was generated using the moc from 4.8.5. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

QT_BEGIN_MOC_NAMESPACE
static const uint qt_meta_data_Account[] = {

 // content:
       6,       // revision
       0,       // classname
       0,    0, // classinfo
       4,   14, // methods
       4,   34, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
       4,       // signalCount

 // signals: signature, parameters, type, tag, flags
      19,    9,    8,    8, 0x05,
      57,   45,    8,    8, 0x05,
      94,   85,    8,    8, 0x05,
     128,  119,    8,    8, 0x05,

 // properties: name, type, flags
     161,  153, 0x0a495903,
     171,  153, 0x0a495903,
     183,  153, 0x0a495903,
     192,  153, 0x0a495903,

 // properties: notify_signal_id
       0,
       1,
       2,
       3,

       0        // eod
};

static const char qt_meta_stringdata_Account[] = {
    "Account\0\0accountiD\0accountIDChanged(QString)\0"
    "accountname\0accountNameChanged(QString)\0"
    "username\0userNameChanged(QString)\0"
    "password\0passWordChanged(QString)\0"
    "QString\0accountID\0accountName\0userName\0"
    "passWord\0"
};

void Account::qt_static_metacall(QObject *_o, QMetaObject::Call _c, int _id, void **_a)
{
    if (_c == QMetaObject::InvokeMetaMethod) {
        Q_ASSERT(staticMetaObject.cast(_o));
        Account *_t = static_cast<Account *>(_o);
        switch (_id) {
        case 0: _t->accountIDChanged((*reinterpret_cast< const QString(*)>(_a[1]))); break;
        case 1: _t->accountNameChanged((*reinterpret_cast< const QString(*)>(_a[1]))); break;
        case 2: _t->userNameChanged((*reinterpret_cast< const QString(*)>(_a[1]))); break;
        case 3: _t->passWordChanged((*reinterpret_cast< const QString(*)>(_a[1]))); break;
        default: ;
        }
    }
}

const QMetaObjectExtraData Account::staticMetaObjectExtraData = {
    0,  qt_static_metacall 
};

const QMetaObject Account::staticMetaObject = {
    { &QObject::staticMetaObject, qt_meta_stringdata_Account,
      qt_meta_data_Account, &staticMetaObjectExtraData }
};

#ifdef Q_NO_DATA_RELOCATION
const QMetaObject &Account::getStaticMetaObject() { return staticMetaObject; }
#endif //Q_NO_DATA_RELOCATION

const QMetaObject *Account::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->metaObject : &staticMetaObject;
}

void *Account::qt_metacast(const char *_clname)
{
    if (!_clname) return 0;
    if (!strcmp(_clname, qt_meta_stringdata_Account))
        return static_cast<void*>(const_cast< Account*>(this));
    return QObject::qt_metacast(_clname);
}

int Account::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QObject::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        if (_id < 4)
            qt_static_metacall(this, _c, _id, _a);
        _id -= 4;
    }
#ifndef QT_NO_PROPERTIES
      else if (_c == QMetaObject::ReadProperty) {
        void *_v = _a[0];
        switch (_id) {
        case 0: *reinterpret_cast< QString*>(_v) = getAccountID(); break;
        case 1: *reinterpret_cast< QString*>(_v) = getAccountName(); break;
        case 2: *reinterpret_cast< QString*>(_v) = getUserName(); break;
        case 3: *reinterpret_cast< QString*>(_v) = getPassWord(); break;
        }
        _id -= 4;
    } else if (_c == QMetaObject::WriteProperty) {
        void *_v = _a[0];
        switch (_id) {
        case 0: setAccountID(*reinterpret_cast< QString*>(_v)); break;
        case 1: setAccountName(*reinterpret_cast< QString*>(_v)); break;
        case 2: setUserName(*reinterpret_cast< QString*>(_v)); break;
        case 3: setPassWord(*reinterpret_cast< QString*>(_v)); break;
        }
        _id -= 4;
    } else if (_c == QMetaObject::ResetProperty) {
        _id -= 4;
    } else if (_c == QMetaObject::QueryPropertyDesignable) {
        _id -= 4;
    } else if (_c == QMetaObject::QueryPropertyScriptable) {
        _id -= 4;
    } else if (_c == QMetaObject::QueryPropertyStored) {
        _id -= 4;
    } else if (_c == QMetaObject::QueryPropertyEditable) {
        _id -= 4;
    } else if (_c == QMetaObject::QueryPropertyUser) {
        _id -= 4;
    }
#endif // QT_NO_PROPERTIES
    return _id;
}

// SIGNAL 0
void Account::accountIDChanged(const QString & _t1)
{
    void *_a[] = { 0, const_cast<void*>(reinterpret_cast<const void*>(&_t1)) };
    QMetaObject::activate(this, &staticMetaObject, 0, _a);
}

// SIGNAL 1
void Account::accountNameChanged(const QString & _t1)
{
    void *_a[] = { 0, const_cast<void*>(reinterpret_cast<const void*>(&_t1)) };
    QMetaObject::activate(this, &staticMetaObject, 1, _a);
}

// SIGNAL 2
void Account::userNameChanged(const QString & _t1)
{
    void *_a[] = { 0, const_cast<void*>(reinterpret_cast<const void*>(&_t1)) };
    QMetaObject::activate(this, &staticMetaObject, 2, _a);
}

// SIGNAL 3
void Account::passWordChanged(const QString & _t1)
{
    void *_a[] = { 0, const_cast<void*>(reinterpret_cast<const void*>(&_t1)) };
    QMetaObject::activate(this, &staticMetaObject, 3, _a);
}
QT_END_MOC_NAMESPACE
