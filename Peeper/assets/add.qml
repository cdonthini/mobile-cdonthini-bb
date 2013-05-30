import bb.cascades 1.0

Page {
    property variant nav
    property bool dbOpen
    actions: [
        ActionItem {
            id: linkAccess
            title: qsTr("Access")
            onTriggered: {
                // show detail page when the button is clicked
                var page = getAccessPage();
                nav.push(page);
            }
            property Page accessPage
            function getAccessPage() {
                if (! accessPage) {
                    accessPage = accessPageDefinition.createObject();
                    accessPage.nav = nav;
                }
                return accessPage;
            }
            attachedObjects: [
                ComponentDefinition {
                    id: accessPageDefinition
                    source: "access.qml"
                }
            ]
        },
        ActionItem {
            id: linkRemove
            title: qsTr("Remove")
            onTriggered: {
                // show detail page when the button is clicked
                var page = getRemovePage();
                nav.push(page);
            }
            property Page removePage
            function getRemovePage() {
                if (! removePage) {
                    removePage = removePageDefinition.createObject();
                    removePage.nav = nav;
                }
                return removePage;
            }
            attachedObjects: [
                ComponentDefinition {
                    id: removePageDefinition
                    source: "remove.qml"
                }
            ]
        }
        

    ]
    actionBarVisibility: ChromeVisibility.Visible
    paneProperties: NavigationPaneProperties {
        backButton: ActionItem {
            id: linkHome
            title: qsTr("Home")
            onTriggered: {
                // show detail page when the button is clicked
                var page = getHomePage();
                nav.push(page);
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

    }
    Container {
        Label {
            text: {
                if (dbOpen) {
                    "db is open"
                } else "db is closed";
            }
            textStyle.fontWeight: FontWeight.W900
        }
        Divider {

        }
        TextField {
            id: title
            hintText: qsTr("Title")

        }
        TextField {
            id: username
            hintText: qsTr("Username")
            inputMode: TextFieldInputMode.EmailAddress

        }
        TextField {
            id: password
            hintText: qsTr("Password")

        }
        Button {
            id: addButton
            text: qsTr("Add Account")
            onClicked: {
                
                _app.createRecord(title.text,username.text,password.text);
                var page = getAddAccessPage();
                nav.push(page);
            }
            property Page addAccessPage
            function getAddAccessPage() {
                if (! addAccessPage) {
                    addAccessPage = addAccessPageDefinition.createObject();
                    addAccessPage.nav = nav;
                    addAccessPage.dbOpen = dbOpen;
                }
                return addAccessPage;
            }
            attachedObjects: [
                ComponentDefinition {
                    id: addAccessPageDefinition
                    source: "access.qml"
                }
            ]
            horizontalAlignment: HorizontalAlignment.Center
            topMargin: 20.0

        }

    }
}
