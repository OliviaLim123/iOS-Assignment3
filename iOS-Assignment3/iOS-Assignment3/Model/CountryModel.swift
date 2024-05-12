import Foundation

// Define structs to model the JSON response
//  FLAG Struct
struct Flag: Decodable{
    let png: String;
}

//  NAME Struct
struct Name: Decodable {
    let common: String
    let official: String
}

//  CURRENCY Struct
struct Currency: Decodable {
    let name: String
    let symbol: String
}

struct Country:  Decodable, Identifiable {
    var id = UUID();
    
    //  Country PROPERTIES
    let flags: Flag;
    let name: Name;
    let currencies: [String : Currency];
    let capital: [String];
    let region: String;
    let subregion: String;
    let languages: [String : String];
    let latlng: [Double];
    let borders: [String];
    let population: Int;
    let cca3: String;
    
    
    enum CodingKeys: String, CodingKey {
        case flags;
        case name;
        case currencies;
        case capital;
        case region;
        case subregion;
        case languages;
        case latlng;
        case borders;
        case population;
        case cca3;
    };
}
