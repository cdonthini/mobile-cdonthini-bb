import bb.cascades 1.0

Page {
    id: homePage
    property bool dbOpen: false
    actionBarVisibility: ChromeVisibility.Hidden
    Container {
        layout: StackLayout {

        }
        Label {
            text: qsTr("Password Keeper")
            textStyle.base: SystemDefaults.TextStyles.BigText
            verticalAlignment: VerticalAlignment.Center
            horizontalAlignment: HorizontalAlignment.Center
        }
        Divider {

        }
        Button {
            id: addButton
            text: qsTr("Add")
            topMargin: 50.0
            bottomMargin: 50.0
            horizontalAlignment: HorizontalAlignment.Center
            verticalAlignment: VerticalAlignment.Center
            onClicked: {
                homePage.dbOpen = _app.initDatabase();
                // show Add page when the button is clicked
                var page = getAddPage();
                mainNavi.push(page);
            }
            property Page addPage
            function getAddPage() {
                if (! addPage) {
                    addPage = addPageDefinition.createObject();
                    addPage.nav = mainNavi;
                    addPage.dbOpen = dbOpen;
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
        Button {
            id: accessButton
            text: qsTr("Access")
            enabled: dbOpen
            topMargin: 50.0
            bottomMargin: 50.0
            horizontalAlignment: HorizontalAlignment.Center
            verticalAlignment: VerticalAlignment.Center
            onClicked: {
                // show detail page when the button is clicked
                var page = getAccessPage();
                mainNavi.push(page);
            }
            property Page accessPage
            function getAccessPage() {
                if (! accessPage) {
                    accessPage = accessPageDefinition.createObject();
                    accessPage.nav = mainNavi;
                }
                return accessPage;
            }
            attachedObjects: [
                ComponentDefinition {
                    id: accessPageDefinition
                    source: "access.qml"
                }
            ]
        }
        Button {
            id: removeButton
            topMargin: 50.0
            bottomMargin: 50.0
            horizontalAlignment: HorizontalAlignment.Center
            verticalAlignment: VerticalAlignment.Center
            text: qsTr("Remove")
            enabled: dbOpen
            onClicked: {
                // show detail page when the button is clicked
                var page = getRemovePage();
                mainNavi.push(page);
            }
            property Page removePage
            function getRemovePage() {
                if (! removePage) {
                    removePage = removePageDefinition.createObject();
                    removePage.nav = mainNavi;
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

    }
}
