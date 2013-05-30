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
		const QString &userName, const QString passWord, QObject *parent) :
		QObject(parent) {
	A_accountID = accountID;
	A_accountName = accountName;
	A_userName = userName;
	A_passWord = passWord;
}

QString Account::getAccountID(){
	return A_accountID;
}
QString Account::getAccountName(){
	return A_accountName;
}
QString Account::getUserName(){
	return A_userName;
}
QString Account::getPassWord(){
	return A_passWord;
}

void Account::setAccountID(const QString &accountID){
	A_accountID = accountID;
	emit accountIDChanged(accountID);
}
void Account::setAccountName(const QString &accountName){
	A_accountName = accountName;
	emit accountNameChanged(accountName);
}
void Account::setUserName(const QString &userName){
	A_userName = userName;
	emit userNameChanged(userName);
}
void Account::setPassWord(const QString &passWord){
	A_passWord = passWord;
	emit passWordChanged(passWord);
}


Account::~Account() {
	// TODO Auto-generated destructor stub
}

