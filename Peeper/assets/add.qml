import bb.cascades 1.0

Page {
    property variant nav
    property variant peepID
    
    
    actions: [
        ActionItem {
            
            id: linkAccess
            title: qsTr("Access")
            onTriggered: {
                // show detail page when the button is clicked
                _app.readRecords();
                var page = getAccessPage();
                nav.push(page);
            }
            property Page accessPage
            function getAccessPage() {
                if (! accessPage) {
                    accessPage = accessPageDefinition.createObject();
                    accessPage.nav = nav;
                    accessPage.peepID = peepID;
                }
                return accessPage;
            }
            attachedObjects: [
                ComponentDefinition {
                    id: accessPageDefinition
                    source: "access.qml"
                }
            ]
            imageSource: "asset:///png/ic_view_list.png"
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
    }
    titleBar: TitleBar {
        
        title: qsTr("Add Account")
        visibility: ChromeVisibility.Visible

    }
    
    Container {
        
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
            inputMode: TextFieldInputMode.Password
            input.submitKey: SubmitKey.Submit
            input {
                onSubmitted: {
                    tags.expanded();
                }
            }
        }

        DropDown {
            id: tags
            title: qsTr("Select a Tag")
            horizontalAlignment: HorizontalAlignment.Center
            Option {
                text: qsTr("Email Accounts")
            }
            Option {
                text: qsTr("Bank Accounts")
            }
            Option {
                text: qsTr("Work Accounts")
            }
            Option {
                text: qsTr("Utility Accounts")
            }
            Option {
                text: qsTr("Social Accounts")
            }
            Option {
                text: qsTr("Other Accounts")
            }

        }
        Button {
            id: addButton
            text: qsTr("Add Account")
            onClicked: {

                _app.createRecord(title.text, username.text, password.text , tags.selectedOption.text, peepID.toString());

                var page = getAddHomePage();
                nav.push(page);
            }
            property Page homePage
            function getAddHomePage() {
                if (! homePage) {
                    homePage = addHomePageDefinition.createObject();
                    homePage.nav = nav;
                    homePage.peepID = peepID;
                }
                return homePage;
            }
            attachedObjects: [
                ComponentDefinition {
                    id: addHomePageDefinition
                    source: "Home.qml"
                }
            ]
            horizontalAlignment: HorizontalAlignment.Center
            topMargin: 45.0
            imageSource: "asset:///png/ic_add.png"

        }

    }
}
