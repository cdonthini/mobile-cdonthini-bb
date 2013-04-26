import bb.cascades 1.0

Page {
    id: dayPage
    property variant nav
    
    titleBar: TitleBar {
        title: "Pick Your Birth Date"
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
            id: dayList
            dataModel: XmlDataModel {
                source: "models/days.xml"
            }
            layoutProperties: StackLayoutProperties {
                spaceQuota: 1.0
            }
            listItemComponents: [
                 ListItemComponent {
                     type: "day"
                     StandardListItem {
                        title: {
                         ListItemData.dayname   
                        }
                        
                    }
                 }  
            ]
            
            onTriggered: {
                    var chosenItem = dataModel.data(indexPath);
                    
                    var monthPage = pickMonthDefinition.createObject();
                    monthPage.nav = nav;
                    monthPage.dayname = chosenItem.dayname;
                    nav.push(monthPage);
            }
        }
    }
    attachedObjects: [
            ComponentDefinition {
                id: pickMonthDefinition
                source: "pickMonth.qml"
            }
        ]
}

