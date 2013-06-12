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

	Q_PROPERTY(QString accountID READ getAccountID WRITE setAccountID NOTIFY accountIDChanged FINAL)
	Q_PROPERTY(QString accountName READ getAccountName WRITE setAccountName NOTIFY accountNameChanged FINAL)
	Q_PROPERTY(QString userName READ getUserName WRITE setUserName NOTIFY userNameChanged FINAL)
	Q_PROPERTY(QString passWord READ getPassWord WRITE setPassWord NOTIFY passWordChanged FINAL)

public:

	Account(QObject *parent = 0);
	Account(const QString &accountID, const QString &accountName,
				const QString &userName, const QString &passWord, QObject *parent = 0);


	QString getAccountID() const;
	QString getAccountName() const;
	QString getUserName() const;
	QString getPassWord() const;

	void setAccountID(const QString &accountID);
	void setAccountName(const QString &accountName);
	void setUserName(const QString &userName);
	void setPassWord(const QString &passWord);

Q_SIGNALS:
	void accountIDChanged(const QString &accountiD);
	void accountNameChanged(const QString &accountname);
	void userNameChanged(const QString &username);
	void passWordChanged(const QString &password);

private:
	QString A_accountID;
	QString A_accountName;
	QString A_userName;
	QString A_passWord;

};

#endif /* ACCOUNT_HPP_ */
