import bb.cascades 1.0

Page {
    id: monthPage
    property variant nav
    property variant dayname
    titleBar: TitleBar {
        title: "Pick Your Birth Month"
    }
    Container {
        background: backgroundPaint.imagePaint
                attachedObjects: [
                        ImagePaintDefinition {
                            id: backgroundPaint
                            imageSource: "asset:///images/background.amd"
                            repeatPattern: RepeatPattern.XY
                        }
                    ]
        ListView {
            id: monthList
            dataModel: XmlDataModel {
                source: "models/months.xml"
            }
            layoutProperties: StackLayoutProperties {
                spaceQuota: 1.0
            }
            listItemComponents: [
                ListItemComponent {
                    type: "month"
                    StandardListItem {
                        title: {
                            ListItemData.monthname
                        }
                    }
                }
            ]
            onTriggered: {
                var chosenItem = dataModel.data(indexPath);
                var yearPage = pickYearDefinition.createObject();
                yearPage.nav = nav;
                yearPage.monthnum = chosenItem.monthnum;
                yearPage.dayname = dayname;
                nav.push(yearPage);
            }
        }
    }
    attachedObjects: [
        ComponentDefinition {
            id: pickYearDefinition
            source: "pickYear.qml"
        }
    ]
}
