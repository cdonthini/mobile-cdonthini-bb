import bb.cascades 1.0
import bb.data 1.0

Page {
    property variant nav

    Container {

        onCreationCompleted: {
            muscleListDataSource.load();
        }
        ListView {
            id: muscleList
            dataModel: muscleListDataModel
            listItemComponents: [
                ListItemComponent {
                    type: "item"
                    Container {
                        layout: StackLayout {

                        }
                        Container {
                            id: musclename
                            Label {
                                text: ListItemData.name
                                textStyle.base: SystemDefaults.TextStyles.TitleText
                                topMargin: 10.0
                                bottomMargin: 10.0
                            }
                        }
                        Divider {
                            preferredHeight: 3.0
                        }
                    }
                }
            ]
            onTriggered: {
                var feedMuscle = muscleListDataModel.data(indexPath);
                //muscleListDataSource.source = feedMuscle.feed;
                muscleListDataSource.load();
                var page = addWorkoutDefinition.createObject();
                page.title = feedMuscle.name;
                page.nav = nav;
                nav.push(page);
            }

        }
    }
    attachedObjects: [
        GroupDataModel {
            id: muscleListDataModel
            sortingKeys: [ "order" ]
            grouping: ItemGrouping.None
        },
        DataSource {
            id: muscleListDataSource
            source: "muscles.json"
            onDataLoaded: {
                muscleListDataModel.clear();
                muscleListDataModel.insertList(data);
            }
            onError: {
                console.log("JSON LOAD ERROR: [" + errorType + "] : " + errorMessage);
            }
        },
        ComponentDefinition {
            id: addWorkoutDefinition
            source: "AddExercise.qml"
        }
    ]
    titleBar: TitleBar {
        title: qsTr("Muscle List")

    }
}
