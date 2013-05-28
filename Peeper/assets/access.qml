import bb.cascades 1.0

Page {
    property variant nav
    property bool dbOpen
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
            
            horizontalAlignment: HorizontalAlignment.Right
            verticalAlignment: VerticalAlignment.Bottom
           text: {
               if(dbOpen){
                   "db is open"
               }
               else "db is closed";
           }
        }
       
        
    }
    
    
}
