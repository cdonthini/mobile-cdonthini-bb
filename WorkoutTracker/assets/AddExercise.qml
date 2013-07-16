import bb.cascades 1.0

Page {
    id: addeID
    signal setNumberchanged()
    property variant nav
    property alias title: titleLabel.text
    onSetNumberchanged: {
        if (setCount.text >= 6) {
            set1.visible = true;
            set2.visible = true;
            set3.visible = true;
            set4.visible = true;
            set5.visible = true;
            set6.visible = true;
        } else if (setCount.text == 5) {
            set1.visible = true;
            set2.visible = true;
            set3.visible = true;
            set4.visible = true;
            set5.visible = true;
            set6.visible = false;
        } else if (setCount.text == 4) {
            set1.visible = true;
            set2.visible = true;
            set3.visible = true;
            set4.visible = true;
            set5.visible = false;
            set6.visible = false;
        } else if (setCount.text == 3) {
            set1.visible = true;
            set2.visible = true;
            set3.visible = true;
            set4.visible = false;
            set5.visible = false;
            set6.visible = false;
        } else if (setCount.text == 2) {
            set1.visible = true;
            set2.visible = true;
            set3.visible = false;
            set4.visible = false;
            set5.visible = false;
            set6.visible = false;
        } else if (setCount.text == 1) {
            set1.visible = true;
            set2.visible = false;
            set3.visible = false;
            set4.visible = false;
            set5.visible = false;
            set6.visible = false;
        } else {
            set1.visible = false;
            set2.visible = false;
            set3.visible = false;
            set4.visible = false;
            set5.visible = false;
            set6.visible = false;
        }
    }
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
                    //homePage.nav = nav;
                }
                return homePage;
            }
            attachedObjects: [
                ComponentDefinition {
                    id: homePageDefinition
                    source: "main.qml"
                }
            ]
        }

    }
    ScrollView {
        Container {
            layout: StackLayout {
                orientation: LayoutOrientation.TopToBottom
            }

            
            clipContentToBounds: false
            Label {
                id: titleLabel
                text: ""
                horizontalAlignment: HorizontalAlignment.Center
                textStyle.fontSize: FontSize.XLarge
                textStyle.fontWeight: FontWeight.W400
            }
            Divider {

            }

            Container {
                layout: StackLayout {
                    orientation: LayoutOrientation.LeftToRight
                }
                Label {
                    text: qsTr("Date:")

                }
                Label {
                    id: dateLabel
                    text: {
                        var dmy = new Date();
                        dmy.toDateString()
                    }

                }

            }

            Container {

                layout: StackLayout {
                    orientation: LayoutOrientation.LeftToRight
                }
                Label {
                    text: qsTr("Workout Title:")
                    translationY: 20.0

                }
                TextField {
                    id: workoutTitle
                    hintText: qsTr("")

                }
            }
            Divider {

            }
            Container {

                Container {

                    layout: StackLayout {
                        orientation: LayoutOrientation.LeftToRight
                    }
                    Label {
                        text: qsTr("Number of Sets")
                        translationY: 20.0

                    }
                    TextField {
                        id: setCount
                        hintText: qsTr("# of Sets")
                        inputMode: TextFieldInputMode.NumbersAndPunctuation
                        onTextChanged: {
                            addeID.setNumberchanged();
                        }
                    }

                }
                Divider {

                }
                Container {
                    objectName: "repContainer"
                    layout: StackLayout {
                        orientation: LayoutOrientation.TopToBottom
                    }
                    Container {
                        layout: StackLayout {
                            orientation: LayoutOrientation.LeftToRight
                        }
                        Label {
                            text: qsTr("Reps with weights:")
                            translationY: 10.0
                        }
                        SegmentedControl {
                            id: weightControl

                            layoutProperties: StackLayoutProperties {
                                spaceQuota: 5.0
                            }

                            Option {
                                text: qsTr("lbs")
                                selected: true
                                value: "lbs"
                            }
                            Option {
                                text: qsTr("kgs")
                                value: "kgs"
                            }

                        }

                    }
                    Divider {
                    }
                }
                Container {
                    id: set1
                    layout: StackLayout {
                        orientation: LayoutOrientation.LeftToRight
                    }
                    visible: false
                    Label {
                        text: qsTr("Set # 1")
                        translationY: 20.0
                    }
                    TextField {
                        id: repOne
                        text: {
                            if(visible == false){
                                "not done";
                            }
                        }
                        hintText: qsTr("Rep #")
                        inputMode: TextFieldInputMode.NumbersAndPunctuation

                    }
                    TextField {
                        id: weightOne
                        text: {
                            if (visible == false) {
                                "not done";
                            }
                        }
                        hintText: qsTr("Weight")
                        inputMode: TextFieldInputMode.NumbersAndPunctuation

                    }
                }
                Container {
                    id: set2
                    layout: StackLayout {
                        orientation: LayoutOrientation.LeftToRight
                    }
                    visible: false
                    Label {
                        text: qsTr("Set # 2")
                        translationY: 20.0
                    }
                    TextField {
                        id: repTwo
                        text: {
                            if (visible == false) {
                                "not done";
                            }
                        }
                        hintText: qsTr("Rep #")
                        inputMode: TextFieldInputMode.NumbersAndPunctuation

                    }
                    TextField {
                        id: weightTwo
                        text: {
                            if (visible == false) {
                                "not done";
                            }
                        }
                        hintText: qsTr("Weight")
                        inputMode: TextFieldInputMode.NumbersAndPunctuation

                    }
                }
                Container {
                    id: set3
                    layout: StackLayout {
                        orientation: LayoutOrientation.LeftToRight
                    }
                    visible: false
                    Label {
                        text: qsTr("Set # 3")
                        translationY: 20.0
                    }
                    TextField {
                        id: repThree

                        hintText: qsTr("Rep #")
                        text: {
                            if (visible == false) {
                                "not done";
                            }
                        }
                        inputMode: TextFieldInputMode.NumbersAndPunctuation

                    }
                    TextField {
                        id: weightThree
                        hintText: qsTr("Weight")
                        text: {
                            if (visible == false) {
                                "not done";
                            }
                        }
                        inputMode: TextFieldInputMode.NumbersAndPunctuation

                    }
                }
                Container {
                    id: set4
                    layout: StackLayout {
                        orientation: LayoutOrientation.LeftToRight
                    }
                    visible: false
                    Label {
                        text: qsTr("Set # 4")
                        translationY: 20.0
                    }
                    TextField {
                        id: repFour
                        text: {
                            if (visible == false) {
                                "not done";
                            }
                        }
                        hintText: qsTr("Rep #")
                        inputMode: TextFieldInputMode.NumbersAndPunctuation

                    }
                    TextField {

                        id: weightFour
                        text: {
                            if (visible == false) {
                                "not done";
                            }
                        }
                        hintText: qsTr("Weight")
                        inputMode: TextFieldInputMode.NumbersAndPunctuation

                    }
                }
                Container {
                    id: set5
                    layout: StackLayout {
                        orientation: LayoutOrientation.LeftToRight
                    }
                    visible: false
                    Label {
                        text: qsTr("Set # 5")
                        translationY: 20.0
                    }
                    TextField {
                        id: repFive
                        text: {
                            if (visible == false) {
                                "not done";
                            }
                        }
                        hintText: qsTr("Rep #")
                        inputMode: TextFieldInputMode.NumbersAndPunctuation

                    }
                    TextField {
                        id: weightFive
                        text: {
                            if (visible == false) {
                                "not done";
                            }
                        }
                        hintText: qsTr("Weight")
                        inputMode: TextFieldInputMode.NumbersAndPunctuation

                    }
                }

                Container {
                    id: set6
                    layout: StackLayout {
                        orientation: LayoutOrientation.LeftToRight
                    }
                    visible: false
                    Label {
                        text: qsTr("Set # 6")
                        translationY: 20.0
                    }
                    TextField {
                        id: repSix

                        hintText: qsTr("Rep #")
                        text: {
                            if (visible == false) {
                                "not done";
                            }
                        }
                        inputMode: TextFieldInputMode.NumbersAndPunctuation

                    }
                    TextField {
                        id: weightSix
                        hintText: qsTr("Weight")
                        text: {
                            if (visible == false) {
                                "not done";
                            }
                        }
                        inputMode: TextFieldInputMode.NumbersAndPunctuation

                    }
                }
                Divider {
                }
                Button {

                    horizontalAlignment: HorizontalAlignment.Center

                    text: qsTr("Add")

                    onClicked: {
                        _app.addExercise(weightSix.text, repSix.text, 
                            weightFive.text, repFive.text, weightFour.text, 
                            repFour.text, weightThree.text, repThree.text, 
                            weightTwo.text, repTwo.text, weightOne.text, 
                            repOne.text, weightControl.selectedOption.text, 
                            setCount.text, workoutTitle.text, titleLabel.text, 
                            dateLabel.text, "picfilename");
                        
                        var page = getMuscleListPage();
                        nav.push(page);
                    }
                    property Page muscleListPage
                    function getMuscleListPage() {
                        if (! muscleListPage) {
                            muscleListPage = muscleListPageDefinition.createObject();
                            muscleListPage.nav = nav;
                        }
                        return muscleListPage;
                    }
                    attachedObjects: [
                        ComponentDefinition {
                            id: muscleListPageDefinition
                            source: "MuscleList.qml"
                        }
                    ]

                }
            }
        }
    }
}
