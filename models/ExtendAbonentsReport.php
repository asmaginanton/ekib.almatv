<?php

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

namespace app\models;

use yii\base\Model;
use yii\web\UploadedFile;
use app\models;
use yii\helpers;

/**
 * Description of ExtendAbonentsReport
 *
 * @author anton.smagin
 */
class ExtendAbonentsReport extends ImportReports{
    
    public $title = "Импорт расширенного отчета по абонентам";
    
    public $csvFile;
    
    public $dump = array();

    const ENCODING_REQUERE = true; // требуется ли перекодировка файла
    
    public function rules() {
        return [
            [['csvFile'], 'file', 'skipOnEmpty' => FALSE],
        ];
    }
    
    public function upload(){
        
        if($this->validate()){

            $span_proc = MyProfiler::Start();
            $this->processing();
            $span_proc->Stop('Processing');
            // пишем результат в БД
            $this->writeResultToDb($this->getShortClassName());
        } else {
            return FALSE;
        }
        
        return TRUE;
    }
    
    private function getDoubles($array){
        $span_convert = MyProfiler::Start();
        
        $counts = array_count_values(
                    array_column($array, 'V_EXT_IDENT')
                );
        $result = array_filter($counts, function ($v){
                    return ($v > 1);
                });
        unset($counts);
        
        $span_convert->Stop('Find doubles');
        return $result;
    }

    private function processing()
    {
        // создаем бэкап таблиц
        DatabaseBackup::Backup($this, 'abonent, home, address');

        // загрузка данных из файла в массив
        $arrayData = Utilites::csv_to_array($this->csvFile->tempName, self::ENCODING_REQUERE);
        
        // ищем дубли контрактов
        $doubles = $this->getDoubles($arrayData);

        // Получаем все контракты с адресами и ФИО абонентов из базы
        $contracts = Contract::getAll();
        
        $this->dump['arrayData'] = current($arrayData);
        $this->dump['doubles'] = $doubles;
        $this->dump['contracts'] = current($contracts);
        
        foreach ($arrayData as $data){
            
            $span_foreach = MyProfiler::Start();
            
            $record = new EARrecord($data);    

            //Проверим не является ли запись дублем
            if(array_key_exists($record->contract_number, $doubles)){
                //Если дубль
                // Обработка !!!!!!!
            }
            
            $contract = helpers\ArrayHelper::remove($contracts, $record->contract_number);
            
            if($contract !== NULL){
                $this->checkContractState($contract, $record);
            } else {
                $this->addContract($record);
            }
            
            $this->addCounter();
            
            $span_foreach->Stop('Foreach array data');
        }
    }
    
    private function addContract(EARrecord $record){
        
        $span_addContract = MyProfiler::Start();
        
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
            $this->addResult(self::IMPORT_ERROR, $contract->number, 'Нет ID дома '.$record->address_home);
        } else {
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
            $contract->address_id = $address->id;
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
            $this->addResult(self::IMPORT_SUCCESS, $record->contract_number, 'Добавлен в базу');
            } else {
            $this->addResults(self::IMPORT_ERROR, $contract->number, $contract->getErrors());
            $this->addResult(self::IMPORT_ERROR, $record->contract_number, 'Контракт не добавлен в базу');
        }
        $span_addContract->Stop('AddContract');
    }
    
    private function checkContractState($contract, EARrecord $record){
        $span_checkContract = MyProfiler::Start();
        
        $span_checkContract->Stop('CheckContract');
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
