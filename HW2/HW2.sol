// SPDX-License-Identifier: MIT
pragma solidity >=0.6.12 <0.9.0;

contract Storage {

    uint256 number;

    // Произвольная структура
    struct FirstStruct {
        uint256 amount;
        address ownerAddress;
        string dataValue;
        bool isTrue;
    }

    // Отображение
    mapping(uint256 => FirstStruct) firstStructs;

    // Событие при добавлении структуры в отображение
    event StructAdded(uint256 key, uint256 amount, address ownerAddress, string dataValue, bool isTrue);

    // Событие при удалении структуры
    event StructRemoved(uint256 key);

    // Сохранение значения в переменной
    function store(uint256 num) public {
        number = num;
    }

    // Возвращение значения
    function retrieve() public view returns (uint256){
        return number;
    }

    // Функция для добавления структуры в отображение
    function addStruct(uint256 key, uint256 amount, string memory dataValue) public {
        FirstStruct storage secondStruct = firstStructs[key];
        secondStruct.ownerAddress = msg.sender;
        secondStruct.amount = amount;
        secondStruct.dataValue = dataValue;
        secondStruct.isTrue = true;

        emit StructAdded(key, amount, msg.sender, dataValue, true);
    }

    // Функция для удаления структуры
    function removeStruct(uint256 key) public {
        require(firstStructs[key].isTrue, "Structure with this key does not exist");
        require(firstStructs[key].ownerAddress == msg.sender, "Only the owner can remove the structure");
        delete firstStructs[key];

        emit StructRemoved(key);
    }
}
      