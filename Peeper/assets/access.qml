import bb.cascades 1.0

Page {
    id: accessPage
    property variant peepID
    property variant nav
    property variant path: 786
    onCreationCompleted: {
        Application.asleep.connect(onAsleep);
    }
    function onAsleep() {
        _app.readRecords();
       // _app.alert("access asleep");
        var pPage = pPageDefinition.createObject();        
        pPage.path = path;        
        pPage.nav = nav;
        pPage.peepID = peepID;
        nav.push(pPage);
    }
   
    actions: [
        ActionItem {
            id: linkAccess
            title: qsTr("Add")
            onTriggered: {
                // show detail page when the button is clicked
                var page = getAddPage();
                nav.push(page);
            }
            property Page addPage
            function getAddPage() {
                if (! addPage) {
                    addPage = addPageDefinition.createObject();
                    addPage.nav = nav;
                    addPage.peepID = peepID;
                }
                return addPage;
            }
            attachedObjects: [
                ComponentDefinition {
                    id: addPageDefinition
                    source: "add.qml"
                }
            ]
            imageSource: "asset:///png/ic_add.png"
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
    Container {

        ListView {
            id: listView
            dataModel: _app.dataModel
            //signal triggered()
            listItemComponents: [
                ListItemComponent {
                    type: "item"
                    StandardListItem {
                        id: accountItem
                        title: ListItemData.accountName
                        description: "Username: " + ListItemData.userName

                        contextActions: [
                            ActionSet {
                                title: ListItemData.accountName
                                subtitle: "Account Options"
                                ActionItem {
                                    title: "Coming soon"
                                    onTriggered: {
                                        
                                    }
                                    imageSource: "asset:///png/ic_edit.png"
                                }
                                ActionItem {
                                    title: "Coming soon"
                                    onTriggered: {
                                                                               
                                    }
                                    imageSource: "asset:///png/ic_delete.png"

                                } // remove action item
                            } //action set
                        ] //contextactions
                    } //standard list
                } //list item component
            ] //list item components

            onTriggered: {
                var chosenItem = dataModel.data(indexPath);
                var passwordPage = passwordPageDefinition.createObject();
                passwordPage.accountName = chosenItem.accountName;
                passwordPage.userName = chosenItem.userName;
                passwordPage.passWord = chosenItem.passWord;
                passwordPage.tag = chosenItem.tag;
                passwordPage.pk = chosenItem.pk;
                passwordPage.urlID = chosenItem.urlID;
                passwordPage.path = path;
                passwordPage.nav = nav;
                passwordPage.peepID = peepID;
                nav.push(passwordPage);
            }

        }

    }

    titleBar: TitleBar {
        id: check
        title: qsTr("Accounts List")
        visibility: ChromeVisibility.Visible

    }
    attachedObjects: [
        ComponentDefinition {
            id: passwordPageDefinition
            source: "Password.qml"
        },
        ComponentDefinition {
            id: pPageDefinition
            source: "access.qml"
        }
    ]
}
