
import XCTest
@testable import Surfing_Spots

class Surfing_SpotsTests: XCTestCase,NetworkDownloadProtocols {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testdownloadTheListOfCity() {
       let expect = expectation(description:"Download the list of city from server")
       
       let session: URLSession = URLSession(configuration: .default)
       let url = URL(string:  UrlConfig.urlRunMocky)
       session.dataTask(with: url!) { data, response, error in
        XCTAssertNil(error)
          expect.fulfill()
       }.resume()
       waitForExpectations(timeout:10.0) { (error) in
          print(error?.localizedDescription ?? "error")
       }
    }
    


    func testExample() throws {
      
    }

   
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
