//
//  APIObjetItems.swift
//  BookXPert-Assignment
//
//  Created by Paranjothi Balaji on 20/06/25.
//


import Foundation

struct APIObjetItems: Codable {
    let id: String
    var name: String
    let data: DataClass?
}

struct DataClass: Codable {
    let color: String?
    let capacity: String?
    let capacityGB: Int?
    let price: Double?
    let generation: String?
    let year: Int?
    let cpuModel: String?
    let hardDiskSize: String?
    let strapColour: String?
    let caseSize: String?
    let screenSize: Double?
    let description: String?

    enum CodingKeys: String, CodingKey {
        case color
        case capacity
        case capacityGB = "capacity GB"
        case price
        case generation
        case year
        case cpuModel = "CPU model"
        case hardDiskSize = "Hard disk size"
        case strapColour = "Strap Colour"
        case caseSize = "Case Size"
        case screenSize = "Screen size"
        case description = "Description"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.color = try container.decodeIfPresent(String.self, forKey: .color)
        self.capacity = try container.decodeIfPresent(String.self, forKey: .capacity)
        self.capacityGB = try container.decodeIfPresent(Int.self, forKey: .capacityGB)
        self.price = try container.decodeIfPresent(Double.self, forKey: .price)
        self.generation = try container.decodeIfPresent(String.self, forKey: .generation)
        self.year = try container.decodeIfPresent(Int.self, forKey: .year)
        self.cpuModel = try container.decodeIfPresent(String.self, forKey: .cpuModel)
        self.hardDiskSize = try container.decodeIfPresent(String.self, forKey: .hardDiskSize)
        self.strapColour = try container.decodeIfPresent(String.self, forKey: .strapColour)
        self.caseSize = try container.decodeIfPresent(String.self, forKey: .caseSize)
        self.screenSize = try container.decodeIfPresent(Double.self, forKey: .screenSize)
        self.description = try container.decodeIfPresent(String.self, forKey: .description)
    }
}


typealias Object = [APIObjetItems]
