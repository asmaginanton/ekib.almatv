<?php

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */


namespace app\models;

use yii\base;

/**
* Class Mfileupload
* @property array $avatar generated filename on server
* @property string $filename source filename from client
*/
class Mfileupload extends base\Model{
    
    public $image;
    public $filename;
    public $avatar;

    public function rules()
    {
        return [
            [['image'], 'safe'],
            [['image'], 'file', 'extensions'=>'jpg, gif, png'],
        ];
    }
    
}
