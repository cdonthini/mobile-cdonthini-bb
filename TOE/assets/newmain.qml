import bb.cascades 1.0
import bb.system 1.0

TabbedPane {
    Menu.definition: MenuDefinition {
        id: menu
        settingsAction: SettingsActionItem {
            onTriggered: {
                toast.body = "Settings"
                toast.show();
            }
        }
        helpAction: HelpActionItem {
            onTriggered: {
                toast.body = "You can find your age in years, months and days given your date of birth by clicking the Date Picker tab. You can also use the cascade tab to find your age in years. "
                toast.show();
            }
        }
        actions: [
            ActionItem {
                title: "Source Code"
                onTriggered: {
                    toast.body = "http://mksintegrity:7001/im/viewissue?selection=7168879"
                    toast.show();
                }
            }
        ]
        attachedObjects: [
            SystemToast {
                id: toast
                body: "Toasty"
            }
        ]
    }
    id: mainTab
    showTabsOnActionBar: true
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
}
