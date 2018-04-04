// To parse the JSON, add this file to your project and do:
//
//   guard let numbersTipModel = try NumbersTipModel(json) else { ... }

import Foundation

struct NumbersTipModel: Codable {
    let d: [[String]]
}

// MARK: Convenience initializers

extension NumbersTipModel {
    init(data: Data) throws {
        self = try JSONDecoder().decode(NumbersTipModel.self, from: data)
    }
    
    init?(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else { return nil }
        try self.init(data: data)
    }
    
    init?(fromURL url: String) throws {
        guard let url = URL(string: url) else { return nil }
        let data = try Data(contentsOf: url)
        try self.init(data: data)
    }
    
    func jsonData() throws -> Data {
        return try JSONEncoder().encode(self)
    }
    
    func jsonString() throws -> String? {
        return String(data: try self.jsonData(), encoding: .utf8)
    }
}
