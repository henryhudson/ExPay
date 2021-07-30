//
//  LatestBSVPriceModel.swift
//  BSV Payments
//
//  Created by Jack Knight on 02/07/2021.
//

import SwiftUI

struct LatestBSVPriceModel: Codable {
  let currency: String
  let rate: String
  
  static let `default` = LatestBSVPriceModel(currency: "N/A", rate: "-1")
}

