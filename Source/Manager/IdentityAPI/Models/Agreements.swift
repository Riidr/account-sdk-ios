//
// Copyright 2011 - 2018 Schibsted Products & Technology AS.
// Licensed under the terms of the MIT license. See LICENSE in the project root.
//

import Foundation

struct Agreements: JSONParsable {
    let client: Bool
    let platform: Bool

    init(from json: JSONObject) throws {
        let data = try json.jsonObject(for: "data")
        let agreements = try data.jsonObject(for: "agreements")
        self.platform = agreements["platform"] as? Bool ?? false
        self.client = agreements["client"] as? Bool ?? false
    }
}
