import Foundation

// Feladat 20: nagy feladat 3
// Írj egy általános Life-like cellular automaton-t
// A Game of Life általánosítását kell megcsinálni

// Van egy négyzethálós cellákból áló mezőnk ahol minden cella vagy él vagy halott
// Iterációnként értékeljük ki a szabályokat és döntjük el, hogy melyik mező él vagy hal meg
// Minden cellának vannak szomszédai, összesen max 8 szomszédja lehet egy cellának (széleken kérdéses)

// Két féle szabály van:
//      * Survive (S): felsorolás szerűen hány darab élő szomszéd esetén él túl egy cella a következő iterációba
//      * Born (B): felsorolás szerűen hány darab élő szomszéd esetén születik (támad fel) egy cella

// A megejelnítést command lineon csináljátok jó öreg ascii art segítségével
// Ehhez is érdemes egy XCode command line projektet csinálni

// Pl. A jól ismert Game of Life kifejezhető ezekkel a szabályokkal: B3/S23
//          * pontosan 3 szomszéd esetén feltámad egy cella
//          * pontosan 2 vagy 3 szomszéd esetén túlél egy már élő cella a következő iterációba


class Cell {
    let position : Position
    var label : String{
        willSet(newVal){
            if(newVal == "A"){
                caption = "+"
            }
        }
    }
    var caption : String = " "
    var snapshot : String
    var neighbours : [Cell] = []
    
    init(_ text: String, _ pos: Position){
        self.label = Cell.generateRandomState()
        self.position = pos
        self.snapshot = label
        print(String(position.x)+" "+String(position.y)+" inited")
    }
    
    deinit {
        print(String(position.x)+" "+String(position.y)+" deinited")
    }
    
    static func generateRandomState() -> String{
        let diceRoll = Int(arc4random_uniform(10))
        if(diceRoll == 0){
            return "A"
        }else{
            return "D"
        }
    }
    
    func initNeighbours(nbours neigh: [Cell]) -> Void {
        neighbours = neigh
    }
    
    func nextIter(){
        if(isAliveForNextIter()){ snapshot = "A"}
    }
    
    func isAliveForNextIter() -> Bool{
        return neighbours.filter{$0.label == "A"}.count >= 2
    }
    
    func refresh(){
        label = snapshot
    }
    
    func countNeighbours() -> Int{
        return neighbours.count
    }
    
    func countAliveNeighbours() -> Int{
        return neighbours.filter{$0.label == "A"}.count
    }
    
}

struct Position{
    let x : Int
    let y : Int
}

class Field {
    var cells : [[Cell?]] = []
    var dummyCells : [Cell] = []
    let size : Int = 7
    
    init() {
        for i in 0...size{
            var arrTmp : [Cell] = []
            for j in 0...size{
                arrTmp.append(Cell(String(j), Position(x : i, y : j)))
            }
            cells.append(arrTmp)
        }
        
        for cellArr in cells{
            for cell in cellArr{
                cell!.initNeighbours(nbours : getNeighbours(cell!.position.x, cell!.position.y))
            }
        }
    }
    
    func getNeighbours(_ x : Int, _ y : Int) -> [Cell]{
        var cellsRes : [Cell] = []
        for x2 in x-1...x+1{
            for y2 in y-1...y+1{
                if(!(x2 == x && y2 == y)){
                    if( x2 >= 0 && x2 <= size && y2 >= 0 && y2 <= size ){
                        cellsRes.append(cells[x2][y2]!)
                    }else{
                        let dummyCell = Cell("A", Position(x : x2, y : y2))
                        cellsRes.append(dummyCell)
                        dummyCells.append(dummyCell)
                    }
                }
            }
        }
        return cellsRes
    }
    
    func printField(){
        for row in cells{
            var rowText = ""
            var horizontalLine = ""
            for column in row{
                //rowText.append(String(column.countAliveNeighbours()))
                rowText.append(column!.caption+"|")
                horizontalLine.append("--")
            }
            print(horizontalLine)
            print(rowText)
        }
    }
    
    func iterate(){
        for cellArr in cells{
            for cell in cellArr{
                cell!.nextIter()
            }
        }
        for cellArr in cells{
            for cell in cellArr{
                cell!.refresh()
                //print(cell.countNeighbours())
            }
        }
        printField()
    }
    
    func breakDownField(){
        for cellArr in cells{
            for var cell in cellArr{
                cell = nil
            }
        }
    }
}

var palya = Field()
print("--------Iteration: ---------(for the next ITER press any button + ENTER;you can exit by pressing q + ENTER)")
var userInput = readLine()
var iterNum = 0
while(userInput != "q"){
    print("--------Iteration: "+String(iterNum)+"---------(for the next ITER press any button + ENTER;you can exit by pressing q + ENTER)")
    palya.iterate()
    iterNum = iterNum + 1
    userInput = readLine()
}
palya.breakDownField()

