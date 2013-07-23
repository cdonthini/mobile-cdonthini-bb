import bb.cascades 1.0

Page {
    id: homePage
    property variant nav
    property variant peepID
    actionBarVisibility: ChromeVisibility.Hidden
    onCreationCompleted: {
        Application.asleep.connect(onAsleep);
    }
    function onAsleep() {
        var pPage = pPageDefinition.createObject();
        //_app.alert("homepage asleep");
        pPage.nav = nav;
        pPage.peepID = peepID;
        nav.push(pPage);
    }
    attachedObjects: [
        ComponentDefinition {
            id: pPageDefinition
            source: "Home.qml"
        }
    ]
    Container {
        layout: DockLayout {

        }
        
        ImageView {
            id: background
            imageSource: "asset:///png/Key-lock-chain-AG-large.jpg"

            verticalAlignment: VerticalAlignment.Fill
            horizontalAlignment: HorizontalAlignment.Fill
            translationY: 115.0
            opacity: 0.9

        }
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
                imageSource: "//assets/png/ic_add.png"

            }
            Button {
                imageSource: "asset:///png/ic_view_list.png"
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
            }
        }

    }
}
