import bb.cascades 1.0

NavigationPane {
    Page {
        paneProperties: {
            Color.Blue
        }
        titleBar: TitleBar {
            title: "Pick Your Birthday"
        }
        Container {
            layout: StackLayout {
            }
            horizontalAlignment: HorizontalAlignment.Center
            DateTimePicker {
                id: dob
                title: "Date of Birth"
                value: "1991-06-9"
                expanded: true
                horizontalAlignment: HorizontalAlignment.Center
            }
            Divider {
            }
            SegmentedControl {
                id: control
                Option {
                    id: years
                    text: "Years"
                    value: "1"
                    description: "Get the age in years"
                    selected: true
                }
                Option {
                    id: months
                    value: "2"
                    text: "Months"
                    description: "Get the age in months"
                }
                Option {
                    id: days
                    value: "3"
                    text: "Days"
                    description: "Get the age in days"
                }
                onSelectedIndexChanged: {
                    if (control.selectedValue == 1) {
                        ageLabel.text = age(control.selectedValue);
                    } else if (control.selectedValue == 2) {
                        ageLabel.text = age(control.selectedValue);
                    } else if (control.selectedValue == 3) {
                        ageLabel.text = age(control.selectedValue);
                    }
                }
                property alias result: ageLabel.text
                function age(option) {
                    var dmy = new Date();
                    var days = ((30 - parseInt(dob.value.getDate()) ) + dmy.getDate() );
                    var months = (12 - parseInt(dob.value.getMonth())) + dmy.getMonth() + parseInt(days / 30);
                    var years = dmy.getFullYear() - 1 - parseInt(dob.value.getFullYear()) + parseInt(months / 12);
                    if (option == 1) {
                        result = years + " Years " + months % 12 + " Months " + days % 30 + " Days " + " old "
                    }
                    else if (option == 2) {
                        result = ((years * 12 ) + (months % 12 ) ) + " Months " + days % 30 + " Days " + " old "
                    }
                    else if (option == 3) {
                        result = (((years * 12 ) + (months % 12 ) ) * 30 ) + days % 30 + " Days " + " old "
                    }
                    return result;
                }
            }
            Divider {
            }
            Label {
                id: ageLabel

                multiline: true
                horizontalAlignment: HorizontalAlignment.Center
            }
        }
    }
}
