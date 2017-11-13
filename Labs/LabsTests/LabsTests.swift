import XCTest
@testable import Labs

class LabsTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        print()
    }
    
    override func tearDown() {
        print()
        super.tearDown()
    }
    
    func testHelloWorld() {
        let s = "Hello World!"
        print(s)
        
        foo()
    }
    
    func testFarewellWorld() {
        let s = "Farewell!"
        print(s)
        XCTAssertEqual(s, "Farewell!")
    }
}
