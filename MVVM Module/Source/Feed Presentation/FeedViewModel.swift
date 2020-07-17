//
//  Copyright © 2019 Essential Developer. All rights reserved.
//

import Foundation
import FeedFeature

final class FeedViewModel {
	typealias Observer<T> = (T) -> Void
	
	private let feedLoader: FeedLoader
	
	init(feedLoader: FeedLoader) {
		self.feedLoader = feedLoader
	}
	
    var title: String {
        localized("FEED_VIEW_TITLE",
                  comment: "Title for the feed view")
    }
    
    var loadingFeedErrorMessage: String {
        localized("LOADING_FEED_ERROR_MESSAGE",
                  comment: "Error message when feed loading fails")
    }
    
	var onLoadingStateChange: Observer<Bool>?
	var onFeedLoad: Observer<[FeedImage]>?
    var onFeedLoadFails: Observer<String?>?
	
	func loadFeed() {
		onLoadingStateChange?(true)
		feedLoader.load { [weak self] result in
            do {
                let feed = try result.get()
				self?.onFeedLoad?(feed)
            } catch {
                self?.onFeedLoadFails?(self?.loadingFeedErrorMessage)
            }
			self?.onLoadingStateChange?(false)
		}
	}
    
    private func localized(_ key: String, comment: String) -> String {
        return NSLocalizedString(key,
                                 tableName: "Feed",
                                 bundle: Bundle(for: FeedViewModel.self),
                                 comment: comment)
    }
}
