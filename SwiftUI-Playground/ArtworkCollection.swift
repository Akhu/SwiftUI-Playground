//
//  ArtworkCollection.swift
//  SwiftUI-Playground
//
//  Created by Anthony Da cruz on 26/06/2021.
//

import SwiftUI


struct Story: Identifiable {
    let id: Int
    let title: String
    let image: String
    var offset: CGFloat = 0
    var opacity: Double = 1
}

struct ArtworkCollection: View {
    
    @State var index = 0
    @State var stories = [
        Story(id: 0,title: "Balade en montagne", image: "image-0"),
        Story(id: 1,title: "Voyage à Rome", image: "image-1"),
        Story(id: 2,title: "Autour du lac", image: "image-2"),
        Story(id: 3,title: "Station abandonnée", image: "image-3")
        
    ]
    
    @State var scrolled: Int = 0
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack {
                HStack {
                    Button(action: {}) {
                        Image(systemName: "filemenu.and.selection")
                            .renderingMode(.template)
                            .foregroundColor(.white)
                    }
                    
                    Spacer()
                    
                    Button(action: {}) {
                        Image(systemName: "magnifyingglass.circle")
                            .renderingMode(.template)
                            .foregroundColor(.white)
                    }
                }
                .padding()
                
                HStack {
                    Text("Trending")
                        .font(.system(size: 40, weight: .bold))
                        .foregroundColor(.white)
                    Spacer()
                    
                    Image(systemName: "ellipsis.circle.fill")
                        .renderingMode(.template)
                        .foregroundColor(.white)
                        .rotationEffect(.init(degrees: 90))
                }
                .padding(.horizontal)
                
                HStack {
                    Text("Animated")
                        .font(.caption)
                        .foregroundColor(index == 0 ? .white : Color.black.opacity(0.15))
                        .fontWeight(.bold)
                        .padding(.vertical, 6)
                        .padding(.horizontal, 20)
                        .background(Color.blue.opacity(index == 0 ? 1 : 0))
                        .clipShape(Capsule())
                        .onTapGesture {
                            index = 0
                        }
                    
                    
                    
                    Text("25+ Series")
                        .font(.caption)
                        .foregroundColor(index == 1 ? .white : Color.black.opacity(0.15))
                        .fontWeight(.bold)
                        .padding(.vertical, 6)
                        .padding(.horizontal, 20)
                        .background(Color.blue.opacity(index == 1 ? 1 : 0))
                        .clipShape(Capsule())
                        .onTapGesture {
                            index = 1
                        }
                    
                    Spacer()
                }
                .padding(.horizontal)
                .padding(.top, 10)
                
                Spacer()
                
                ZStack {
                    ForEach(self.stories.reversed()) { story in
                        HStack {
                            ZStack(alignment: Alignment(horizontal: .leading, vertical: .bottom)) {
                                Image(story.image)
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: calculateWidth(), height: (UIScreen.main.bounds.height /  1.8) - CGFloat(story.id - scrolled) * 50)
                                    .cornerRadius(25.0)
                                    .offset(x: story.id - scrolled <= 2 ? CGFloat(story.id - scrolled) * 30 : 60)
                                    //.opacity(story.id - scrolled < 1 ? 1.0 : 0.8)
                                
                                VStack(alignment: .leading, spacing: 18) {
                                    HStack {
                                        Text(story.title)
                                            .font(.title)
                                            .fontWeight(.bold)
                                            .foregroundColor(.white)
                                        Spacer()
                                    }
                                    
                                    Button(action: {}, label: {
                                        Text("Read Later")
                                            .font(.caption)
                                            .fontWeight(.bold)
                                            .foregroundColor(.white)
                                            .padding(.vertical, 6)
                                            .padding(.horizontal, 25)
                                            .background(Color.black)
                                            .clipShape(Capsule())
                                    })
                                }.frame(width: calculateWidth() - 40)
                                .padding(.leading, 20)
                                .padding(.bottom, 20)
                            }
                            
                            Spacer(minLength: 0)
                        }
                        .contentShape(Rectangle())
                        .offset(x: story.offset)
                        .opacity(story.opacity)
                        .gesture(DragGesture().onChanged({ value in
                            withAnimation {
                                if value.translation.width < 0 && story.id != stories.last!.id {
                                    stories[story.id].offset = value.translation.width
                                } else {
                                    if story.id > 0 {
                                        stories[story.id - 1].offset = -(calculateWidth() + 60) + value.translation.width
                                    }
                                }
                                
                            }
                        }).onEnded({ value in
                            withAnimation {
                                if value.translation.width < 0 { //Si il va vers la gauche
                                    
                                    if -value.translation.width > 180 && story.id != stories.last!.id  {
                                        
                                        stories[story.id].offset = -(calculateWidth() + 60)
                                        scrolled += 1
                                    }else {
                                        
                                        stories[story.id].offset = 0
                                    }
                                }else {
                                    //Restoring card
                                    if story.id > 0 {
                                        if value.translation.width > 180 {
                                            stories[story.id - 1].offset = 0
                                            scrolled -= 1
                                        }else {
                                            stories[story.id - 1].offset = -(calculateWidth() + 60)
                                        }
                                    }
                                    
                                }
                                
                            }
                            
                        }))
                    }
                }.frame(height: UIScreen.main.bounds.height /  1.8)
                .padding(.horizontal, 20)
                .padding(.top, 25)
            }
            
        }
        .background(LinearGradient(gradient: .init(colors: [Color.blue, Color.purple]), startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(.all))
    }
    
    func calculateWidth() -> CGFloat {
        let screen = UIScreen.main.bounds.width - 50
        
        let width = screen - ( 2 * 30)
        return width
    }
}

struct ArtworkCollection_Previews: PreviewProvider {
    static var previews: some View {
        ArtworkCollection()
    }
}
