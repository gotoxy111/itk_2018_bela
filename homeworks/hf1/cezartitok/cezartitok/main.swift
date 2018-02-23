import Foundation

// Feladat 18: nagy feladat 1
// Írj egy CaesarsCypher nevű osztályt ami komformál az Encryption protocolhoz
// A CaesarsCypher a jó öreg cézár titkosítást valósítsa meg
// A cézár titkosítás lényegében annyi, hogy a bemeneti karaktersort eltolja egy konstans értékkel
// Pl az "abc" eltolva 1 értékkel "bcd" 2 értékkel eltolva: "cde"
// Pl "Kismalac" eltolva 1 értékkel "Ljtnbmbd"

// Érdemes a feladathoz létrehozni egy XCode command line projektet. XCode > New Project > macOS > Command Line Tool

protocol Encryption {
    func encrypt(plaintext: String) -> String?
    func decrypt(cyphertext: String) -> String?
}

let secret : Int = 1

class CaesarsCypher : Encryption{
    func encrypt(plaintext: String) -> String? {
        guard plaintext.filterText() != nil else{
            return nil
        }
        return plaintext.shiftWithValue(value: secret)
    }
    
    func decrypt(cyphertext: String) -> String? {
        let key = secret*(-1)
        guard cyphertext.filterText() != nil else{
            return nil
        }
        return cyphertext.shiftWithValue(value: key)
    }
}


extension String{
    func filterText() -> String?{
        let initialSize = self.count
        let result = self.unicodeScalars.map{$0.value}.filter{$0 >= 65}.filter{$0 <= 122}
        guard initialSize == result.count && initialSize != 0 else{
            return nil
        }
        return self
    }
    
    func shiftWithValue(value: Int) -> String{
        let subRes = self.unicodeScalars.map{UInt32((((Int($0.value) + value)-65) % 58))}.map{$0+65}.map{Character(UnicodeScalar($0)!)}
        var myString = ""
        for chars in subRes {
            myString.append(chars)
        }
        return myString
    }
    
}

let cezarka = CaesarsCypher()

print(cezarka.encrypt(plaintext: "Kismalac"))
print(cezarka.decrypt(cyphertext: "Ljtnbmbd"))



