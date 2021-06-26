//
//  Timer.swift
//  SwiftUI-Playground
//
//  Created by Anthony Da cruz on 20/06/2021.
//

import Foundation
import Combine

class TimerData : ObservableObject {
    
    @Published var timeCount = 0
    
    var timer : Timer?
    
    init() {
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(timerDidFire), userInfo: nil, repeats: true)
    }
    
    @objc func timerDidFire() {
        timeCount += 1
    }
    
    func resetCount() {
//        - (void)shareBackgroundAndStickerImage { [self backgroundImage:UIImagePNGRepresentation([UIImage imageNamed:@"backgroundImage"]) stickerImage:UIImagePNGRepresentation([UIImage imageNamed:@"stickerImage"])]; } - (void)backgroundImage:(NSData *)backgroundImage stickerImage:(NSData *)stickerImage { // Verify app can open custom URL scheme. If able, // assign assets to pasteboard, open scheme. NSURL *urlScheme = [NSURL URLWithString:@"instagram-stories://share?source_application=com.my.app"]; if ([[UIApplication sharedApplication] canOpenURL:urlScheme]) { // Assign background and sticker image assets to pasteboard NSArray *pasteboardItems = @[@{@"com.instagram.sharedSticker.backgroundImage" : backgroundImage, @"com.instagram.sharedSticker.stickerImage" : stickerImage}]; NSDictionary *pasteboardOptions = @{UIPasteboardOptionExpirationDate : [[NSDate date] dateByAddingTimeInterval:60 * 5]}; // This call is iOS 10+, can use 'setItems' depending on what versions you support [[UIPasteboard generalPasteboard] setItems:pasteboardItems options:pasteboardOptions]; [[UIApplication sharedApplication] openURL:urlScheme options:@{} completionHandler:nil]; } else { // Handle older app versions or app not installed case } }

        timeCount = 0
    }
}

