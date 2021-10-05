//
//  ViewModel.swift
//  Feeds
//
//  Created by Sarathi M on 9/14/21.
//

import Foundation

protocol ViewModelToViewDelegate {
    func dataReceived()
}

class ViewModel: ViewModelDelegate {
    var delegate: ViewModelToViewDelegate?

    var feed: Feed? {
        didSet {
            //once feed variable is set data received protocol method has been called
            self.delegate?.dataReceived()
        }
    }
    
    //fetch Data is for loading data for the first time
    func fetchData(url: String = "https://www.reddit.com/.json") {
        RequestManager().downloadData(url: url) { [unowned self] (feedObj) in
            //update ui in main queue
            DispatchQueue.main.async {
                self.feed = feedObj
            }
        }
    }
    
    //load more method is called during infinte scroll of an tableview
    func loadMore() {
        guard let after = feed?.data?.after else {
            return
        }
        //after is used from the most recent request made
        let url = "http://www.reddit.com/.json?after=" + after
        
        RequestManager().downloadData(url: url) { [unowned self] (feedObj: Feed) in
            DispatchQueue.main.async {
                //once next set of data received, it is added to the <feed.data.children> array
                if let child = feedObj.data?.children {
                    self.feed?.data?.children?.append(contentsOf: child)
                }
                //update <feed.data.after> link to the most recent one received. so here after if user scroll app will fetch next set of data
                self.feed?.data?.after = feedObj.data?.after
            }
        }
    }

}
