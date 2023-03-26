// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;

contract EHR {
    struct doctor {
        uint256 docId;
        string name;
        string qualy;
        string workplaceAddress;
        address walletAddress;
        bool isRegistered;
    }

    struct patient {
        uint256 patId;
        string name;
        uint256 age;
        address walletAddress;
        bool isRegistered;
        string[] disease;
        string[] medicine;
    }

    struct medicine {
        uint256 medId;
        string medName;
        string expiryDate;
        string medDose;
        string price;
    }

    mapping(address => doctor) doctors;
    mapping(address => patient) patients;
    mapping(uint256 => medicine) medicines;

    modifier onlyDoctor(address _addr) {
        require(
            (doctors[_addr].isRegistered),
            "Only doctors are allowed to access"
        );
        _;
    }

    modifier onlyPatient(address _addr) {
        require(
            (patients[_addr].isRegistered),
            "Only patients are allowed to access"
        );
        _;
    }

    function registerDoctor(
        uint256 _docId,
        address _ethAdd,
        string memory _name,
        string memory _qualy,
        string memory _workAddress
    ) public {
        doctors[_ethAdd].docId = _docId;
        doctors[_ethAdd].name = _name;
        doctors[_ethAdd].qualy = _qualy;
        doctors[_ethAdd].workplaceAddress = _workAddress;
        doctors[_ethAdd].isRegistered = true;
        doctors[_ethAdd].walletAddress = _ethAdd;
    }

    function registerPatient(
        uint256 _patId,
        address _key,
        string memory _name,
        uint256 _age
    ) public {
        patients[_key].patId = _patId;
        patients[_key].name = _name;
        patients[_key].age = _age;
        patients[_key].isRegistered = true;
    }

    function addDisease(address _patientAdd, string memory _diseaseName)
        public
    {
        (patients[_patientAdd].disease).push(_diseaseName);
    }

    function addMedicine(
        uint256 _ID,
        string memory _medName,
        string memory _expiryDate,
        string memory _medDose,
        string memory _price
    ) public {
        medicines[_ID].medId = _ID;
        medicines[_ID].medName = _medName;
        medicines[_ID].expiryDate = _expiryDate;
        medicines[_ID].medDose = _medDose;
        medicines[_ID].price = _price;
    }

    //Require Doctors
    function prescribeMedicine(uint256 _id, address _pAddress)
        public
        onlyDoctor(msg.sender)
    {
        (patients[_pAddress].medicine).push(medicines[_id].medName);
    }

    //Require Patients
    function updatePatientAge(uint256 _newAge) public onlyPatient(msg.sender) {
        patients[msg.sender].age = _newAge;
    }

    function viewMedicineDetails(uint256 _id)
        public
        view
        returns (
            uint256,
            string memory,
            string memory,
            string memory,
            string memory
        )
    {
        return (
            medicines[_id].medId,
            medicines[_id].medName,
            medicines[_id].expiryDate,
            medicines[_id].medDose,
            medicines[_id].price
        );
    }

    //Require Doctors
    function viewPatientData(address _pAddress)
        public
        view
        onlyDoctor(msg.sender)
        returns (string[] memory)
    {
        return patients[_pAddress].medicine;
    }

    function viewDoctorData(address _docAddress)
        public
        view
        returns (
            string memory name,
            string memory qualification,
            string memory workplace
        )
    {
        return (
            doctors[_docAddress].name,
            doctors[_docAddress].qualy,
            doctors[_docAddress].workplaceAddress
        );
    }
}
