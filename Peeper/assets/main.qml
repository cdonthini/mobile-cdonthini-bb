// Default empty project template
import bb.cascades 1.0

// creates one page with a label
Page {
    id: home
    Container {
        layout: StackLayout {

        }
        Label {
            text: qsTr("Password Keeper")
            textStyle.base: SystemDefaults.TextStyles.BigText
            verticalAlignment: VerticalAlignment.Center
            horizontalAlignment: HorizontalAlignment.Center
        }
        Button {
            id: addButton
            text: qsTr("Add")
            topMargin: 50.0
            bottomMargin: 50.0
            horizontalAlignment: HorizontalAlignment.Center
            verticalAlignment: VerticalAlignment.Center
            
        }
        Button {
            id: accessButton
            text: qsTr("Access")
            topMargin: 50.0
            bottomMargin: 50.0
            horizontalAlignment: HorizontalAlignment.Center
            verticalAlignment: VerticalAlignment.Center

        }
        Button {
            id: removeButton
            topMargin: 50.0
            bottomMargin: 50.0
            horizontalAlignment: HorizontalAlignment.Center
            verticalAlignment: VerticalAlignment.Center
            text: qsTr("Remove")

        }

    }
}

