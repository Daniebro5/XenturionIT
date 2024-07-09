import XCTest
// testable hace que el alcance aumente en uno
// alcance: OPEN - PUBLIC - INTERNAL (POR DEFECTO) - FILEPRIVATE - PRIVATE
// PRIVATE -> FILEPRIVATE
@testable import Example

// TESTS ARE FIRST (TDD)
// F - Fast (no deben tener tiempos de espera)
// I - Isolated/Independent (no deben depender de otras pruebas)
// R - Repeatable (siempre tiene que dar el mismo resultado)
// S - Self-Validating (deben ser automáticas, no deberíamos revisar si la prueba esta mal o no)
                        // deberíamos revisar el código
// T - Thorough (tiene que cubrir la mayoría de casos)
//              // cubrir siempre el happy path
//              // intentar cubrir todos los casos extremos

// TDD - Test Driven Development
// nuestro código debe estar influenciado por las pruebas, pruebas de calidad casi aseguran
// código de calidad

// si algo es dificil de probar, generalmente quiere decir que hay como mejorar nuestro codigo

final class ExampleTests: XCTestCase {

    override class func setUp() {
        // se ejecuta siempre antes de cada prueba
        // lo utilizaremos para inicializar
    }

    override class func tearDown() {
        // se ejecuta siempre despues de cada prueba
        // lo utilizaremos para hacer limpieza
    }

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
