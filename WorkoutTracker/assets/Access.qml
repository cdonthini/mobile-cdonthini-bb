import bb.cascades 1.0

Page {
    property variant nav
    
    titleBar: TitleBar {
        id: check
        title: qsTr("Workouts")
        visibility: ChromeVisibility.Visible

    }
    Container {
        ListView {
            id: listView
            dataModel: _app.dataModel
            
            listItemComponents: [
                ListItemComponent {
                    type: "item"
                    StandardListItem {
                        id: workoutItem
                        title: ListItemData.MUSCLE
                        description: "Workout:" + ListItemData.TITLE
                    }
                }
            ]
        }
    }
}
