<?php

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

namespace app\models;

use yii\base\Model;
use yii\web\UploadedFile;


/**
 * Description of ExtendAbonentsReport
 *
 * @author anton.smagin
 */
class ExtendAbonentsReport extends ImportReports{
    
    public $csvFile;
    public $arrayData;
    
    const ENCODING_REQUERE = true; // требуется ли перекодировка файла
    
    public function rules() {
        return [
            ['csvFile', 'file', 'skipOnEmpty' => FALSE],
        ];
    }
    
    public function upload(){
        if($this->validate()){
            // сохранение
            $this->processing();
            
            return TRUE;
        } else {
            return FALSE;
        }
    }
    
    private function processing()
    {
        // загрузка данных
        $this->arrayData = Utilites::csv_to_array($this->csvFile->tempName, self::ENCODING_REQUERE);
        
        foreach ($this->arrayData as $data){
            
            $record = new EARrecord($data);    

            $contract = Contract::find()->where(['number' => $record->contract_number])->one();

            if($contract !== NULL){
                $this->checkContractState($contract, $record);
            } else {
                if ($this->addContract($record)){
                    // если контракт добавлен успешно
                    $this->addResult(self::IMPORT_SUCCESS, $record->contract_number, 'Добавлен в базу');
                } else {
                    // если контракт не добавлен
                    $this->addResult(self::IMPORT_ERROR, $record->contract_number, 'Контракт не добавлен в базу');
                }
            }
            $this->addCounter();
        }
    }
    
    private function addContract(EARrecord $record){
        
        $contract = new Contract();
        // Информация о состоянии контракта
        $contract->number = $record->contract_number;
        $contract->category = $record->contract_category;
        $contract->type = $record->contract_type;
        $contract->status = $record->contract_status;
        $contract->balance = $record->contract_balance;
        
        // получаем id дома
        $home_id = Home::getIdByFullname($record->address_home);
        if(!$home_id){
            $this->addResult(self::IMPORT_ERROR, $contract->number, 'Невозможно получить ID дома '.$record->address_home);
            return FALSE;
        }
        // получаем id адреса
        $address = Address::find()->where(['home_id' => $home_id, 'apartment' => $record->address_apartment])->one();
        if(!$address){
            $address = new Address();
            $address->home_id = $home_id;
            $address->apartment = $record->address_apartment;
            if($address->validate()) {
                $address->save();
                Comment::WriteComment('address', $address->id, 'Добавлен в базу');
            }
        }
        
        // получаем id абонента
        $abonent = Abonent::find()->where(['fullname' => $record->abonent_fullname])->one();
        if(!$abonent){
            $abonent = new Abonent();
            $abonent->fullname = $record->abonent_fullname;
            $abonent->mobile = $record->abonent_mobile;
            $abonent->phone = $record->abonent_phone;
            if($abonent->validate()) {
                $abonent->save();
                Comment::WriteComment('abonent', $abonent->id, 'Добавлен в базу');
            } else {
                $this->addResults(self::IMPORT_ERROR, $contract->number, $abonent->getErrors());
            }
        }
        
        $contract->abonent_id = $abonent->id;
        
        
        // Сохранение
        if($contract->validate()){
            $contract->save();
            Comment::WriteComment('contract', $contract->id, 'Добавлен в базу');
            return TRUE;
        } else {
            $this->addResults(self::IMPORT_ERROR, $contract->number, $contract->getErrors());
        }
    }
    
    private function checkContractState(Contract $contract, EARrecord $record){
        
    }
    
}

class EARrecord{
    public $contract_number;
    public $contract_category;
    public $contract_status;
    public $contract_type;
    public $contract_balance;

    public $abonent_fullname;
    public $abonent_mobile;
    public $abonent_phone;
    
    public $address_home;
    public $address_apartment;
    
    const ABONENT_FULLNAME = 'V_LONG_TITLE';
    const ABONENT_MOBILE = 'V_TEL_MOB';
    const ABONENT_PHONE = 'V_TEL_HOME';
    const CONTRACT_NUMBER = 'V_EXT_IDENT';
    const CONTRACT_CATEGORY = 'V_CONTRACT_CATEGORY';
    const CONTRACT_STATUS = 'V_STATUS_CONTRACT';
    const CONTRACT_TYPE = 'V_NAME_CNTR_TYPE';
    const CONTRACT_BALANCE = 'N_VALUE_DEMAND';
    const ADDRESS_STREET = 'V_STREET';
    const ADDRESS_HOME = 'HOUSE_NM';
    const ADDRESS_APARTMENT = 'V_FLAT';
    
    public function __construct($data) {
        $this->abonent_fullname = $data[self::ABONENT_FULLNAME];
        $this->abonent_mobile = $data[self::ABONENT_MOBILE];
        $this->abonent_phone = $data[self::ABONENT_PHONE];
        $this->address_apartment = $data[self::ADDRESS_APARTMENT];
        $this->address_home = $data[self::ADDRESS_STREET]." ".$data[self::ADDRESS_HOME];
        $this->contract_balance = $data[self::CONTRACT_BALANCE];
        $this->contract_category = $data[self::CONTRACT_CATEGORY];
        $this->contract_number = $data[self::CONTRACT_NUMBER];
        $this->contract_status = $data[self::CONTRACT_STATUS];
        $this->contract_type = $data[self::CONTRACT_TYPE];
    }
    
}
