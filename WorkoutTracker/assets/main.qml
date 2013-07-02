import bb.cascades 1.0

NavigationPane {
    id: navigationPane
    Page {

        Container {
            layout: StackLayout {
            }

            Label {
                text: qsTr("Workout Tracker")
                textStyle.fontSize: FontSize.XXLarge
                textStyle.fontWeight: FontWeight.Bold
                textStyle.color: Color.Black
                textStyle.textAlign: TextAlign.Center
                horizontalAlignment: HorizontalAlignment.Center

            }
            Divider {
                bottomMargin: 60.0
                topMargin: 30.0
                visible: true

            }
            Button {
                horizontalAlignment: HorizontalAlignment.Fill
                verticalAlignment: VerticalAlignment.Center
                text: qsTr("Log It In ->")

                onClicked: {
                    // show detail page when the button is clicked
                    var page = getMuscleList();
                    console.debug("pushing detail " + page)
                    navigationPane.push(page);
                }
                property Page muscleList
                function getMuscleList() {
                    if (! muscleList) {
                        muscleList = muscleListDefinition.createObject();
                        muscleList.nav = navigationPane;
                    }
                    return muscleList;
                }
                attachedObjects: [
                    ComponentDefinition {
                        id: muscleListDefinition
                        source: "MuscleList.qml"
                    }
                ]

            }

            Button {
                text: qsTr("Check ->")

                onClicked: {
                    // show detail page when the button is clicked
                    var page = getCheckPage();
                    console.debug("pushing detail " + page)
                    navigationPane.push(page);
                }
                property Page checkPage
                function getCheckPage() {
                    if (! checkPage) {
                        checkPage = checkDefinition.createObject();
                        checkPage.nav = navigationPane;
                    }
                    return checkPage;
                }
                attachedObjects: [
                    ComponentDefinition {
                        id: checkDefinition
                        source: "Access.qml"
                    }
                ]

                verticalAlignment: VerticalAlignment.Center
                horizontalAlignment: HorizontalAlignment.Fill

            }

            Button {
                text: qsTr("Add a picture ->")

                onClicked: {
                    // show detail page when the button is clicked
                    var page = getPicPage();
                    console.debug("pushing detail " + page)
                    navigationPane.push(page);
                }
                property Page picPage
                function getPicPage() {
                    if (! picPage) {
                        picPage = picDefinition.createObject();
                        picPage.nav = navigationPane;
                    }
                    return picPage;
                }
                attachedObjects: [
                    ComponentDefinition {
                        id: picDefinition
                        source: "Pic.qml"
                    }
                ]
                verticalAlignment: VerticalAlignment.Center
                horizontalAlignment: HorizontalAlignment.Fill

            }

        }
    }
    onCreationCompleted: {
        // this slot is called when declarative scene is created
        // write post creation initialization here
        console.log("NavigationPane - onCreationCompleted()");

        // enable layout to adapt to the device rotation
        // don't forget to enable screen rotation in bar-bescriptor.xml (Application->Orientation->Auto-orient)
        OrientationSupport.supportedDisplayOrientation = SupportedDisplayOrientation.All;
    }
}
