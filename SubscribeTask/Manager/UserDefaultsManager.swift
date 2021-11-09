//
//  UserDefaultsManager.swift
//  SubscribeTask
//
//  Created by ahmed on 24/10/2021.
//

import Foundation

class UserDefaultsManager {
    
    static let shared = UserDefaultsManager()
    
    private init() {}
    
    public func saveUser(user: User) {
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(user)
            UserDefaults.standard.set(data, forKey: USER_DEFAULTS_KEY)
            UserDefaults.standard.synchronize()
        }
        catch {
            print("Unable to encode user. (\(error))")
        }
    }
    
    public func retrieveUser() -> User? {
        if let data = UserDefaults.standard.data(forKey: USER_DEFAULTS_KEY) {
            do {
                let decoder = JSONDecoder()
                let user = try decoder.decode(User.self, from: data)
                return user
            }
            catch {
                print("Unable to decode user. (\(error))")
            }
        }
        return nil
    }
    
    public func removeUser() {
        UserDefaults.standard.removeObject(forKey: USER_DEFAULTS_KEY)
        UserDefaults.standard.synchronize()
    }
}
