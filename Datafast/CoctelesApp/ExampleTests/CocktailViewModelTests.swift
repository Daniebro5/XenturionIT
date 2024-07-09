import XCTest
@testable import Example

final class CocktailViewModelTests: XCTestCase {
    // sut -> subject under tests/sujeto puesto a prueba
    // el force unwrap se lo evita casi siempre menos en pruebas
    var sut: CocktailViewModel!

    override func setUp() {
        super.setUp()
        sut = CocktailViewModel()
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func testExample() throws {
    }

    func testPerformanceExample() throws {
        self.measure {
        }
    }
}
