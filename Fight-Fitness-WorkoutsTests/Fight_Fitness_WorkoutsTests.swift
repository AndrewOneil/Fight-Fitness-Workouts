@testable import Fight_Fitness_Workouts
import XCTest

final class Fight_Fitness_WorkoutsTests: XCTestCase {

    var validation: Validation!
    
    override func setUp() {
        super.setUp()
        validation = Validation()
    }
    
    override func tearDown() {
        super.tearDown()
        validation = nil
    }
    
    
    //test name validation with normal data
    func test_name_normal(){
        XCTAssertTrue(Validation.isNameValid("Andy"))
    }
    
    //test name validation with extreme data (Name contains 20 characters)
    func test_name_extreme() {
        XCTAssertTrue(Validation.isNameValid("O'Neeeeeillllllllll"))
    }
    
    //test name validation with erroneous data (Contains numbers and special characters)
    func test_name_erroneous() {
        XCTAssertFalse(Validation.isNameValid("O'Neill123!@£$%"))
    }
    
    //tests correctly formatted password (conatins over 8 characters, uppercase, lowercase, numbers & special characters
    func test_password_normal(){
        XCTAssertTrue(Validation.isPasswordValid("Tester123@"))
    }
    
    //tests password with extreme valid data (Long password)
    func test_password_extreme() {
        XCTAssertTrue(Validation.isPasswordValid("Tester1234567890!@!!"))
    }
    
    //tests password with erroneous data
    func test_password_erroneous(){
        XCTAssertFalse(Validation.isPasswordValid("test"))
    }
    
    //tests to make sure beginner workout timer is formatted correctly
    func test_beginner_workout_time(){
        
        let beginner = BeginnerWorkoutView()
        
        let result = beginner.formatTime(10*60)
        
        XCTAssertEqual(result, "10:00")
    }
    
    
    //tests to make sure intermediate workout timer is formatted correctly
    func test_intermediate_workout_time(){
        
        let intermediate = IntermediateWorkoutView()
        
        let result = intermediate.formatTime(20*60)
        
        XCTAssertEqual(result, "20:00")
    }
    
    //tests to make sure advanced workout timer is formatted correctly
    func test_advanced_workout_timer(){
        let advanced = AdvancedWorkoutView()
        
        let result = advanced.formatTime(30*60)
        
        XCTAssertEqual(result, "30:00")
    }

}
