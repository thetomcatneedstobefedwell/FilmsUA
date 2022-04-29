//
//  StarsView.swift
//  FilmsUA
//
//  Created by Roman Zherebko on 21.04.2022.
//

import SwiftUI

struct StarsView: View {
    private static let maxRating: Float = 5 // Defines upper limit of the rating
    private static let starColour = Color.orange // The color of the stars
    
    let rating: Float
    let frame: CGFloat
    private let fullCount: Int
    private let emptyCount: Int
    private let halfFullCount: Int
    
    init(rating: Float, frame: CGFloat) {
        self.rating = rating
        self.frame = frame
        fullCount = Int(rating)
        emptyCount = Int(StarsView.maxRating - rating)
        halfFullCount = (Float(fullCount + emptyCount) < StarsView.maxRating) ? 1 : 0
    }
    
    var body: some View {
        HStack {
            ForEach(0..<fullCount) { _ in
                self.fullStar
            }
            ForEach(0..<halfFullCount) { _ in
                self.halfFullStar
            }
            ForEach(0..<emptyCount) { _ in
                self.emptyStar
            }
        }
    }
    
    private var fullStar: some View {
        Image(systemName: "star.fill")
            .foregroundColor(StarsView.starColour)
            .frame(width: frame)
    }
    
    private var halfFullStar: some View {
        Image(systemName: "star.lefthalf.fill")
            .foregroundColor(StarsView.starColour)
            .frame(width: frame)
    }
    
    private var emptyStar: some View {
        Image(systemName: "star").foregroundColor(StarsView.starColour)
            .frame(width: frame)
    }
}
