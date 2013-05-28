// Default empty project template
import bb.cascades 1.0
NavigationPane {
    id: mainNavi
    property bool dbOpen: false
    
    onPopTransitionEnded: page.destroy()

    // creates one page with a label
    Home {
        dbOpen: mainNavi.dbOpen
    }
}
