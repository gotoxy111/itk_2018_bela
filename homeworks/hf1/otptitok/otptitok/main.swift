import Foundation

// Feladat 19: nagy feladat 2
// Írj egy OneTimePad nevű osztályt ami a one-time-pad titkosítást valósítja meg
// A OneTimePad komformáljon az Encryption protocolhoz
// A one-time pad titkosítás feltörhetetlen (tényleg)
// A one-time pad titkosítás lényegében annyi, hogy egy szövegnek a karaktereit eltolja egy másik "kulcs" karaktersorozat értékeivel
// Ehhez is érdemes egy XCode command line projektet csinálni

// Pl "abc" eltolva a "afd" kulcsal: "bhg"
// (mert a: 1, b: 2, c: 3    a: 1, f: 6, d: 4  a+a = 1+1 = 2 = b, b+f = 2+6 = 8 = h, c+d = 3+4 = 7 = g -> "bhg")

protocol Encryption {
    func encrypt(plaintext: String) -> String?
    func decrypt(cyphertext: String) -> String?
}

let secret = "afd"

class OneTimePad : Encryption{
    func encrypt(plaintext: String) -> String? {
        guard secret.count == plaintext.count && secret.filterText() != nil && plaintext.filterText() != nil else{
            return nil
        }
        let transformed = plaintext.transformate(secret.getOffsets())
        var result = ""
        for var t in transformed{
            t.calculateRes(t.offset)
            result.append(t.res)
        }
        return result
    }
    
    func decrypt(cyphertext: String) -> String? {
        guard secret.count == cyphertext.count && secret.filterText() != nil && cyphertext.filterText() != nil else{
            return nil
        }
        let transformed = cyphertext.transformate(secret.getOffsets())
        var result = ""
        for var t in transformed{
            t.calculateRes(-t.offset)
            result.append(t.res)
        }
        return result
    }
}

struct charAndOffset{
    let char : String
    let offset : Int
    var res : String
    
    mutating func calculateRes(_ _offset: Int) -> Void {
        let subRes = char.unicodeScalars.map{Int($0.value)}.map{$0 + _offset}.map{$0 - 97}
        res.append(Character(UnicodeScalar(subRes.map{($0 % 26) + 97}[0])!))
    }
}

extension String{
    func filterText() -> String?{
        let initialSize = self.count
        let result = self.unicodeScalars.map{$0.value}.filter{$0 >= 97}.filter{$0 <= 122}
        guard initialSize == result.count && initialSize != 0 else{
            return nil
        }
        return self
    }
    
    func getOffsets () -> [Int]{
        return self.unicodeScalars.map{Int($0.value) - 96}
    }
    
    func transformate(_ keys: [Int]) -> [charAndOffset]{
        var result : [charAndOffset] = []
        var i = 0
        for character in self{
            result.append(charAndOffset(char: String(character), offset: keys[i], res: ""))
            i = i + 1
        }
        return result
    }
    
    
}

let otp = OneTimePad()

print(otp.encrypt(plaintext: "abc"))
print(otp.decrypt(cyphertext: "bhg"))


