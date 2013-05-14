import bb.cascades 1.0
import bb.data 1.0

NavigationPane {
    id: navPane

    onPopTransitionEnded: page.destroy()

    // The main page
    Page {
        Container {
            layout: DockLayout {}

            ImageView {
                horizontalAlignment: HorizontalAlignment.Fill
                verticalAlignment: VerticalAlignment.Fill

                
            }

            Container {
                horizontalAlignment: HorizontalAlignment.Fill
                verticalAlignment: VerticalAlignment.Fill

                Container {
                    horizontalAlignment: HorizontalAlignment.Center
                    layout: DockLayout {}

                    ImageView {
                        horizontalAlignment: HorizontalAlignment.Fill
                        verticalAlignment: VerticalAlignment.Fill

                        
                    }

                    Label {
                        horizontalAlignment: HorizontalAlignment.Center

                        text: qsTr ("IPL")
                        textStyle.base: SystemDefaults.TextStyles.BigText
                        textStyle.color: Color.create("#bbffffff")
                    }
                }

                //! [0]
                // A control to switch between the two news sources
                SegmentedControl {
                    id: newsSources

                    options: [
                        Option {
                            text: qsTr ("IPL")
                            value: "iplTeams.json"
                        },
                        Option {
                            text: qsTr ("Yahoo!")
                            value: "yahoorssfeeds.json"
                        }
                    ]

                    onSelectedOptionChanged: {
                        if (selectedOption != 0) {
                            feedsDataSource.source = selectedOption.value;
                            feedsDataSource.load();
                        }
                    }

                    onCreationCompleted: {
                        if (selectedOption != 0) {
                            feedsDataSource.source = selectedOption.value;
                            feedsDataSource.load();
                        }
                    }
                }
                //! [0]

                //! [1]
                // A list view that shows all the categories of a news source
                ListView {
                    dataModel: feedsDataModel

                    listItemComponents: [
                        ListItemComponent {
                            type: "item"
                            Container {
                                leftPadding: 30
                                preferredWidth: 768
                                preferredHeight: 100

                                layout: DockLayout {}

                                Label {
                                    verticalAlignment: VerticalAlignment.Center

                                    text: ListItemData.name
                                    
                                    textStyle.base: SystemDefaults.TextStyles.TitleText
                                    textStyle.color: Color.White
                                }

                                Divider {
                                    verticalAlignment: VerticalAlignment.Bottom
                                }
                            }
                        }
                    ]

                    onTriggered: {
                        var feedItem = feedsDataModel.data(indexPath);
                        articlesDataSource.source = feedItem.feed;
                        articlesDataSource.load();

                        var page = newsListings.createObject();
                        page.title = newsSources.selectedOption.text + ": " + feedItem.name
                        navPane.push(page);
                    }
                }
                //! [1]
            }
        }
    }

    attachedObjects: [
        //! [2]
        // The data model that contains the content of a JSON file
        GroupDataModel {
            id: feedsDataModel
            sortingKeys: ["order"]
            grouping: ItemGrouping.None
        },

        // The data source that fills the above model with the content of a JSON file
        DataSource {
            id: feedsDataSource
            source: ""
            onDataLoaded: {
                feedsDataModel.clear();
                feedsDataModel.insertList(data);
            }
            onError: {
                console.log("JSON Load Error: [" + errorType + "]: " + errorMessage);
            }
        },
        //! [2]

        //! [3]
        // The data model that contains the articles from a RSS feed
        GroupDataModel {
            id: articlesDataModel
            sortingKeys: ["pubDate"]
            sortedAscending: false
            grouping: ItemGrouping.None
        },

        // The data source that fills the above model with the articles
        DataSource {
            id: articlesDataSource
            source: ""
            query: "/rss/channel/item"
            type: DataSource.Xml
            onDataLoaded: {
                articlesDataModel.clear();
                articlesDataModel.insertList(data);
            }
            onError: {
                console.log("RSS Load Error[" + errorType + "]: " + errorMessage);
            }
        },
        //! [3]

        //! [4]
        // The dynamically loaded page to show the list of articles from a RSS feed
        ComponentDefinition {
            id: newsListings
            Page {
                property alias title : titleLabel.text

                Container {
                    layout: DockLayout {}

                    ImageView {
                        horizontalAlignment: HorizontalAlignment.Fill
                        verticalAlignment: VerticalAlignment.Fill

                    }

                    Container {
                        Container {
                            horizontalAlignment: HorizontalAlignment.Center
                            layout: DockLayout {}

                            ImageView {
                                horizontalAlignment: HorizontalAlignment.Fill
                                verticalAlignment: VerticalAlignment.Fill

                            }

                            Label {
                                id: titleLabel

                                horizontalAlignment: HorizontalAlignment.Center

                                textStyle.base: SystemDefaults.TextStyles.BigText
                                textStyle.color: Color.create("#bbffffff")
                            }
                        }

                        ListView {
                            dataModel: articlesDataModel
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
                                var feedItem = articlesDataModel.data(indexPath);

                                var page = detailPage.createObject();
                                page.htmlContent = feedItem.description;
                                navPane.push(page);
                            }
                        }
                    }
                }
            }
        },
        //! [4]

        //! [5]
        // The dynamically loaded page to show an article in a webview
        ComponentDefinition {
            id: detailPage
            Page {
                property alias htmlContent: detailView.html

                Container {
                    ScrollView {
                        scrollViewProperties.scrollMode: ScrollMode.Vertical

                        WebView {
                            id: detailView;
                        }
                    }
                }
            }
        }
        //! [5]
    ]
}
