//
// Copyright 2011 - 2018 Schibsted Products & Technology AS.
// Licensed under the terms of the MIT license. See LICENSE in the project root.
//

import Foundation

typealias JSONObject = [String: Any]

protocol JSONObjectProtocol {
    associatedtype Key
    associatedtype Value
    subscript(_: Key) -> Value? { get }
}

extension Dictionary: JSONObjectProtocol {}

extension JSONObjectProtocol where Key == String, Value == Any {
    func value(for key: Key) throws -> Value {
        guard let value = self[key] else {
            throw JSONError.noKey(key)
        }
        return value
    }

    func string(for key: Key) throws -> String {
        let value = try self.value(for: key)
        guard let string = value as? String else {
            throw JSONError.notString(key)
        }
        return string
    }

    func jsonObject(for key: Key) throws -> JSONObject {
        let value = try self.value(for: key)
        guard let jsonObject = value as? JSONObject else {
            throw JSONError.notJSONObject(key)
        }
        return jsonObject
    }

    func number(for key: Key) throws -> Double {
        let value = try self.value(for: key)
        guard let number = value as? Double else {
            throw JSONError.notNumber(key)
        }
        return number
    }

    func jsonArray<T>(of _: T.Type, for key: Key) throws -> [T] {
        let value = try self.value(for: key)
        guard let array = value as? [T] else {
            throw JSONError.notArrayOf("\(T.self)", forKey: key)
        }
        return array
    }

    func boolean(for key: Key) throws -> Bool {
        let value = try self.value(for: key)
        guard let bool = value as? Bool else {
            throw JSONError.notBoolean(key)
        }
        return bool
    }
}
