import bb.cascades 1.0
import bb.system 1.0

MenuDefinition {
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

                // show detail page when the button is clicked
                var page = getSourcePage();
                console.debug("pushing detail " + page)
                nav.push(page);
            }
            property Page sourcePage
            function getSourcePage() {
                if (! sourcePage) {
                    sourcePage = sourcePageDefinition.createObject();
                }
                return sourcePage;
            }
        }
    ]
    attachedObjects: [
        SystemToast {
            id: toast
            body: "Toasty"
        },
        ComponentDefinition {
            id: sourcePageDefinition
            source: "SourceCode.qml"
        }
    ]
}
