import UIKit

struct Container<Something> {
    var value: Something
    var date: Date
}

struct User {
    let id: Int
    let name: String
}

struct Address {
    let country: String
    let state: String
}

let stringContainer = Container(value: "Oi, eu sou Goku", date: Date())
let intContainer = Container(value: 3, date: Date())

class Cache<Key: Hashable, Something> {
    private var values = [Key: Container<Something>]()
    
    func insert(_ value: Something, forKey key: Key) {
        let expirationDate = Date().addingTimeInterval(1000)
        
        values[key] = Container(value: value, date: expirationDate)
    }
    
    func value(forKey key: Key) -> Something? {
        guard let container = values[key] else {
            return nil
        }
        
        guard container.date > Date() else {
            values[key] = nil
            return nil
        }
        
        return container.value
    }
}

//Container de User
let user = User(id: 98, name: "Goku")

let cache = Cache<String, User>()
cache.insert(user, forKey: "user")

let userValue = cache.value(forKey: "user")


//Container de Address
let address = Address(country: "Brazil", state: "Ceará")

let cacheAddress = Cache<String, Address>()
cacheAddress.insert(address, forKey: "address")

let addressValue = cacheAddress.value(forKey: "address")
