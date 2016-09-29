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
class ExtendAbonentsReport extends Model{
    
    public $csvFile;
    public $arrayData;
    
    public $importResult;
    

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
        $this->importResult['successes'] = [];
        $this->importResult['errors'] = [];
        $this->importResult['counter'] = 0;

        // загрузка данных
        $this->arrayData = Utilites::csv_to_array($this->csvFile->tempName, self::ENCODING_REQUERE);
        
        foreach ($this->arrayData as $data){
            
            $record = new EARrecord($data);    

            $contract = Contract::find()->where(['number' => $record->contract_number])->one();

            if($contract !== NULL){
                $contract->checkState();
            } else {
                $contract = new Contract();
                $contract->number = $record->contract_number;
                $contract->category = $record->contract_category;
                $contract->type = $record->contract_type;
                $contract->status = $record->contract_status;
                $contract->balance = $record->contract_balance;
                $contract->address_id = Address::getId($record->address_home, $record->address_apartment);
                if(!$contract->address_id)
                    array_push($this->importResult['errors'], [$contract->number => 'Невозможно получить ID дома '.$record->address_home]);
                
                if ($contract->validate()){
                    $contract->save();
                    array_push($this->importResult['successes'], 'Добавлен контракт № '.$contract->number) ;
                } else {
                    array_push($this->importResult['errors'], [$contract->number => $contract->getErrors()]);
                }   
            }
            $this->importResult['counter']++;
        }
        ($this->importResult['errors'] == NULL) ? $this->importResult['status'] = 'успешный' : $this->importResult['status'] = 'есть ошибки!';
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
