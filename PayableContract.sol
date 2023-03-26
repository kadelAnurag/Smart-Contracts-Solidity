pragma solidity ^0.8.0;

contract mappingSample {
    address public DA;

    constructor() {
        DA = msg.sender;
    }

    struct learner {
        string name;
        uint256 age;
        address msgSender;
    }

    mapping(uint256 => learner) public learners;
    mapping(uint256 => string[]) learnerCourses;
    mapping(string => mapping(uint256 => learner)) public testMap;

    function setLearnerDetails(
        uint256 _key,
        string memory _name,
        uint256 _age,
        string memory _course
    ) public {
        learners[_key].name = _name;
        learners[_key].age = _age;
        learners[_key].msgSender = msg.sender;
        learnerCourses[_key].push(_course);
    }

    function getLearnerDetails(uint256 _key)
        public
        view
        returns (
            string memory,
            uint256,
            address
        )
    {
        return (
            learners[_key].name,
            learners[_key].age,
            learners[_key].msgSender
        );
    }

    function addCourse(uint256 _id, string memory _courseName) public {
        learnerCourses[_id].push(_courseName);
    }

    function getLearnerCourses(uint256 _id)
        public
        view
        returns (string[] memory)
    {
        return learnerCourses[_id];
    }

    function getMoney() public payable {}

    function transferMoney() public {
        payable(DA).transfer(address(this).balance);
    }
}
