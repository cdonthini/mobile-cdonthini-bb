import bb.cascades 1.0

Page {
    id: yearPage
    property variant nav
    property variant monthnum
    property variant dayname
    titleBar: TitleBar {
        title: "Pick Your Birth Year"
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
            id: yearList
            dataModel: XmlDataModel {
                source: "models/years.xml"
            }
            layoutProperties: StackLayoutProperties {
                spaceQuota: 1.0
            }
            listItemComponents: [
                ListItemComponent {
                    type: "year"
                    StandardListItem {
                        title: {
                            ListItemData.yearname
                        }
                    }
                }
            ]
            onTriggered: {
                var chosenItem = dataModel.data(indexPath);
                var answerPage = ansDefinition.createObject();
                answerPage.nav = nav;
                answerPage.yearname = chosenItem.yearname;
                answerPage.monthnum = monthnum;
                answerPage.dayname = dayname;
                nav.push(answerPage);
            }
        }
    }
    attachedObjects: [
        ComponentDefinition {
            id: ansDefinition
            source: "resultsPage.qml"
        }
    ]
}
