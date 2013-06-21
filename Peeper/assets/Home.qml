import bb.cascades 1.0

Page {
    id: homePage
    property variant nav
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
            topMargin: 100.0
            bottomMargin: 50.0
            horizontalAlignment: HorizontalAlignment.Center
            verticalAlignment: VerticalAlignment.Center

            onClicked: {

                // show Add page when the button is clicked
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
            imageSource: "//assets/png/ic_add.png"

        }
        Button {
            imageSource: "//assets/png/ic_view_list.png"
            id: accessButton
            text: qsTr("Access")
            enabled: _app.dbOpenPublic
            topMargin: 50.0
            bottomMargin: 50.0
            horizontalAlignment: HorizontalAlignment.Center
            verticalAlignment: VerticalAlignment.Center
            onClicked: {
                _app.readRecords();
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
        }
        Container {
            layout: DockLayout {

            }
            horizontalAlignment: HorizontalAlignment.Center
            ImageView {
                
                imageSource: "asset:///png/setupCover.png"
                loadEffect: ImageViewLoadEffect.FadeZoom
                preferredHeight: 400.0
                preferredWidth: 600.0

            }
        }

    }
}
