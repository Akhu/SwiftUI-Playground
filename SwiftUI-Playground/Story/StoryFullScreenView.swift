//
//  StoryFullScreenView.swift
//  SwiftUI-Playground
//
//  Created by Anthony Da cruz on 23/06/2021.
//

import SwiftUI
import NukeUI

private struct SafeAreaInsetsKey: EnvironmentKey {
    static var defaultValue: EdgeInsets {
        (UIApplication.shared.windows.first(where: { $0.isKeyWindow })?.safeAreaInsets ?? .zero).insets
    }
}

extension EnvironmentValues {
    
    var safeAreaInsets: EdgeInsets {
        self[SafeAreaInsetsKey.self]
    }
}

private extension UIEdgeInsets {
    
    var insets: EdgeInsets {
        EdgeInsets(top: top, leading: left, bottom: bottom, trailing: right)
    }
}



struct StoryFullScreenView: View {
    
    @Environment(\.safeAreaInsets) private var safeAreaInsets
    
    @State var start: Bool = false
    
    @StateObject var storyImageLoader = StoryDataLoader(withList: storyDataList)
    
    var body: some View {
        VStack {
            Text("StoryImageLoader \(String(describing:storyImageLoader.allImageLoaded))")
            
            GeometryReader{ geometry in
                if storyImageLoader.filledStoryDataList.count > 0 {
                    Stories(itemCount: storyDataList.count, storyDataList: storyImageLoader.filledStoryDataList)
                        .redacted(reason: storyImageLoader.filledStoryDataList.count == 0 ? .placeholder : [])
                } else {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle())
                        .position(CGPoint(x: geometry.frame(in: .local).midX, y: geometry.frame(in: .local).midY))
                }
            }
            
            
        }
        .ignoresSafeArea()
        .onAppear {
            
            self.storyImageLoader.loadAll()
        }
    }
}



let storyDataWithImage: [StoryData] = [
    StoryData(id: 1, imageUrl: URL(string: "https://picsum.photos/200/300")!, title: "Title 1", image: UIImage(named: "image-1")!),
    StoryData(id: 2, imageUrl: URL(string: "https://picsum.photos/200/300")!, title: "Title 2", image: UIImage(named: "image-2")!),
    StoryData(id: 3, imageUrl: URL(string: "https://picsum.photos/200/300")!, title: "Title 3", image: UIImage(named: "image-3")!)
]


struct StoryFullScreenView_Previews: PreviewProvider {
        
    static var previews: some View {
        StoryFullScreenView()
        Stories(itemCount: 3, countTimer: CountTimer(interval: 4.0), storyDataList: storyDataWithImage)
    }
}

struct Stories: View {
    
    var itemCount: Int
    
    @StateObject var countTimer = CountTimer(interval: 4.0)
    
    var storyDataList: [StoryData]
    
    var body: some View {
            GeometryReader { geometry in
                ZStack(alignment: .top) {
                    ZStack {
                        if let imageExist = self.storyDataList[Int(self.countTimer.progress)].image {
                            Image(imageExist)
                                .ignoresSafeArea()
                        }
                        LinearGradient(gradient: Gradient(colors: [Color.black.opacity(0.3), Color.black.opacity(0.0)
                        ]), startPoint: .top, endPoint: .center)
                        .ignoresSafeArea()
                        HStack {
                            InvisibleTappableView()
                                .frame(width: 100)
                                .onTapGesture {
                                    self.countTimer.advancePage(by: -1)
                                }
                            Spacer()
                            InvisibleTappableView()
                                .frame(width: 100)
                                .onTapGesture {
                                    self.countTimer.advancePage(by: 1)
                                }
                            
                        }
                        //Text(self.countTimer.currentIndex?.imageUrl.absoluteString ?? "QUE DALLE")
                    }
                    
                    VStack(alignment: .trailing) {
                        Button(action: {}, label: {
                            Image(systemName: "xmark")
                                .font(.system(size: 24))
                        })
                        .foregroundColor(Color.white.opacity(0.4))
                        .padding()
                        .contentShape(Rectangle())
                        .frame(alignment: .trailing)
                        
                        HStack {
                            ForEach(self.storyDataList.indices) { index in
                                LoadingBar(progress:min( max(CGFloat(countTimer.progress) - CGFloat(index), 0.0), 1.0) )
                                    .frame(height: 4, alignment: .leading)
                                    .animation(.linear)
                            }
                        }
                    }.padding(.top)
                    .padding(.horizontal, 12)
                    
                    VStack {
                        
                    }
                }.onAppear {
                    self.countTimer.max = self.itemCount
                    self.countTimer.start()
                }
            }
    }
}
