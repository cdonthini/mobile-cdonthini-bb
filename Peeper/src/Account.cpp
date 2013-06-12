/*
 * Account.cpp
 *
 *  Created on: May 30, 2013
 *      Author: cdonthini
 */

#include "Account.hpp"

Account::Account(QObject *parent) : QObject(parent){

}
Account::Account(const QString &accountID, const QString &accountName,
		const QString &userName, const QString &passWord, QObject *parent) :
		QObject(parent),
	A_accountID(accountID),
	A_accountName(accountName),
	A_userName(userName),
	A_passWord(passWord)
	{
}

QString Account::getAccountID() const{
	return A_accountID;
}
QString Account::getAccountName() const{
	return A_accountName;
}
QString Account::getUserName() const{
	return A_userName;
}
QString Account::getPassWord() const{
	return A_passWord;
}

void Account::setAccountID(const QString &newaccountID){
	A_accountID = newaccountID;
	emit accountIDChanged(newaccountID);
}
void Account::setAccountName(const QString &newaccountName){
	A_accountName = newaccountName;
	emit accountNameChanged(newaccountName);
}
void Account::setUserName(const QString &newuserName){
	A_userName = newuserName;
	emit userNameChanged(newuserName);
}
void Account::setPassWord(const QString &newpassWord){
	A_passWord = newpassWord;
	emit passWordChanged(newpassWord);
}

