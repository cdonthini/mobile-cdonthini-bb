import bb.cascades 1.0
import bb.data 1.0
import WebPageComponent 1.0

NavigationPane {
    id: mainNavi
    onPopTransitionEnded: page.destroy()
    Page {
        titleBar: TitleBar {
            title: "IPL Teams"
            visibility: ChromeVisibility.Overlay
        }
        Container {
            onCreationCompleted: {
                teamsDataSource.load();
            }
            ListView {
                id: teamList
                dataModel: teamsDataModel
                listItemComponents: [
                    ListItemComponent {
                        type: "item"
                        Container {
                            horizontalAlignment: HorizontalAlignment.Center
                            layout: StackLayout {
                            }

                            // The Item content an image and a text
                            Container {
                                id: teamname
                                leftPadding: 3
                                horizontalAlignment: HorizontalAlignment.Fill
                                layout: StackLayout {
                                    orientation: LayoutOrientation.LeftToRight
                                }
                                ImageView {
                                    preferredWidth: 250
                                    preferredHeight: 168
                                    verticalAlignment: VerticalAlignment.Top
                                    imageSource: ListItemData.image
                                    scalingMethod: ScalingMethod.AspectFill
                                }
                                Label {
                                    text: ListItemData.name
                                    leftMargin: 30
                                    verticalAlignment: VerticalAlignment.Center
                                    textStyle.base: SystemDefaults.TextStyles.TitleText
                                } // Label
                            }
                            Divider {
                                preferredHeight: 3.0
                            } // Container
                        } // Container
                    }
                ]
                onTriggered: {
                    var feedTeam = teamsDataModel.data(indexPath);
                    teamDataSource.source = feedTeam.feed;
                    teamDataSource.load();
                    var page = teamNewsListings.createObject();
                    page.title = feedTeam.name;
                    mainNavi.push(page);
                }
            }
        }
    }
    attachedObjects: [
        GroupDataModel {
            id: teamsDataModel
            sortingKeys: [
                "order"
            ]
            grouping: ItemGrouping.None
        },
        DataSource {
            id: teamsDataSource
            source: "iplTeams.json"
            onDataLoaded: {
                teamsDataModel.clear();
                teamsDataModel.insertList(data);
            }
            onError: {
                console.log("JSON LOAD ERROR: [" + errorType + "]: " + errorMessage);
            }
        },
        GroupDataModel {
            id: teamDataModel
            grouping: ItemGrouping.None
        },
        DataSource {
            id: teamDataSource
            source: ""
            query: "/rss/channel/item"
            type: DataSource.Xml
            onDataLoaded: {
                teamDataModel.clear();
                teamDataModel.insertList(data);
            }
            onError: {
                console.log("JSON LOAD ERROR: [" + errorType + "]: " + errorMessage);
            }
        },
        ComponentDefinition {
            id: teamNewsListings
            Page {
                property alias title: titleLabel.text
                Container {
                    layout: DockLayout {
                    }
                    Container {
                        Container {
                            horizontalAlignment: HorizontalAlignment.Center
                            layout: DockLayout {
                            }
                            Label {
                                id: titleLabel
                                horizontalAlignment: HorizontalAlignment.Center
                                textStyle.textAlign: TextAlign.Center
                                textStyle.fontSize: FontSize.Medium
                            }
                        }
                        ListView {
                            dataModel: teamDataModel
                            listItemComponents: [
                                ListItemComponent {
                                    type: "item"
                                    ArticleItem {
                                        title: ListItemData.title
                                        pubDate: ListItemData.pubDate
                                    }
                                }
                            ]
                            onTriggered: {
                                var newsItem = teamDataModel.data(indexPath);
                                var page = newsPage.createObject();
                                page.htmlContent = newsItem.guid;
                                //page.htmlTitle = newsItem.description;
                                mainNavi.push(page);
                            }
                        } //listview - list
                    } //Container - title n list
                } //Container
            } //teamNewsListPage
        } //component Definition
,
        ComponentDefinition {
            id: newsPage
            Page {
                property alias htmlContent: newsWebPage.url
                //property alias htmlTitle: newsPageTitle.text
                Container {
                    ActivityIndicator {
                        id: indicator
                        enabled: true
                        running: true
                    }
                    Label {
                        id: newsPageTitle
                        multiline: true
                    }
                    attachedObjects: [
                        WebPage {
                            id: newsWebPage
                            onLoadingChanged: {
                                if (loadRequest.status == WebLoadStatus.Started) {
                                    indicator.stop();
                                } else if (loadRequest.status == WebLoadStatus.Failed) {
                                    newsPageTitle.setText("Load failed.")
                                }
                            }
                            onTitleChanged: {
                                newsPageTitle.setText(title)
                            }
                        }
                    ]
                }
            }
        }
    ]
}
