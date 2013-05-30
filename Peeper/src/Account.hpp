/*
 * Account.hpp
 *
 *  Created on: May 30, 2013
 *      Author: cdonthini
 */

#ifndef ACCOUNT_HPP_
#define ACCOUNT_HPP_

#include <QObject>

class Account: public QObject {

	Q_OBJECT

	Q_PROPERTY(QString accountID READ accountID WRITE setAccountID NOTIFY acountIDChanged FINAL)
	Q_PROPERTY(QString accountName READ accountName WRITE setAccountName NOTIFY accountNameChanged FINAL)
	Q_PROPERTY(QString userName READ userName WRITE setUserName NOTIFY userNameChanged FINAL)
	Q_PROPERTY(QString passWord READ passWord WRITE setPassWord NOTIFY passWordChanged FINAL)

public:
	Account(const QString &accountID, const QString &accountName,
			const QString &userName, const QString passWord, QObject *parent = 0);
	Account(QObject *parent = 0);
	virtual ~Account();

	QString getAccountID();
	QString getAccountName();
	QString getUserName();
	QString getPassWord();

	void setAccountID(const QString &accountID);
	void setAccountName(const QString &accountName);
	void setUserName(const QString &userName);
	void setPassWord(const QString &passWord);

Q_SIGNALS:
	void accountIDChanged(const QString &accountID);
	void accountNameChanged(const QString &accountName);
	void userNameChanged(const QString &userName);
	void passWordChanged(const QString &passWord);

private:
	QString A_accountID;
	QString A_accountName;
	QString A_userName;
	QString A_passWord;

};

#endif /* ACCOUNT_HPP_ */
