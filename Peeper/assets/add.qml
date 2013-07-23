import bb.cascades 1.0

Page {
    property variant nav
    property variant peepID
    property variant accountName
    property variant userName
    property variant passWord
    property variant urlIDtext
    property variant tag
    property variant pk
    property variant path
   
    onCreationCompleted: {
        //_app.alert("add created");
        Application.asleep.connect(onAsleep);
    }
    function onAsleep() {
        var pPage = pPageDefinition.createObject();
        //_app.alert("add asleep");
        pPage.accountName = title.text;
        pPage.userName = username.text;
        pPage.passWord = password.text;
        pPage.tag = tags.selectedOption.text;
        pPage.pk = pk;
        pPage.path = path;
        pPage.urlIDtext = urlID.text;
        pPage.nav = nav;
        pPage.peepID = peepID;
        nav.push(pPage);
    }
    attachedObjects: [
        ComponentDefinition {
            id: pPageDefinition
            source: "add.qml"
        }
    ]
    actions: [
        ActionItem {
            enabled: {
                if (path == 1) false;
                else true;
            }

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

        title: {
            if (path == 1) {
                qsTr("Edit Account Info")
            } else qsTr("Add Account")
        }
        visibility: ChromeVisibility.Visible

    }

    Container {

        Divider {

        }
        TextField {
            id: title
            hintText: qsTr("Title")
            text: accountName

        }
        TextField {
            id: username
            hintText: qsTr("Username")
            text: userName
            inputMode: TextFieldInputMode.EmailAddress

        }
        TextField {
            id: password
            text: passWord
            hintText: qsTr("Password")
            inputMode: TextFieldInputMode.Password

        }
        TextField {
            id: urlID
            text: urlIDtext
            hintText: qsTr("Sample: gmail.com")
            inputMode: TextFieldInputMode.Url
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
            expanded: false
            Option {
                text: qsTr("Email Accounts")
                selected: true
            }
            Option {
                text: qsTr("Bank Accounts")
            }
            Option {
                text: qsTr("Work Accounts")
            }
            Option {
                id: ua
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
            text: {
                if (path == 1) {
                    qsTr("Update Account")
                } else qsTr("Add Account")
            }
            onClicked: {
                if (path == 1) {
                    _app.update(title.text, username.text, password.text, tags.selectedOption.text, pk, peepID.toString(), urlID.text);
                    _app.readRecords();

                }
                else _app.createRecord(title.text, username.text, password.text, tags.selectedOption.text, peepID.toString(), urlID.text);
                var page = getAddHomePage();
                nav.push(page);
            }
            property Page homePage
            function getAddHomePage() {
                if (!homePage && path == 1) {
                    homePage = accessUpdatePageDefinition.createObject();
                    homePage.nav = nav;
                    homePage.peepID = peepID;
                }
                else if (! homePage ) {
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
                },
                ComponentDefinition {
                    id: accessUpdatePageDefinition
                    source: "access.qml"
                }
            ]
            horizontalAlignment: HorizontalAlignment.Center
            topMargin: 45.0
            imageSource: "asset:///png/ic_add.png"

        }

    }
}
