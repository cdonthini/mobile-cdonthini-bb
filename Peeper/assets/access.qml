import bb.cascades 1.0

Page {
    id: accessPage

    property variant nav
    property variant path: 0
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
                        description: qsTr("User name: %1").arg(ListItemData.userName)

                        contextActions: [
                            ActionSet {
                                title: ListItemData.accountName
                                subtitle: "Account Options"
                                ActionItem {
                                    title: qsTr("Edit Account")
                                    onTriggered: {
                                        var selectedItem = dataModel.data(accountItem.ListItem.indexPath);
                                        var passwordPageEdit = passwordPageDefinitionEdit.createObject();
                                        passwordPageEdit.accountName = selectedItem.accountName;
                                        passwordPageEdit.userName = selectedItem.userName;
                                        passwordPageEdit.passWord = selectedItem.passWord;
                                        passwordPageEdit.tag = selectedItem.tag;
                                        passwordPageEdit.pk = selectedItem.pk;
                                        passwordPageEdit.path = 1;
                                        passwordPageEdit.nav = nav;

                                        nav.push(passwordPageEdit);
                                    }
                                    attachedObjects: [
                                        ComponentDefinition {
                                            id: passwordPageDefinitionEdit
                                            source: "password.qml"
                                        }
                                    ]
                                    imageSource: "asset:///png/ic_edit.png"
                                }
                                ActionItem {
                                    title: qsTr("Remove Account")
                                    onTriggered: {
                                        path = 2;
                                        accountItem.ListItem.view.triggered();
                                    }

                                } // remove action item
                            } //action set
                        ] //actions
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
                passwordPage.path = path;
                passwordPage.nav = nav;

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
            source: "password.qml"
        }
    ]
}
