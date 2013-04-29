import bb.cascades 1.0


TabbedPane {
    id: mainTab
    showTabsOnActionBar: true
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
