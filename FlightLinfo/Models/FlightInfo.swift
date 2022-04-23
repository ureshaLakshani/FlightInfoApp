// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let flightInfo = try? newJSONDecoder().decode(FlightInfo.self, from: jsonData)

import Foundation

// MARK: - FlightInfo
struct FlightInfo: Codable {
    let pagination: Pagination?
    let data: [Datum]?
}

// MARK: - Datum
struct Datum: Codable {
    let flightDate, flightStatus: String?
    let departure, arrival: Arrival?
    let airline: Airline?
    let flight: Flight?
    let aircraft: Aircraft?
    let live: Live?

    enum CodingKeys: String, CodingKey {
        case flightDate = "flight_date"
        case flightStatus = "flight_status"
        case departure, arrival, airline, flight, aircraft, live
    }
}

// MARK: - Aircraft
struct Aircraft: Codable {
    let registration, iata, icao, icao24: String?
}

// MARK: - Airline
struct Airline: Codable {
    let name, iata, icao: String?
}

// MARK: - Arrival
struct Arrival: Codable {
    let airport, timezone, iata, icao: String?
    let terminal, gate, baggage: String?
    let delay: Int?
    let scheduled, estimated: String?
    let actual, estimatedRunway, actualRunway: String?

    enum CodingKeys: String, CodingKey {
        case airport, timezone, iata, icao, terminal, gate, baggage, delay, scheduled, estimated, actual
        case estimatedRunway = "estimated_runway"
        case actualRunway = "actual_runway"
    }
}

// MARK: - Flight
struct Flight: Codable {
    let number, iata, icao: String?
}

// MARK: - Live
struct Live: Codable {
    let updated: String?
    let latitude, longitude, altitude, direction: Double?
    let speedHorizontal, speedVertical: Double?
    let isGround: Bool?

    enum CodingKeys: String, CodingKey {
        case updated, latitude, longitude, altitude, direction
        case speedHorizontal = "speed_horizontal"
        case speedVertical = "speed_vertical"
        case isGround = "is_ground"
    }
}

// MARK: - Pagination
struct Pagination: Codable {
    var limit, offset, count, total: Int?
}

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}

