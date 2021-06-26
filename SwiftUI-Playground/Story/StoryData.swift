//
//  StoryData.swift
//  SwiftUI-Playground
//
//  Created by Anthony Da cruz on 24/06/2021.
//

import Foundation
import Combine
import UIKit



var storyDataList: [StoryData] = [
    StoryData(id: 1, imageUrl: URL(string: "https://picsum.photos/200/300")!, title: "Title 1"),
    StoryData(id: 2, imageUrl: URL(string: "https://picsum.photos/200/300")!, title: "Title 2"),
    StoryData(id: 3, imageUrl: URL(string: "https://picsum.photos/200/300")!, title: "Title 3")
]

enum RequestError: Error {
    case sessionError(error: Error)
}

class StoryDataLoader: ObservableObject {
    
    var storyDataList: [StoryData]
    
    private var cancellablesImageRequest = Set<AnyCancellable>()
    
    
    
    @Published var filledStoryDataList: [StoryData] = []
    
    @Published var allImageLoaded = false
    
    init(withList: [StoryData]){
        self.storyDataList = withList
    }
    
    func loadAll() {
//        let cancellable = storyDataList.map { story in
//            loadImageInStoryData(storyData: story)
//                .collect()
//                .mapError{ error -> RequestError in
//                    return RequestError.sessionError(error: error)
//                }
//                
//
//        }
        
        
        
        storyDataList.publisher
            .map { storyData -> StoryData in
                print(storyData)
                return storyData
            }
            .flatMap{ storyDataToFill -> AnyPublisher<StoryData, Never> in
                self.loadImageInStoryData(storyData: storyDataToFill)
            }
            .collect()
            .assign(to: \.filledStoryDataList, on: self)
            .store(in: &cancellablesImageRequest)
        
    }
    
    deinit {
        self.cancellablesImageRequest.forEach { cancellable in
            cancellable.cancel()
        }
    }
    
    func loadImageInStoryData(storyData: StoryData) -> AnyPublisher<StoryData, Never> {
        let notFoundImage = UIImage(named: "placeholder")
        return URLSession.shared.dataTaskPublisher(for: storyData.imageUrl)
            .receive(on: DispatchQueue.main)
            .compactMap { data, response in
                UIImage(data: data)
            }
            .replaceError(with: notFoundImage)
            .map {
                storyData.image = $0
                
                return storyData
            }
            .eraseToAnyPublisher()
            
    }
}

class StoryData: Identifiable {
    var id: Int
    let imageUrl: URL
    var image: UIImage?
    let title: String
    
    convenience init(id: Int, imageUrl: URL, title: String, image: UIImage){
        self.init(id: id, imageUrl: imageUrl, title: title)
        self.image = image
        
    }
    
    init(id: Int, imageUrl: URL, title: String){
        self.id = id
        self.imageUrl = imageUrl
        self.title = title
    }
    
    
    
    
}
