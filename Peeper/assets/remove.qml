import bb.cascades 1.0

Page {
    id: removePage
    
    property variant nav
    
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
            text: _app.check()
            textStyle.fontSize: FontSize.XXLarge

        }
    }
}
