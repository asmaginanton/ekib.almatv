<?php

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

namespace app\models;

use Yii;
use yii\base;
use yii\base\Model;

/**
 *
 * @author Администратор
 */
class ImportReports extends Model{
    
    const IMPORT_SUCCESS = 'success';
    const IMPORT_ERROR = 'warning';
    const IMPORT_FATAL_ERROR = 'danger';
    
    private $importResult;
    
    public function init() {
        
        $this->importResult = [];
        $this->importResult['status'] = self::IMPORT_ERROR;
        $this->importResult['counter'] = 0;
        $this->importResult[self::IMPORT_SUCCESS] = [];
        $this->importResult[self::IMPORT_ERROR] = [];
        $this->importResult[self::IMPORT_FATAL_ERROR] = [];
        
        parent::init();
        
    }
    
    public function addResult($type, $key, $message){
        if($type != self::IMPORT_SUCCESS && $type != self::IMPORT_ERROR && $type != self::IMPORT_FATAL_ERROR){
            throw new Exception('Не верный тип события');
        }
        
        if($type == self::IMPORT_SUCCESS){
            $this->importResult[self::IMPORT_SUCCESS][] = [$key => $message];}
        if($type == self::IMPORT_ERROR){
            $this->importResult[self::IMPORT_ERROR][] = [$key => $message];}
        if($type == self::IMPORT_FATAL_ERROR){
            $this->importResult[self::IMPORT_FATAL_ERROR][] = [$key => $message];}
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
    
    public function getSuccesses(){
        
        return $this->importResult[self::IMPORT_SUCCESS];
    }
    
    public function getWarnings(){
        return $this->importResult[self::IMPORT_ERROR];
    }
    
    public function getErrors(){
        return $this->importResult[self::IMPORT_FATAL_ERROR];
    }

    public function getImportStatus(){
        
        if($this->importResult[self::IMPORT_FATAL_ERROR] != []){
            $this->importResult['status'] = self::IMPORT_FATAL_ERROR;
            }
        elseif ($this->importResult[self::IMPORT_ERROR] != []) {
            $this->importResult['status'] = self::IMPORT_ERROR;
            }
        else {
            $this->importResult['status'] = self::IMPORT_SUCCESS;
        }
        
        return $this->importResult['status'];
    }
    
    public function isResult(){
        
        if($this->importResult['counter'] > 0) { 
            return $this->importResult['counter'];
        } else { 
            return FALSE;
        }
    }
    
    public function getShortClassName(){
        $str = get_class($this);
        $class_name = end(explode("\\", $str));
        return $class_name;
    }

    public function writeResultToDb($report_name){
        
        $record = new ImportResult();
        $record->type = $report_name;
        $record->date = date('Y-m-d H:i');
        $record->status = $this->getImportStatus();
        $record->executor = Yii::$app->user->identity->username;
        $record->descr = "Success (" . count($this->getSuccesses()) . 
                "), Warning (". count($this->getWarnings())
                ."), Error (". count($this->getErrors())
                .").";
        if($record->validate()){
            $record->save();
        } else {
            throw new \ErrorException(implode("=>", $record->getFirstErrors()));
        }
    }
}
