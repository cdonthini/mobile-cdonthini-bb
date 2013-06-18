import bb.cascades 1.0

Page {
    
    id: passwordPage
    property variant nav
    property variant accountName
    property variant userName
    property variant passWord
    property variant tag
    property variant pk
    property int path


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
            text: accountName
            hintText: qsTr("Your Account name Here")
            inputMode: TextFieldInputMode.Text

        }
        Label {
            text: qsTr("User name:")
        }
        TextField {
            id: unText
            text: {
                userName
            }
            hintText: qsTr("Your Username Here")
            inputMode: TextFieldInputMode.EmailAddress
        }
        Label {
            text: qsTr("Password")
        }
        TextField {
            id: pwText
            text: passWord
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
                if (path == 0) {
                    qsTr("Home")
                } else if (path == 1) {
                    qsTr("Edit Account")
                } else if (path == 2) {
                    qsTr("Remove Account")
                }
            }

            onClicked: {
                var page = getHomePage();
                push(page);
            }
            property Page homePage
            function getHomePage() {
                if (! homePage) {
                    homePage = homePageDefinition.createObject();

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
            layout: AbsoluteLayout {

            }

            Button {
                imageSource: "//assets/png/ic_edit.png"
                id: editB
                text: qsTr("Edit")
                layoutProperties: AbsoluteLayoutProperties {
                    positionX: 40
                    positionY: 0
                }
                onClicked: {
                    _app.modify(anText.text, unText.text, pwText.text, pk)
                    var page = getAccessPage();
                    nav.push(page);
                }
                property Page accessPage
                function getAccessPage() {
                    if (! accessPage) {
                        accessPage = accessPageDefinitionEdit.createObject();
                        
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
                layoutProperties: AbsoluteLayoutProperties {
                    positionX: 400
                    positionY: 0
                }
                onClicked: {
                    _app.remove(pk)
                    var page = getAccessPage();
                    nav.push(page);
                }
                property Page accessPage
                function getAccessPage() {
                    if (! accessPage) {
                        accessPage = accessPageDefinitionRemove.createObject();
                        
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
