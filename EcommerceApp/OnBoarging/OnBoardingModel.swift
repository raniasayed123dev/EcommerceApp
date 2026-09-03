//
//  OnBoardingModel.swift
//  EcommerceApp
//
//  Created by rania on 02/09/2026.
//

import Foundation
struct OnBoardingModel: Codable {
    let image: String
    let title: String
    let description: String
}
 let onBoardingData: [OnBoardingModel] = [
    OnBoardingModel(image: "onBoardingImage1", title: "Take Advantage of the offer shopping", description: "publish Up your selfies to make yourself more beautiful with this app"), OnBoardingModel(image: "onBoardingImage2", title: "Take Advantage of the offer shopping", description: "publish Up your selfies to make yourself more beautiful with this app") , OnBoardingModel(image: "onBoardingImage3", title: "Take Advantage of the offer shopping", description: "publish Up your selfies to make yourself more beautiful with this app")]
