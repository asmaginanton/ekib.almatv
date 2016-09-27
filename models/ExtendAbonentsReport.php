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
    public $data;


    public function rules() {
        return [
            ['csvFile', 'file', 'skipOnEmpty' => FALSE],
        ];
    }
    
    public function upload(){
        if($this->validate()){
            // сохранение
            $this->loadData();
            return TRUE;
        } else {
            return FALSE;
        }
    }
    
    private function loadData()
    {
        $filecsv = file($this->csvFile->tempName);
        foreach ($filecsv as $data)
        {
            $row = explode(';', $data);
            $this->data[] = $row;
        }
    }
}
