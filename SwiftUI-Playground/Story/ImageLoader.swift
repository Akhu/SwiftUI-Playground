//
//  ImageLoader.swift
//  SwiftUI-Playground
//
//  Created by Anthony Da cruz on 23/06/2021.
//

import Foundation
import Combine
import UIKit

class ImageLoader: ObservableObject {
    
    @Published var images: [UIImage] = [UIImage]()
    {
        didSet {
            if images.count > 0 {
                self.isImagesLoaded = true
            }
        }
    }
    
    
        
    private var loadingImagesTask :AnyCancellable?
    
    
    func loadImages(urlList: [String]) {
        
        loadingImagesTask = urlList
            .publisher
            .compactMap { element in
                guard let url = URL(string: element) else { return nil }
                return url
            }
            
            .flatMap {
                self.getImagesData(from: $0)
            }
            .receive(on: DispatchQueue.main)
            .replaceError(with: UIImage())
            .collect()
            .eraseToAnyPublisher()
            .assign(to: \.images, on: self)
            
    }
    
    
    private func getImagesData(from url: URL) -> AnyPublisher<UIImage, Error> {
        return URLSession.shared.dataTaskPublisher(for: url)
        .tryMap() { element -> Data in
            guard let httpResponse = element.response as? HTTPURLResponse,
                        httpResponse.statusCode == 200 else {
                            throw URLError(.badServerResponse)
                        }
            return element.data
        }
        .receive(on: DispatchQueue.main)
        .compactMap { data in
            UIImage(data: data)
        }
        .eraseToAnyPublisher()
        
      }
    
    @Published  var isImagesLoaded = false
}
