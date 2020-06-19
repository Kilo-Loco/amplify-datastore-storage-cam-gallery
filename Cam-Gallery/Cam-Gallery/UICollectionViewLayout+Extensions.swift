//
//  UICollectionViewLayout+Extensions.swift
//  Cam-Gallery
//
//  Created by Kyle Lee on 6/18/20.
//  Copyright © 2020 Kilo Loco. All rights reserved.
//

import UIKit

extension UICollectionViewLayout {
    static var gridLayout: UICollectionViewLayout {
        return UICollectionViewCompositionalLayout(
            sectionProvider: { (section, _) in

                // Item
                let itemSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1 / 3),
                    heightDimension: .fractionalHeight(1)
                )
                let item = NSCollectionLayoutItem(layoutSize: itemSize)

                // Group
                let groupSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .fractionalWidth(1 / 3)
                )
                let group = NSCollectionLayoutGroup.horizontal(
                    layoutSize: groupSize,
                    subitems: [item]
                )

                // Section
                let section = NSCollectionLayoutSection(group: group)
                return section

            },
            configuration: .init()
        )
    }
}
