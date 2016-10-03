<?php

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

namespace app\models;

use yii\base\Model;

/**
 *
 * @author Администратор
 */
class ImportReports extends Model{
    
    const IMPORT_SUCCESS = 'успешный';
    const IMPORT_ERROR = 'есть ошибки';
    const IMPORT_FATAL_ERROR = 'ошибка!';
    
    private $importResult;
    
    public function init() {
        
        $this->importResult = [];
        $this->importResult['status'] = self::IMPORT_ERROR;
        $this->importResult['counter'] = 0;
        $this->importResult['successes'] = [];
        $this->importResult['warnings'] = [];
        $this->importResult['errors'] = [];
        
        parent::init();
        
    }
    
    public function addResult($type, $key, $message){
        if($type != self::IMPORT_SUCCESS && $type != self::IMPORT_ERROR && $type != self::IMPORT_FATAL_ERROR){
            throw new Exception('Не верный тип события');
        }
        
        if($type == self::IMPORT_SUCCESS){
            array_push ($this->importResult['successes'], [$key => $message]);}
        if($type == self::IMPORT_ERROR){
            array_push ($this->importResult['warnings'], [$key => $message]);}
        if($type == self::IMPORT_FATAL_ERROR){
            array_push ($this->importResult['errors'], [$key => $message]);}
    }
    
    public function addResults($type, $key,array $messages){
        foreach ($messages as $message){
            $this->addResult($type, $key, $message);
        }
    }
    
    public function addCounter(){
        
        $this->importResult['counter']++;
        
    }

    public function getResult(){
        
        $this->getImportStatus();
        
        return $this->importResult;
    }
    
    public function getImportStatus(){
        
        if($this->importResult['errors'] != []){
            $this->importResult['status'] = self::IMPORT_FATAL_ERROR;
            }
        elseif ($this->importResult['warnings'] != []) {
            $this->importResult['status'] = self::IMPORT_ERROR;
            }
        else {
            $this->importResult['status'] = self::IMPORT_SUCCESS;
        }
        
        return $this->importResult['status'];
    }
}
