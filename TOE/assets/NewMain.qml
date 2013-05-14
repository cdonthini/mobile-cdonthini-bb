import bb.cascades 1.0
import bb.system 1.0

TabbedPane {
    property variant menu
    Menu.definition: menu
    id: mainTab
    
    activeTab: naviStyle
    Tab {
        id: naviStyle
        title: "cascades"
        Main {
            id: homePage
        }
    }
    Tab {
        id: datepicker
        title: "Date Picker"
        DatePicker {
        }
    }
    attachedObjects: [
        ComponentDefinition {
            id: menuId
            source: "Menu.qml"
        }
    ]
    onCreationCompleted: {
        
        // Create the app menu for the cookbook.
        menu = menuId.createObject();
    }
    showTabsOnActionBar: true

}
