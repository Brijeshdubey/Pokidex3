//
//  Pokimon.swift
//  Pokidex3
//
//  Created by Brijesh Dubey on 23/08/17.
//  Copyright © 2017 Brijesh Dubey. All rights reserved.
//

import Foundation
import Alamofire

class Pokemon {
    
    private var _name: String!
    private var _pokedexId: Int!
    private var _description: String!
    private var _type: String!
    private var _defense: String!
    private var _height: String!
    private var _weight: String!
    private var _attack: String!
    private var _nextEvolutiontxt: String!
    private var _nextEvolutionname: String!
    private var _nextEvolutionId: String!
    private var _nextEvolutionLevel: String!
    private var _pokimonURL: String!
    
    
    
    var nextEvolutiontxt: String {
        if _nextEvolutiontxt == nil {
            _nextEvolutiontxt = ""
        }
        return _nextEvolutiontxt
    }
    
    
    var nextEvolutionname: String {
        if _nextEvolutionname == nil {
            _nextEvolutionname = ""
        }
            return _nextEvolutionname
    }
        
    var nextEvolutionId: String {
            if _nextEvolutionId == nil {
                _nextEvolutionId = ""
        }
                return _nextEvolutionId
            }
            
    var nextEvolutionLevel: String {
                if _nextEvolutionLevel == nil {
                    _nextEvolutionLevel = ""
        }
        
                    return _nextEvolutionLevel
                }
    
    var defense: String {
        if _defense == nil  {
            _defense = ""
        }
        return _defense
    }
    
    
    var height: String {
        if _height == nil  {
            _height = ""
        }
        return _height
    }
    
    
    var type: String {
        if _type == nil  {
            _type = ""
        }
        return _type
    }
    
    var description: String {
        if _description == nil  {
            _description = ""
        }
        return _description
    }
    
    
    
    
    
    var weight: String {
        if _weight == nil  {
            _weight = ""
        }
        return _weight
    }
    
    
    
    var attack: String {
        if _attack  == nil {
            _attack = ""
        }
        return _attack
    }
    
    
    // setting the values so that if the values are nil, the program will not crash.
    var nextEvolutionText: String {
        if _nextEvolutiontxt == nil {
            
            _nextEvolutiontxt = ""
        }
        
        return _nextEvolutiontxt
    }
    
    var name: String {
        
        return _name
    }
    
    var pokedexId: Int {
        return _pokedexId
    }
    
    init (name: String, pokedexId: Int) {
        self._name = name
        self._pokedexId = pokedexId
        self._pokimonURL = "\(URL_BASE)\(URL_POKEMON)\(self.pokedexId)/"
    }
    
    func downloadPokemonDetail(completed: @escaping DownloadComplete) {
        
        Alamofire.request(_pokimonURL).responseJSON { (response) in
            
             //print(response.result.value!)
            
            if let dict = response.result.value as? Dictionary<String, AnyObject> {
                if let weight = dict["weight"] as? String {
                    self._weight = weight
                }
                
                if let height = dict["height"] as? String {
                    self._height = height
                }
                if let attack = dict["attack"] as? Int {
                    self._attack = "\(attack)"
                }
                
                if let defense = dict["defense"] as? Int {
                    
                    self._defense = "\(defense)"
                }
                print(self._attack)
                print(self._height)
                print(self._weight)
                print(self._defense)
                
                if let type = dict["types"] as? [Dictionary <String, String>], type.count > 0 {
                    if let name = type[0]["name"] {
                        
                        self._type = name.capitalized
                    }
                    
                    if type.count > 1 {
                        for x in 1..<type.count {
                            if let name = type[x]["name"] {
                                
                                self._type! += "/\(name.capitalized)"
                                
                            }
                        }
                    }
                    
                    print(self._type)
                } else {
                    self._type = ""
                }
                
                if let descArr = dict["descriptions"] as? [Dictionary <String, String>], descArr.count > 0{
                    if let url = descArr[0]["resource_uri"] {
                        
                        let descURL = "\(URL_BASE)\(url)"
                        
                        Alamofire.request(descURL).responseJSON(completionHandler: { (response) in
                            
                            if let descDict = response.result.value as? Dictionary <String, AnyObject> {
                                
                              if  let description = descDict["description"] as? String {
                                
                                let newDescription = description.replacingOccurrences(of: "Pokmon", with: "Pokemon")
                                print(description)
                                self._description = newDescription
                                    
                                }
                                
                            }
                            
                            completed()
                            
                        })
                       
                    }
                    
                } else {
                    self._description = ""
                }
                
                if let evolution = dict["evolutions"] as? [Dictionary <String, AnyObject>], evolution.count > 0 {
                    
                    if let nextEvo = evolution[0]["to"] as? String {
                        if nextEvo.range(of: "mega") == nil {
                            self._nextEvolutionname = nextEvo
                            
                            if let uri = evolution[0]["resource_uri"] as? String {
                                
                                let newStr = uri.replacingOccurrences(of: "/api/v1/pokemon/", with: "")
                                let nextEvoId = newStr.replacingOccurrences(of: "/", with: "")
                                self._nextEvolutionId = nextEvoId
                                
                                if let lvlExist = evolution[0]["level"] {
                                    if let lvl = lvlExist as? Int {
                                        self._nextEvolutionLevel = "\(lvl)"
                                    }
                                } else {
                                    self._nextEvolutionLevel = ""
                                }
                            }
                        }
                    }
                    
                    print(self.nextEvolutionLevel)
                    print(self.nextEvolutionname)
                    print(self.nextEvolutionId)
                    print(self.nextEvolutiontxt)
                    
                }
            
            }
            
            completed()
        }
}
}

    

