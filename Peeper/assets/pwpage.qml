import bb.cascades 1.0

Page {

    id: passwordPage
    property variant nav
    property alias accountName : anText.text
    property alias userName : unText.text
    property variant passWord
    property variant tag
    property variant pk
    property int path
    property variant peepID

    titleBar: TitleBar {
        id: check
        title: qsTr("Account Details")
        visibility: ChromeVisibility.Visible

    }
    actionBarVisibility: ChromeVisibility.Hidden
    Container {
        horizontalAlignment: HorizontalAlignment.Center
        verticalAlignment: VerticalAlignment.Center
        layout: StackLayout {

        }
        Label {
            text: "Account Name:"

        }
        TextField {
            id: anText
            hintText: qsTr("Your Account name Here")
            inputMode: TextFieldInputMode.Text
            
            onTextChanging: {
                editB.enabled = true;
            }

        }
        Label {
            text: qsTr("User name:")
        }
        TextField {
            id: unText
            hintText: qsTr("Your Username Here")
            onTextChanging: {
                editB.enabled = true;
            }
            inputMode: TextFieldInputMode.EmailAddress
        }
        Label {
            text: qsTr("Password")
        }
        TextField {
            id: pwText
            text: _app.decryptPW(passWord.toString(), peepID.toString())
            onTextChanging: {
                editB.enabled = true;
            }
            hintText: qsTr("Your Password Here")
            inputMode: TextFieldInputMode.Password
        }
        Label {
            id: tagText
            text: tag
        }
        Button {
            imageSource: "//assets/png/icon_home.png"
            horizontalAlignment: HorizontalAlignment.Center
            topMargin: 25.0
            text: {
//                if (path == 0) {
                   qsTr("Home")
//                } else if (path == 1) {
//                    qsTr("Edit Account")
//                } else if (path == 2) {
//                    qsTr("Remove Account")
//                }
            }

            onClicked: {
                var page = getHomePage();
                nav.push(page);
            }
            property Page homePage
            function getHomePage() {
                if (! homePage) {
                    homePage = homePageDefinition.createObject();
                    homePage.nav = nav;
                    homePage.peepID = peepID;
                }
                return homePage;
            }
            attachedObjects: [
                ComponentDefinition {
                    id: homePageDefinition
                    source: "Home.qml"
                }
            ]
        }

        Container {
            layout: StackLayout {
                orientation: LayoutOrientation.LeftToRight

            }

            horizontalAlignment: HorizontalAlignment.Center
            Button {
                imageSource: "//assets/png/ic_edit.png"
                id: editB
                enabled: false
                text: qsTr("Update")

                onClicked: {
                    _app.modify(anText.text, unText.text, pwText.text, pk, peepID.toString());
                    _app.readRecords();
                    var page = getAccessPage();
                    nav.push(page);
                }
                property Page accessPage
                function getAccessPage() {
                    if (! accessPage) {
                        accessPage = accessPageDefinitionEdit.createObject();
                        accessPage.nav = nav;
                        accessPage.peepID = peepID;
                    }
                    return accessPage;
                }
                attachedObjects: [
                    ComponentDefinition {
                        id: accessPageDefinitionEdit
                        source: "access.qml"
                    }
                ]
               

            }
            Button {

                text: qsTr("Remove")

                onClicked: {
                    
                    _app.remove(pk);
                    _app.readRecords();
                    var page = getAccessPage();
                    nav.push(page);
                }
                property Page accessPage
                function getAccessPage() {
                    if (! accessPage) {
                        accessPage = accessPageDefinitionRemove.createObject();
                        accessPage.nav = nav;
                        accessPage.peepID = peepID;
                    }
                    return accessPage;
                }
                attachedObjects: [
                    ComponentDefinition {
                        id: accessPageDefinitionRemove
                        source: "access.qml"
                    }
                ]
                imageSource: "//assets/png/ic_delete.png"

            }
        }

    }
}
