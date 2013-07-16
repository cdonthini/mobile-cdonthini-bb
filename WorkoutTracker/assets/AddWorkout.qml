import bb.cascades 1.0

Page {
    property variant nav
    property alias title: titleLabel.text
    Container {
        layout: StackLayout {
            orientation: LayoutOrientation.TopToBottom
        }

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
                text: {
                    var dmy = new Date();
                    "                    " + dmy.toDateString()
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

            layout: StackLayout {
                orientation: LayoutOrientation.LeftToRight
            }
            Label {
                text: qsTr("Number of Sets")
                translationY: 20.0

            }
            Picker {
                id: setCount
                dataModel: XmlDataModel {
                    source: "sets.xml"
                }
                pickerItemComponents: [
                    PickerItemComponent {
                        type: "number"
                        content: Container {
                            Label {
                                text: pickerItemData.text
                            }
                        }
                    }
                ]

                onSelectedValueChanged: {
                    title = setCount.selectedIndex(0) + 1;
                }

                objectName: "setPicker"
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
            DropDown {
                id: dd1
                title: qsTr("Rep # 1")
                Option {
                    
                }
            }
            Picker {
                id: repPicker1
                title: qsTr("Rep # 1")

                rootIndexPath: []
                dataModel: XmlDataModel {
                    source: "reps.xml"
                }
                
                enabled : {
                    if ( setCount.selectedIndex(0) == 0) {
                        true
                    }
                    else false;
                }
                pickerItemComponents: [
                    PickerItemComponent {
                        type: "reps"
                        content: Container {
                            Label {
                                id: repsPicked
                                text: pickerItemData.text
                            }
                        }
                    },
                    PickerItemComponent {
                        type: "weight"
                        content: Container {
                            Label {
                                id: weightPicked
                                text: {
                                    if (weightControl.selectedIndex == 0) {
                                    pickerItemData.lbs
                                }
                                    else {
                                        pickerItemData.kgs
                                    }
                                }
                               
                            }
                        }
                    }
                ]

                onSelectedValueChanged: {
                    var index0 = repPicker1.selectedIndex(0);
                    var index1 = repPicker1.selectedIndex(1);
                    title = title + "   reps"+ repPicker1.selectedValue
                    console.log("Selection: " + index0 + ", " + index1);
                }
                translationX: 10.0
                expanded: true
                preferredRowCount: 6
            }
            Picker {
                id: repPicker2
                title: qsTr("Rep # 2")

                rootIndexPath: []
                dataModel: XmlDataModel {
                    source: "reps.xml"
                }
                enabled: {
                    if (setCount.selectedIndex(0) > 1) {
                        true
                    } else false;
                }
                pickerItemComponents: [
                    PickerItemComponent {
                        type: "reps"

                        content: Container {
                            Label {
                                text: pickerItemData.text
                            }
                        }
                    },
                    PickerItemComponent {
                        type: "weight"

                        content: Container {
                            Label {

                                text: {
                                    if (weightControl.selectedIndex == 0) {
                                        pickerItemData.lbs
                                    } else {
                                        pickerItemData.kgs
                                    }
                                }

                            }
                        }
                    }
                ]

                onSelectedValueChanged: {
                    var index0 = repPicker2.selectedIndex(0);
                    var index1 = repPicker2.selectedIndex(1);
                    console.log("Selection: " + index0 + ", " + index1);
                }
                translationX: 10.0
            }
            Picker {
                id: repPicker3
                title: qsTr("Rep # 3")

                rootIndexPath: []
                dataModel: XmlDataModel {
                    source: "reps.xml"
                }
                enabled: {
                    if (setCount.selectedIndex(0) > 2) {
                        true
                    } else false;
                }
                pickerItemComponents: [
                    PickerItemComponent {
                        type: "reps"

                        content: Container {
                            Label {
                                text: pickerItemData.text
                            }
                        }
                    },
                    PickerItemComponent {
                        type: "weight"

                        content: Container {
                            Label {

                                text: {
                                    if (weightControl.selectedIndex == 0) {
                                        pickerItemData.lbs
                                    } else {
                                        pickerItemData.kgs
                                    }
                                }

                            }
                        }
                    }
                ]

                onSelectedValueChanged: {
                    var index0 = repPicker3.selectedIndex(0);
                    var index1 = repPicker3.selectedIndex(1);
                    console.log("Selection: " + index0 + ", " + index1);
                }
                translationX: 10.0
            }

            Picker {
                id: repPicker4
                title: qsTr("Rep # 4")

                rootIndexPath: []
                dataModel: XmlDataModel {
                    source: "reps.xml"
                }
                enabled: {
                    if (setCount.selectedIndex(0) > 3) {
                        true
                    } else false;
                }
                pickerItemComponents: [
                    PickerItemComponent {
                        type: "reps"

                        content: Container {
                            Label {
                                text: pickerItemData.text
                            }
                        }
                    },
                    PickerItemComponent {
                        type: "weight"

                        content: Container {
                            Label {

                                text: {
                                    if (weightControl.selectedIndex == 0) {
                                        pickerItemData.lbs
                                    } else {
                                        pickerItemData.kgs
                                    }
                                }

                            }
                        }
                    }
                ]

                onSelectedValueChanged: {
                    var index0 = repPicker4.selectedIndex(0);
                    var index1 = repPicker4.selectedIndex(1);
                    console.log("Selection: " + index0 + ", " + index1);
                }
                translationX: 10.0
            }

            Picker {
                id: repPicker5
                title: qsTr("Rep # 5")

                rootIndexPath: []
                dataModel: XmlDataModel {
                    source: "reps.xml"
                }
                enabled: {
                    if (setCount.selectedIndex(0) > 4) {
                        true
                    } else false;
                }
                pickerItemComponents: [
                    PickerItemComponent {
                        type: "reps"

                        content: Container {
                            Label {
                                text: pickerItemData.text
                            }
                        }
                    },
                    PickerItemComponent {
                        type: "weight"

                        content: Container {
                            Label {

                                text: {
                                    if (weightControl.selectedIndex == 0) {
                                        pickerItemData.lbs
                                    } else {
                                        pickerItemData.kgs
                                    }
                                }

                            }
                        }
                    }
                ]

                onSelectedValueChanged: {
                    var index0 = repPicker5.selectedIndex(0);
                    var index1 = repPicker5.selectedIndex(1);
                    console.log("Selection: " + index0 + ", " + index1);
                }
                translationX: 10.0
            }

            Picker {
                id: repPicker6
                title: qsTr("Rep # 6")

                rootIndexPath: []
                dataModel: XmlDataModel {
                    source: "reps.xml"
                }
                enabled: {
                    if (setCount.selectedIndex(0) > 5) {
                        true
                    } else false;
                }
                pickerItemComponents: [
                    PickerItemComponent {
                        type: "reps"

                        content: Container {
                            Label {
                                text: pickerItemData.text
                            }
                        }
                    },
                    PickerItemComponent {
                        type: "weight"

                        content: Container {
                            Label {

                                text: {
                                    if (weightControl.selectedIndex == 0) {
                                        pickerItemData.lbs
                                    } else {
                                        pickerItemData.kgs
                                    }
                                }

                            }
                        }
                    }
                ]

                onSelectedValueChanged: {
                    var index0 = repPicker6.selectedIndex(0);
                    var index1 = repPicker6.selectedIndex(1);
                    console.log("Selection: " + index0 + ", " + index1);
                }
                translationX: 10.0
            }
        }
        Divider {
            
        }
        Button {
            
            horizontalAlignment: HorizontalAlignment.Center
            translationY: -30.0

        }
    }
}
