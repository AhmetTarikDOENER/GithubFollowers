//
//  SFSymbols.swift
//  GithubFollowers
//
//  Created by Ahmet Tarik DÖNER on 17.10.2023.
//

import UIKit

enum SFSymbols {
    
    static let location = UIImage(systemName: "mappin.and.ellipse")
    static let repos = UIImage(systemName: "folder")
    static let gists = UIImage(systemName: "text.alignleft")
    static let followers = UIImage(systemName: "heart")
    static let following = UIImage(systemName: "person.2")
}

enum Images {
    static let githubLogo = UIImage(named: "gh-logo")
    static let placeHolderImage = UIImage(named: "avatar-placeholder")
    static let emptyStateImage = UIImage(named: "empty-state-logo")
}

enum ScreenSize {
    static let width = UIScreen.main.bounds.size.width
    static let height = UIScreen.main.bounds.size.height
    static let maxLenght = max(ScreenSize.width, ScreenSize.height)
    static let minLenght = min(ScreenSize.width, ScreenSize.height)
}

enum DeviceTypes {
    static let idiom = UIDevice.current.userInterfaceIdiom
    static let nativeScale = UIScreen.main.nativeScale
    static let scale = UIScreen.main.scale
    
    static let isIphoneSE = idiom == .phone && ScreenSize.maxLenght == 568
    static let isIphone8Standart = idiom == .phone && ScreenSize.maxLenght == 667 && nativeScale == scale
    static let isIphone8Zoomed = idiom == .phone && ScreenSize.maxLenght == 667 && nativeScale > scale
    static let isIphone8PlusStandart = idiom == .phone && ScreenSize.maxLenght == 736
    static let isIphone8PlusZoomed = idiom == .phone && ScreenSize.maxLenght == 736 && nativeScale < scale
    static let isIphoneX = idiom == .phone && ScreenSize.maxLenght == 812
    static let isIphoneXsMaxAndXr = idiom == .phone && ScreenSize.maxLenght == 896
    static let isIpad = idiom == .pad && ScreenSize.maxLenght >= 1024
    
    static func isIphoneXAspectRatio() -> Bool {
        return isIphoneX || isIphoneXsMaxAndXr
    }
}
